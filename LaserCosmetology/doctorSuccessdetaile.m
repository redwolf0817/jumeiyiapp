//
//  doctorSuccessdetaile.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "doctorSuccessdetaile.h"
#import "TopBarView.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
@interface doctorSuccessdetaile ()

@end

@implementation doctorSuccessdetaile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"案例详情";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(doctorSuccessCasedatails) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
   // [self soaprequstWithsno:self.sno];
    
    [self creatwebviewAndsno:self.sno];

}
-(void)creatwebviewWithContents:(NSString *)Contents title:(NSString *)title picstr:(NSString *)picstr Remark:(NSString *)Remark
{
    
    UILabel *titlelable = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, [self NSStringwithsize:17 str:title], 20)];
    titlelable.text = title;
    [self.view addSubview:titlelable];
    
    
//    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, self.view.bounds.size.width - 100)];
//    [imagev sd_setImageWithURL:[NSURL URLWithString:picstr]];
//    [self.view addSubview:imagev];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width , self.view.bounds.size.height  - 100 )];
    self.webView.backgroundColor = [UIColor whiteColor];
    //self.webView.//这里一定要设置为NO
    [self.webView setScalesPageToFit:NO];
    [self.view addSubview:self.webView];
    NSString *html_str = Contents;
    
    [self.webView loadHTMLString:html_str baseURL:nil];

}
-(void)creatwebviewAndsno:(NSString *)sno
{
  UIWebView *_webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    
    NSString *strurl = [NSString stringWithFormat:HTTPREQUESTPDOMAIN@"/Front/TextPage/DocSuccessCaseDetail.aspx?caseSno=%@",sno];
    
    NSLog(@"strurl = %@",strurl);
    
    NSURLRequest * req=[NSURLRequest requestWithURL:[NSURL URLWithString:strurl]];
    
    [_webview loadRequest:req];

}

//计算字体长度
-(float)NSStringwithsize:(int )a str:(NSString *)string
{
    
    UIFont *font = [UIFont systemFontOfSize:a];
    
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat strwidth = size.width;
    
    return strwidth;
}
-(void)doctorSuccessCasedatails
{
    if ([self.ReturnRefresh isEqualToString:@"1"]) {
        
        if (self.noti) {
            return;
        }else{
            self.noti = [NSNotificationCenter defaultCenter];
            [self.noti postNotificationName:@"ReturnRefresh" object:nil];
        }

    }
    [self.navigationController popViewControllerAnimated:YES];
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
//获取案例详情
-(void)soaprequstWithsno:(NSString *)sno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorSuccessCaseBySno xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<sno>%@</sno>\n"
                             "</GetDoctorSuccessCaseBySno>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,sno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorSuccessCaseBySno" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    
    NSLog(@"专家数据theXML-%@",theXML);
    
    //NSString *str = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    
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
    
    if ([elementName isEqualToString:@"GetDoctorSuccessCaseBySnoResult"]) {
        
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
    
    
    if ([elementName isEqualToString:@"GetDoctorSuccessCaseBySnoResult"]) {
        // NSLog(@"-_soapResults-%@",_soapResults);
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"案例数据:%@",dic);
        NSMutableArray *doctorSuccessCase = [dic objectForKey:@"doctorSuccessCase"];
        
        NSString *Contents = [[doctorSuccessCase  objectAtIndex:0] objectForKey:@"Contents"];
        // NSString *DoctorSno = [[doctorSuccessCase  objectAtIndex:0] objectForKey:@"DoctorSno"];
         NSString *PicSrc = [[doctorSuccessCase  objectAtIndex:0] objectForKey:@"PicSrc"];
         NSString *Remark = [[doctorSuccessCase  objectAtIndex:0] objectForKey:@"Remark"];
        // NSString *Sno = [[doctorSuccessCase  objectAtIndex:0] objectForKey:@"Sno"];
         NSString *Title = [[doctorSuccessCase  objectAtIndex:0] objectForKey:@"Title"];
        
        [self creatwebviewWithContents:Contents title:Title picstr:PicSrc Remark:Remark];
        
//            Contents = "<p>\U6848\U4f8b001</p><p>\U6848\U4f8b001</p><p>2222</p>";
//            PicSrc = "http://jk.jumeiyiyun.com/Upload/Images/System/nophoto_420x300.jpg";
//            Remark = "\U63cf\U8ff0001";
//            Title = "\U6848\U4f8b001";
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
