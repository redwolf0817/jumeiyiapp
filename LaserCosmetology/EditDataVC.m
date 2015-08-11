//
//  EditDataVC.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/3.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "EditDataVC.h"
#import "TopBarView.h"
#import "persens.h"
#import "UIButton+WebCache.h"
#import "PrefixHeader.pch"EditDataVC
@interface EditDataVC ()

@end

@implementation EditDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 180, 25)];
    titilelable.text = @"完善个人资料";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(bjbackbuttonclickw) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    

    
    _headimage = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 60, 80, 120, 120)];
    _headimage.backgroundColor = [UIColor clearColor];
    _headimage.layer.masksToBounds = YES;
    _headimage.layer.cornerRadius = 60;
    [_headimage addTarget:self action:@selector(upimagedatawithhead) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headimage];
    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/3, 80 + 124, self.view.bounds.size.width/3, 20)];
    lable.text = @"点击头像编辑";
    lable.alpha = 0.5;
    [self.view addSubview:lable];
    
    UIImageView *heangxian = [[UIImageView alloc] initWithFrame:CGRectMake(0, lable.frame.origin.y + 30, self.view.bounds.size.width, 1)];
    heangxian.image = [UIImage imageNamed:@"hengxian"];
    [self.view addSubview:heangxian];
    
    UILabel *namelable = [[UILabel alloc] initWithFrame:CGRectMake(10, heangxian.frame.origin.y + 20, 60, 20)];
    namelable.text = @"* 姓名:";
    [self.view addSubview:namelable];
    
    _nametextf = [[UITextField alloc] initWithFrame:CGRectMake(65, heangxian.frame.origin.y + 18, 90, 25)];
    _nametextf.backgroundColor = [UIColor whiteColor];
    _nametextf.layer.masksToBounds = YES;
    _nametextf.layer.cornerRadius = 2;
    [self.view addSubview:_nametextf];
    
    UILabel *sexlable = [[UILabel alloc] initWithFrame:CGRectMake(170, heangxian.frame.origin.y + 20, 60, 20)];
    sexlable.text = @"* 性别:";
    [self.view addSubview:sexlable];
    
    _sexsegm = [[UISegmentedControl alloc] initWithItems:@[@"男",@"女"]];
    _sexsegm.frame = CGRectMake(230, heangxian.frame.origin.y + 18, 70, 25);
    _sexsegm.selectedSegmentIndex = 1;
    [_sexsegm addTarget:self action:@selector(sexsegmshoose:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_sexsegm];
     self.sexType = @"0";
    
    UIImageView *heangxian2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, heangxian.frame.origin.y + 60, self.view.bounds.size.width, 1)];
    heangxian2.image = [UIImage imageNamed:@"hengxian"];
    [self.view addSubview:heangxian2];
    
    UILabel *year = [[UILabel alloc] initWithFrame:CGRectMake(10, heangxian2.frame.origin.y + 20, 60, 20)];
    year.text = @"* 年龄:";
    [self.view addSubview:year];
    
    NSArray *btntitleary = [[NSArray alloc] initWithObjects:@"25岁以下",@"25~30",@"31~35",@"36~40",@"41~45",@"46以上", nil];
    float btnwide = (self.view.bounds.size.width - 110)/3;
    for (int i = 0; i < 6; i++) {
        NSInteger y1 = i/3;
        NSInteger x1 =  i % 3;
        float x = x1 * (btnwide + 10) + 70;
        float y = y1 * 32 + (heangxian2.frame.origin.y + 20);
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, btnwide, 25)];
        [btn setTitle:[btntitleary objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = i + 10;
        [btn addTarget:self action:@selector(SHOOSEage:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    UIImageView *heangxian3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, heangxian2.frame.origin.y + 100, self.view.bounds.size.width, 1)];
    heangxian3.image = [UIImage imageNamed:@"hengxian"];
    [self.view addSubview:heangxian3];
    
    UIButton *qued = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 70, self.view.bounds.size.height - 80, 140, 35)];
    [qued setTitle:@"确定" forState:UIControlStateNormal];
    [qued setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    [qued addTarget:self action:@selector(updatewithrequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qued];
    
    self.fileTypeName = @"";
    
    [self soaprequestwithcustomerSno:self.customerSno];

}
-(void)changevalue
{
    persens *per = [_customerDataary objectAtIndex:0];
    
    _nametextf.text = per.Name;

    if ([per.AgeType isEqualToString:@"150603114228871"]) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:10];
       [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else if ([per.AgeType isEqualToString:@"150603114302633"]){
        UIButton *btn = (UIButton *)[self.view viewWithTag:11];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else if ([per.AgeType isEqualToString:@"150603114333287"]){
        UIButton *btn = (UIButton *)[self.view viewWithTag:12];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else if ([per.AgeType isEqualToString:@"150603114418103"]){
        UIButton *btn = (UIButton *)[self.view viewWithTag:13];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else if ([per.AgeType isEqualToString:@"150603114430779"]){
        UIButton *btn = (UIButton *)[self.view viewWithTag:14];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
        UIButton *btn = (UIButton *)[self.view viewWithTag:15];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    if ([per.SexType isEqualToString:@"1"]) {
        _sexsegm.selectedSegmentIndex = 0;
    }else{
    _sexsegm.selectedSegmentIndex = 1;
    }
   
    [_headimage sd_setBackgroundImageWithURL:[NSURL URLWithString:per.PicSrc] forState:UIControlStateNormal];
        
    
}
-(void)bjbackbuttonclickw
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)SHOOSEage:(UIButton *)btn
{
    
    for (int i = 0; i < 6; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:10 + i];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    if (btn.tag == 10) {
        self.ageType = @"150603114228871";
    }else if (btn.tag == 11){
        self.ageType = @"150603114302633";
    }else if (btn.tag == 12){
        self.ageType = @"150603114333287";
    }else if (btn.tag == 13){
        self.ageType = @"150603114418103";
    }else if (btn.tag == 14){
        self.ageType = @"150603114430779";
    }else{
        self.ageType = @"150603114447913";
    }
    
    
}
-(void)sexsegmshoose:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0) {
       self.sexType = @"1";
    }else{
    self.sexType = @"0";
    }

}
-(void)upimagedatawithhead
{
    pickerimageViewController *pike = [[pickerimageViewController alloc] init];
    pike.delegate1 = self;
    [self.navigationController pushViewController:pike animated:YES];
}
-(void)sendimage:(UIImage *)imagess{
    
    [_headimage setBackgroundImage:imagess forState:UIControlStateNormal];
    
    NSData *_data = UIImageJPEGRepresentation(imagess, 0.4f);
    NSString *_encodedImageStr = [_data base64Encoding];
    self.imagedata = _encodedImageStr;
    
    self.fileTypeName = @"png";
}
-(void)updatewithrequest
{
    self.trueName = _nametextf.text;
    if (self.imagedata == nil) {
        self.imagedata = @"";
       
    }
    
    [self soaprequestwithcustomerSno:self.customerSno data:self.imagedata fileTypeName:self.fileTypeName trueName:self.trueName sexType:self.sexType ageType:self.ageType];
}
#pragma mark---- SOAP请求
//获取客户资料设置界面数据
-(void)soaprequestwithcustomerSno:(NSString *)customerSno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerDetailPageData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "</GetCustomerDetailPageData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerDetailPageData" forHTTPHeaderField:@"SOAPAction"];
    
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
//提交客户资料数据
-(void)soaprequestwithcustomerSno:(NSString *)customerSno data:(NSString *)data fileTypeName:(NSString *)fileTypeName trueName:(NSString *)trueName sexType:(NSString *)sexType ageType:(NSString *)ageType
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SetCustomerDetailData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<data>%@</data>\n"
                             "<fileTypeName>%@</fileTypeName>\n"
                             "<trueName>%@</trueName>\n"
                             "<sexType>%@</sexType>\n"
                             "<ageType>%@</ageType>\n"
                             "</SetCustomerDetailData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,data,fileTypeName,trueName,sexType,ageType];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SetCustomerDetailData" forHTTPHeaderField:@"SOAPAction"];
    
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
    
    
    
    if ([elementName isEqualToString:@"GetCustomerDetailPageDataResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"SetCustomerDetailDataResult"]) {
        
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
    
    
    if ([elementName isEqualToString:@"GetCustomerDetailPageDataResult"]) {//获取本页信息
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"获取的数据:%@",dic);
        NSMutableArray *customerData = [dic objectForKey:@"customerData"];
        _customerDataary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *perdiction in customerData) {
            persens *per = [persens persensWithdictionary:perdiction];
            [_customerDataary addObject:per];
        }

        [self changevalue];
    }
    
    
    if ([elementName isEqualToString:@"SetCustomerDetailDataResult"]) {//获取本页信息
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"个人资料提交:%@",dic);
        
        NSString *msg = [dic objectForKey:@"msg"];
         NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }

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
