//
//  GongNengSheZhi.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "GongNengSheZhi.h"
#import "TopBarView.h"
#import "PrefixHeader.pch"
@interface GongNengSheZhi ()

@end

@implementation GongNengSheZhi

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"功能设置";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(GOTOBACK) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    imageview.image = [UIImage imageNamed:@"huidi"];
    imageview.userInteractionEnabled = YES;
    [self.view addSubview:imageview];
    
    
    
    
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
    self.doctorsno = [userdf objectForKey:@"customerSno"];
    
    [self soaprequstWithdoctorSno:self.doctorsno];
}

-(void)creatshat
{

    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 74, self.view.bounds.size.width - 20, 100)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 60, 20)];
    lable1.text = @"预约:";
    [view1 addSubview:lable1];
    
    NSArray *btntitleary;
    if ([self.IsOpenToOtherCus isEqualToString:@"0"]) {
         btntitleary = [[NSArray alloc] initWithObjects:@"功能设置_都可以灰",@"功能设置_老客户", nil];
    }else{
         btntitleary = [[NSArray alloc] initWithObjects:@"功能设置_都可以",@"功能设置_老客户灰", nil];
    }
   
    NSArray *btntitleary2;//开启
    if ([self.OpenTalkType isEqualToString:@"150324165631338"]) {
        btntitleary2 = [[NSArray alloc] initWithObjects:@"功能设置_都可以",@"功能设置_老客户灰", nil];
    }else{
        btntitleary2 = [[NSArray alloc] initWithObjects:@"功能设置_都可以灰",@"功能设置_老客户", nil];
    }
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(view1.bounds.size.width * 0.30  + ((self.view.bounds.size.width/4 + (view1.bounds.size.width * 0.10) * i)) * i, 30, self.view.bounds.size.width/4, 30)];
        [btn setBackgroundImage:[UIImage imageNamed:[btntitleary objectAtIndex:i]]  forState:UIControlStateNormal];
        btn.tag = 5 + i;
        [btn addTarget:self action:@selector(upbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:btn];
    }
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 184, self.view.bounds.size.width - 20, 100)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 100, 20)];
    lable2.text = @"在线咨询:";
    [view2 addSubview:lable2];
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(view2.bounds.size.width * 0.30  + ((self.view.bounds.size.width/4 + (view2.bounds.size.width * 0.10) * i)) * i, 30, self.view.bounds.size.width/4, 30)];
        [btn setBackgroundImage:[UIImage imageNamed:[btntitleary2 objectAtIndex:i]]  forState:UIControlStateNormal];
        btn.tag = 10 + i;
        [btn addTarget:self action:@selector(dowmbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:btn];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)GOTOBACK
{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)upbtnclick:(UIButton *)btn
{
    if (btn.tag == 5) {
        if ([self.IsOpenToOtherCus isEqualToString:@"0"]) {
            [btn setBackgroundImage:[UIImage imageNamed:@"功能设置_都可以"] forState:UIControlStateNormal];
            UIButton *button = (UIButton *)[self.view viewWithTag:6];
            [button setBackgroundImage:[UIImage imageNamed:@"功能设置_老客户灰"] forState:UIControlStateNormal];
            self.IsOpenToOtherCus = @"1";
        }else{
            
            [btn setBackgroundImage:[UIImage imageNamed:@"功能设置_都可以灰"] forState:UIControlStateNormal];
            UIButton *button = (UIButton *)[self.view viewWithTag:6];
            [button setBackgroundImage:[UIImage imageNamed:@"功能设置_老客户"] forState:UIControlStateNormal];
            self.IsOpenToOtherCus = @"0";
        
        }

    }else{
    
        if ([self.IsOpenToOtherCus isEqualToString:@"0"]) {
            [btn setBackgroundImage:[UIImage imageNamed:@"功能设置_老客户灰"] forState:UIControlStateNormal];
            UIButton *button = (UIButton *)[self.view viewWithTag:5];
            [button setBackgroundImage:[UIImage imageNamed:@"功能设置_都可以"] forState:UIControlStateNormal];
            self.IsOpenToOtherCus = @"1";
        }else{
            
            [btn setBackgroundImage:[UIImage imageNamed:@"功能设置_老客户"] forState:UIControlStateNormal];
            UIButton *button = (UIButton *)[self.view viewWithTag:5];
            [button setBackgroundImage:[UIImage imageNamed:@"功能设置_都可以灰"] forState:UIControlStateNormal];
            self.IsOpenToOtherCus = @"0";
            
        }
    }
    if ([self.IsOpenToOtherCus isEqualToString:@"0"]) {
         [self soaprequst2WithdoctorSno:self.doctorsno isOpen:@"0"];   NSLog(@"发送了可以在线沟通");
    }else{
        [self soaprequst2WithdoctorSno:self.doctorsno isOpen:@"1"];  NSLog(@"发送了不可以在线沟通");
    }
    
   
}
-(void)dowmbtnclick:(UIButton *)btn
{
    if (btn.tag == 10) {
        if ([self.OpenTalkType isEqualToString:@"150324165631338"]) {
            [btn setBackgroundImage:[UIImage imageNamed:@"功能设置_都可以灰"] forState:UIControlStateNormal];
            UIButton *button = (UIButton *)[self.view viewWithTag:11];
            [button setBackgroundImage:[UIImage imageNamed:@"功能设置_老客户"] forState:UIControlStateNormal];
            self.OpenTalkType = @"150324165722007";
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"功能设置_都可以"] forState:UIControlStateNormal];
            UIButton *button = (UIButton *)[self.view viewWithTag:11];
            [button setBackgroundImage:[UIImage imageNamed:@"功能设置_老客户灰"] forState:UIControlStateNormal];
            self.OpenTalkType = @"150324165631338";
        }
        
    }else{
        if ([self.OpenTalkType isEqualToString:@"150324165631338"]) {
            [btn setBackgroundImage:[UIImage imageNamed:@"功能设置_老客户"] forState:UIControlStateNormal];
            UIButton *button = (UIButton *)[self.view viewWithTag:10];
            [button setBackgroundImage:[UIImage imageNamed:@"功能设置_都可以灰"] forState:UIControlStateNormal];
            self.OpenTalkType = @"150324165722007";
        }else{
            
            [btn setBackgroundImage:[UIImage imageNamed:@"功能设置_老客户灰"] forState:UIControlStateNormal];
            UIButton *button = (UIButton *)[self.view viewWithTag:10];
            [button setBackgroundImage:[UIImage imageNamed:@"功能设置_都可以"] forState:UIControlStateNormal];
            self.OpenTalkType = @"150324165631338";
        }
    }
    
    if ([self.OpenTalkType isEqualToString:@"150324165722007"]) {
        [self soaprequstWithdoctorSno:self.doctorsno isOpen:@"0"];
    }else{
        [self soaprequstWithdoctorSno:self.doctorsno isOpen:@"1"];
    }

}

