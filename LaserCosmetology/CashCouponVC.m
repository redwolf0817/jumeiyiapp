//
//  CashCouponVC.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/21.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "CashCouponVC.h"
#import "TopBarView.h"
#import "CashCouponVCCell.h"
#import "daijinquan.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
@interface CashCouponVC ()

@end

@implementation CashCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height )];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 120, 25)];
    titilelable.text = @"现金券";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttontoclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    NSArray *btntitle = [[NSArray alloc] initWithObjects:@"待领取",@"未使用",@"已过期",nil];
    float btnwidth = (self.view.bounds.size.width - 25)/3;
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((5 + btnwidth) * i + 5, 75, btnwidth, 30)];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitle:[btntitle objectAtIndex:i] forState:UIControlStateNormal];
        if (i == 0) {
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        btn.backgroundColor = [UIColor whiteColor];
        //[btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn addTarget:self action:@selector(shooosebutton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 20 + i;
        [self.view addSubview:btn];
    }
    
    
    
    _daijinquan = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height - 110)];
    _daijinquan.delegate = self;
    _daijinquan.dataSource = self;
    [self.view addSubview:_daijinquan];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.cusSno = [user objectForKey:@"customerSno"];
    
    [self soaprequestwithstrPageindex:@"1" strPagesize:@"40"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backbuttontoclick
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)shooosebutton:(UIButton *)btn
{

    if (btn.tag == 20) {//待领取
        self.isguoqi = NO;
        [self soaprequestwithstrPageindex:@"1" strPagesize:@"40"];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:21];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIButton *btn2 = (UIButton *)[self.view viewWithTag:22];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }else if (btn.tag == 21){//未使用
        self.isguoqi = NO;
        [self soaprequestwithcustomerSno:self.cusSno strPageindex:@"" strPagesize:@"40" typeNo:@"1"];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:20];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIButton *btn2 = (UIButton *)[self.view viewWithTag:22];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{//已过期
        self.isguoqi = YES;
    [self soaprequestwithcustomerSno:self.cusSno strPageindex:@"" strPagesize:@"40" typeNo:@"2"];
        
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:20];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIButton *btn2 = (UIButton *)[self.view viewWithTag:21];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }


}
#pragma mark ---uitableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _couponDataarray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    CashCouponVCCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CashCouponVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.jine.text = @"";
    cell.qixian.text = @"";
    cell.date.text = @"";
    cell.xiangmuleibie.text = @"";
    
    daijinquan *dajin = [_couponDataarray objectAtIndex:indexPath.row];
    
    [cell.erweima sd_setImageWithURL:[NSURL URLWithString:dajin.PicSrc]];
    cell.xiangmuleibie.text = [NSString stringWithFormat:@"(%@)",dajin.Name];
    
    if (![dajin.Price isEqualToString: @""] && dajin.Price != nil) {
        cell.jine.text = [NSString stringWithFormat:@"%@元",dajin.Price];
    }else{
    cell.jine.text = @"";
    }
    
    cell.laokehu.frame = CGRectMake(200, 10, 140, 20);
    
    if (dajin.CouponName) {
        
        [cell.erweima sd_setImageWithURL:[NSURL URLWithString:dajin.CouponPicUrl]];
        cell.erweima.frame = CGRectMake(200, 30, 80, 80);
        cell.xiangmuleibie.text = [NSString stringWithFormat:@"(%@)",dajin.CouponName];
        if (![dajin.Amoumt isEqualToString: @""] && dajin.Amoumt != nil) {
            cell.jine.text = [NSString stringWithFormat:@"%@元",dajin.Amoumt];
           
        }else{
        cell.jine.text = @"";
        }
        cell.qixian.text = @"使用期限:";
        cell.date.text = dajin.EndDate;
        
    }
    if (self.isguoqi == NO) {
        cell.redimage.image = [UIImage imageNamed:@"youhuiquanhongse"];
        cell.laokehu.textColor = [UIColor redColor];
        cell.redimage.frame = CGRectMake(0, 0, 200, 120);
    }else{
        cell.laokehu.textColor = [UIColor blackColor];
    cell.redimage.image = [UIImage imageNamed:@"youhuiquanheise"];
        cell.redimage.frame = CGRectMake(0, 0, 200, 120);
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

#pragma mark---- SOAP请求
//获取可领优惠券数据
-(void)soaprequestwithstrPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCouponData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetCouponData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,strPageindex,strPagesize];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCouponData" forHTTPHeaderField:@"SOAPAction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"post"];//这个有时候可以换一下一种请求方式，不然请求方式错了返回的是HTML格式的代码而且得不到返回值
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    //如果连接已经建好，则初始化data
    if( theConnection )
    {
        //webData = [[NSMutableData data] retain];
        webData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
    
}
//获取用户优惠券数据,typeNo券类型(1可使用,2已过期)
-(void)soaprequestwithcustomerSno:(NSString *)customerSno strPageindex:(NSString *)strPageindex strPagesize:(NSString *) strPagesize typeNo:(NSString *)typeNo
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerCouponData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<strPageindex>%@</strPageindex>\n"
                              "<strPagesize>%@</strPagesize>\n"
                              "<typeNo>%@</typeNo>\n"
                             "</GetCustomerCouponData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,strPageindex,strPagesize,typeNo];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerCouponData" forHTTPHeaderField:@"SOAPAction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"post"];//这个有时候可以换一下一种请求方式，不然请求方式错了返回的是HTML格式的代码而且得不到返回值
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    //如果连接已经建好，则初始化data
    if( theConnection )
    {
        //webData = [[NSMutableData data] retain];
        webData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
    
}

