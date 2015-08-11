//
//  Detailsproject.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "Detailsproject.h"
#import "TopBarView.h"
#import "ExperttorListsViewController.h"
#import "xiangmuxiangqing.h"
#import "UIImageView+WebCache.h"
#import "MakeAppointment.h"
#import "YuYueShiJianBiaoShuJu.h"
#import "yuyuexiandeqingqiu.h"
#import "mybutton.h"
#import "PrefixHeader.pch"
@interface Detailsproject ()

@end

@implementation Detailsproject

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
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 300, 25)];
    titilelable.text = self.EnumName;
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];

    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];

    
    UIButton *finddoctor = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 75,self.view.bounds.size.height - 50, 150, 35)];
    [finddoctor setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    [finddoctor setTitle:@"预约专家" forState:UIControlStateNormal];
    [finddoctor addTarget:self action:@selector(findoctorbtnclick) forControlEvents:UIControlEventTouchUpInside];
    finddoctor.layer.masksToBounds = YES;
    finddoctor.layer.cornerRadius = 5;
    [self.view addSubview:finddoctor];
    
    
    [self soaprequstWithsno:self.sno];
    
    NSLog(@"在医生详情页面获取的-self.HospitalName-%@",self.hostitalname);
}


-(void)creatwebview
{
    

    NSString *urlstr = [NSString stringWithFormat:HTTPREQUESTPDOMAIN@"/Front/TextPage/MrTextPage.aspx?productSno=%@",self.sno];
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width , self.view.bounds.size.height  - 74 - 60)];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    NSURLRequest * req=[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [_webview loadRequest:req];
    

}

#pragma mark 按钮点击事件

-(void)backbuttonclick
{
    [self.navigationController popViewControllerAnimated:YES];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//计算字符串的长度值
-(float)NSStringwithfont:(int )a AndNSString:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:a];
    
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat nameW = size.width;
    
    return nameW;
}

-(void)findoctorbtnclick
{
    NSLog(@"找医生");
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *iscustomer =[user objectForKey:@"CommomUserORCommomDoctor"];
    
    if ([iscustomer isEqualToString:@"CommomUser"]) {
        NSLog(@"是否进来CommomUser");
        ExperttorListsViewController *experttor = [[ExperttorListsViewController alloc] init];
        experttor.beautifySno = self.sno;
        [self.navigationController pushViewController:experttor  animated:YES];
        
        
    }else{
        
         NSLog(@"是否进来CommomDoctor");
        UIAlertView *alerter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您不是客户，请去个人中心登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alerter show];
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
#pragma mark --SOAP请求
//获取项目详情
-(void)soaprequstWithsno:(NSString *)sno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetBeautifyProductBySno xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<sno>%@</sno>\n"
                             "</GetBeautifyProductBySno>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW
                             ,sno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetBeautifyProductBySno" forHTTPHeaderField:@"SOAPAction"];
    
    
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
     message:@"链接超时"
     delegate:self
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil];
    [alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // NSLog(@"3 DONE. Received Bytes: %ld", [webData length]);
    //NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
      // NSLog(@"美容项目详情请求回来的数据--%@",theXML);
    
    
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
    
    
    
    
    if ([elementName isEqualToString:@"GetBeautifyProductBySnoResult"]) {
        
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
    
    if ([elementName isEqualToString:@"GetBeautifyProductBySnoResult"]) {
        //   NSLog(@"_soapResults-AAAAAAA------------------------:%@AAAAAAA------------------------:",_soapResults);
        
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
           NSLog(@"项目详情：dic%@",dic);
        
        //        NSString *state = [dic objectForKey:@"state"];
        //
        //        NSString *msg = [dic objectForKey:@"msg"];
        //
        //        NSString *total = [dic objectForKey:@"total"];
        
        
        NSMutableArray *ProData = [dic objectForKey:@"ProData"];
        _ProDataary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in ProData) {
            xiangmuxiangqing *xiangmu = [xiangmuxiangqing xiangmuxiangqingWithnsdiction:diction];
            [_ProDataary addObject:xiangmu];
        }
        [self creatwebview];
        
        NSMutableArray *beautifyProductCaseData = [dic objectForKey:@"beautifyProductCaseData"];
        _beautifyProductCaseDataaary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in beautifyProductCaseData) {
            xiangmuxiangqing *xiangmu = [xiangmuxiangqing xiangmuxiangqingWithnsdiction:diction];
            [_beautifyProductCaseDataaary addObject:xiangmu];
        }
        
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