#pragma mark -- soap请求
//预约之前数据
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno
{
   
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorDetailData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "</GetDoctorDetailData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorDetailData" forHTTPHeaderField:@"SOAPAction"];
    
    
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

//医生设置-在线沟通功能是否开放 (isOpen1是/0否)
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno isOpen:(NSString *)isOpen
{
    NSLog(@"doctorSno--%@--isOpen--%@",doctorSno,isOpen);
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SetOpenTalk xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<isOpen>%@</isOpen>\n"
                             "</SetOpenTalk>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,isOpen];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SetOpenTalk" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//医生设置-是否对所有客户开放预约 (isOpen1是/0否)
-(void)soaprequst2WithdoctorSno:(NSString *)doctorSno isOpen:(NSString *)isOpen
{
     NSLog(@"doctorSno--%@--isOpen--%@",doctorSno,isOpen);
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SetOpenToOtherCus xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<isOpen>%@</isOpen>\n"
                             "</SetOpenToOtherCus>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,isOpen];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SetOpenToOtherCus" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    NSLog(@"11完善资料的数据--%@",theXML);
    
    //        NSString *str = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    //
    //
    //             NSLog(@"请求回来的数据-2--%@",str);
    
    //重新加載xmlParser
    //    if( xmlParser )
    //    {
    //       // [xmlParser release];
    //    }
    
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
    
    // [connection release];
    //[webData release];
}

#pragma mark - XML数据接收
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"SetOpenTalkResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"SetOpenToOtherCusResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"GetDoctorDetailDataResult"]) {
        
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
    
    if ([elementName isEqualToString:@"SetOpenTalkResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"22完善资料的数据：dic%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        
        NSString *msg = [dic objectForKey:@"msg"];
        
      
        
        if ([state isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"设置成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
    }
    
    
    if ([elementName isEqualToString:@"SetOpenToOtherCusResult"]) {
        
        
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"22完善资料的数据：dic%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        
        NSString *msg = [dic objectForKey:@"msg"];
        
        
        
        if ([state isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"设置成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
    }
    
    
    if ([elementName isEqualToString:@"GetDoctorDetailDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"请求之前的数据：dic%@",dic);
        NSMutableArray *doctorData = [dic objectForKey:@"doctorData"];
        for (NSDictionary *datadic in doctorData) {
           self.IsOpenToOtherCus = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"IsOpenToOtherCus"]];
             self.OpenTalkType = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"OpenTalkType"]];
            self.PhoneNo = [NSString stringWithFormat:@"%@",[datadic objectForKey:@"PhoneNo"]];
             self.TrueName = [datadic objectForKey:@"TrueName"];
           
        }
        [self creatshat];
        

    }

}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------start--------------");
    
    // 创建一个可变字符串
    _soapResults = [[NSMutableString alloc] initWithCapacity:0];//解析开始了，创建空字符串来存
    
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------end--------------");
    
}


@end