//客户领取优惠券
-(void)soaprequestwithcustomerSno:(NSString *)customerSno couponSno:(NSString *)couponSno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<AddCusstomerCoupon xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<couponSno>%@</couponSno>\n"
                             "</AddCusstomerCoupon>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,couponSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/AddCusstomerCoupon" forHTTPHeaderField:@"SOAPAction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"post"];//这个有时候可以换一下一种请求方式，不然请求方式错了返回的是HTML格式的代码而且得不到返回值
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    //如果连接已经建好，则初始化data
    if( theConnection )
    {
        //webData = [[NSMutableData data] retain];
        webData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark SOAP请求方法
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
    NSHTTPURLResponse *urlresponse = (NSHTTPURLResponse *)response;
    NSLog(@"状态码----》%ld",(long)[urlresponse statusCode]);
    NSLog(@"响应头部信息---》%@",[urlresponse allHeaderFields]);
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
    //NSLog(@"connection: didReceiveData:2");
    
}

//如果电脑没有连接网络，则出现此信息（不是网络服务器不通）
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
    //    [connection release];
    //    [webData release];
    // NSLog(@"ERROR with theConenction");
    UIAlertView * alert =
    [[UIAlertView alloc]
     initWithTitle:@"提示"
     message:@"链接超时或无网络!"
     delegate:self
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil];
    [alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // NSLog(@"3 DONE. Received Bytes: %ld", [webData length]);
    
    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSLog(@"写美容日记--%@",theXML);
    
    
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
    
    //    [connection release];
    //[webData release];
}
#pragma mark - XML数据接收
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"GetCouponDataResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"GetCustomerCouponDataResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
}

// 找到内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // 如果内容太长,会分多次去读,这里需要拼接(追加)
    [_soapResults appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"GetCouponDataResult"]) {//待领取金券
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"待领取金券的数据:%@",dic);
        
        
        NSMutableArray *couponData = [dic objectForKey:@"couponData"];
        _couponDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in couponData) {
            daijinquan *daijin = [daijinquan daijinquanWithdiction:diction];
            [_couponDataarray addObject:daijin];
        }
        [_daijinquan reloadData];
    }
    
    
    if ([elementName isEqualToString:@"GetCustomerCouponDataResult"]) {//未过期优惠券
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"未过期金券的数据:%@",dic);
        
        NSMutableArray *couponData = [dic objectForKey:@"couponData"];
        _couponDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in couponData) {
            daijinquan *daijin = [daijinquan daijinquanWithdiction:diction];
            [_couponDataarray addObject:daijin];
        }
        [_daijinquan reloadData];
        
    }

    
}
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------start--------------");
    
    // 创建一个可变字符串
    _soapResults = [[NSMutableString alloc] initWithCapacity:0];//解析要开始了，创建空字符串来存
    
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------end--------------");
}

@end
