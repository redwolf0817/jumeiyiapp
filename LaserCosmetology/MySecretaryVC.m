//
//  MySecretaryVC.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/4.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "MySecretaryVC.h"
#import "TopBarView.h"
#import "mishutixing.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
@interface MySecretaryVC ()

@end

@implementation MySecretaryVC

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
    titilelable.text = @"我的秘书";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclick1) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    // 年月日获得
    comps =[calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay)
                       fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    self.noticeDt = [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
    
    
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(10, 110, self.view.bounds.size.width - 20, self.view.bounds.size.height  - 110 - 20)];
    backview.backgroundColor = [UIColor grayColor];
    background.alpha = 0.25;
    [background addSubview:backview];
    
    

    if (self.doctorSno == nil || self.orderDetailSno == nil || self.strPageindex == nil || self.strPagesize == nil ) {
        self.doctorSno = @"";   self.orderDetailSno = @"";  self.strPageindex = @"1";  self.strPagesize = @"20";
    }
    
    NSLog(@"self.doctorSno ：%@ ---self.customerSno-:%@--self.orderDetailSno-:%@--self.noticeDt:-%@--self.strPageindex:%@---self.strPagesize-:%@-",self.doctorSno,self.customerSno,self.orderDetailSno,self.noticeDt,self.strPageindex,self.strPagesize);
    
    [self soaprequestwithdoctorSno:self.doctorSno customerSno:self.customerSno orderDetailSno:self.orderDetailSno noticeDt:self.noticeDt strPageindex:self.strPageindex strPagesize:self.strPagesize];
    

    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:@"0" forKey:@"ishaver"];
    [def synchronize];
}
-(void)creatcontens
{
    NSLog(@"_mishudataary.count-%ld",_mishudataary.count);
    
    mishutixing *mishu = nil;
    if (_mishudataary.count > 0) {
         mishu = [_mishudataary objectAtIndex:0];
    }
    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, 120, 20)];
    lable.text = mishu.CustomerName;
    lable.textColor = [UIColor colorWithRed:0/255 green:197/255 blue:187/255 alpha:1];
    [self.view addSubview:lable];
    
//    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 115, self.view.bounds.size.width - 10, 180)];
//    [imageview sd_setImageWithURL:[NSURL URLWithString:mishu.PicSrc]];
//    [self.view addSubview:imageview];
    
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(15, 110, self.view.bounds.size.width - 10, self.view.bounds.size.height - 110 - 20)];
    textview.backgroundColor = [UIColor clearColor];
    textview.text = mishu.TextInfo;
    [self.view addSubview:textview];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击事件


-(void)backbuttonclick1
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
#pragma mark---- SOAP请求
//秘书提醒
-(void)soaprequestwithdoctorSno:(NSString *)doctorSno customerSno:(NSString *)customerSno orderDetailSno:(NSString *)orderDetailSno noticeDt:(NSString *)noticeDt strPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerBeautifyOrderNoticeData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<orderDetailSno>%@</orderDetailSno>\n"
                             "<noticeDt>%@</noticeDt>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetCustomerBeautifyOrderNoticeData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,customerSno,orderDetailSno,noticeDt,strPageindex,strPagesize];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerBeautifyOrderNoticeData" forHTTPHeaderField:@"SOAPAction"];
    
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
    
    if ([elementName isEqualToString:@"GetCustomerBeautifyOrderNoticeDataResult"]) {
        
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
    
    if ([elementName isEqualToString:@"GetCustomerBeautifyOrderNoticeDataResult"]) {//获取本页信息
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"秘书提醒的数据:%@",dic);
        
        NSMutableArray *ret = [dic objectForKey:@"ret"];
        _mishudataary = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[dic objectForKey:@"state"] isEqualToString:@"0"]) {
            return;
        }
        for (NSDictionary *diction in ret) {
            mishutixing *mishu = [mishutixing mishuwithdata:diction];
            [_mishudataary addObject:mishu];
        }
        
        [self creatcontens];
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
