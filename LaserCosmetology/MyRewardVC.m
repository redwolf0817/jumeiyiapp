//
//  MyRewardVC.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/4.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "MyRewardVC.h"
#import "TopBarView.h"
#import "JiangLi.h"
#import "PrefixHeader.pch"
@interface MyRewardVC ()

@end

@implementation MyRewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self soaprequestwithcustomerSno:self.mycustomerSno];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"我的奖励";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    

    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclickw) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - self.view.bounds.size.width * 0.421/2, self.view.bounds.size.height * 0.221, self.view.bounds.size.width * 0.421, self.view.bounds.size.width * 0.421)];
    imagev.image = [UIImage imageNamed:@"jinbi_03"];
    imagev.layer.masksToBounds = YES;
    imagev.layer.cornerRadius = self.view.bounds.size.width * 0.421/2;
    [self.view addSubview:imagev];
    
    
    UIButton *tiqu = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 80, self.view.bounds.size.height - 80, 160, 40)];
    [tiqu setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    [tiqu addTarget:self action:@selector(tiquclick) forControlEvents:UIControlEventTouchUpInside];
    [tiqu setTitle:@"提取" forState:UIControlStateNormal];
    tiqu.layer.masksToBounds = YES;
    tiqu.layer.cornerRadius = 4;
    [topbar addSubview:tiqu];
    
}
-(void)creatlablewithjiangli
{
    JiangLi *jl = [self.jlarray objectAtIndex:0];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2, self.view.bounds.size.height * 0.515 - 10, self.view.bounds.size.width - (self.view.bounds.size.width * 0.4), 100)];
    lable.numberOfLines = 0;
    lable.text = [NSString stringWithFormat:@"恭喜您 ！于%@获得%@奖励！",jl.lastGetDate,jl.lastGetAmoumt];
    lable.textColor = [UIColor redColor];
    [self.view addSubview:lable];

}
-(void)creatcountwithjiangli
{
    JiangLi *jl = [self.jlarray objectAtIndex:0];
    
    UILabel *amount = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - self.view.bounds.size.width * 0.421/2, self.view.bounds.size.height * 0.7, 40, 20)];
    amount.text = @"总计:";
    [self.view addSubview:amount];

    float a = [self NSStringwithsize:17 str:amount.text];
    UILabel *shuliang = [[UILabel alloc] initWithFrame:CGRectMake(a + self.view.bounds.size.width/2 - self.view.bounds.size.width * 0.421/2, self.view.bounds.size.height * 0.7, [self NSStringwithsize:17 str:jl.commissionTotalAmoumt], 20)];
    shuliang.text = jl.commissionTotalAmoumt;
    shuliang.textColor = [UIColor redColor];
    [self.view addSubview:shuliang];
    
    float b = [self NSStringwithsize:17 str:shuliang.text];
    UILabel *las = [[UILabel alloc] initWithFrame:CGRectMake(a + b + self.view.bounds.size.width/2 - self.view.bounds.size.width * 0.421/2, self.view.bounds.size.height * 0.7, 40, 20)];
    las.text = @"元";
    [self.view addSubview:las];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 按钮点击事件

-(void)backbuttonclickw
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
-(void)tiquclick
{


}
#pragma mark---- SOAP请求
-(void)soaprequestwithcustomerSno:(NSString *)customerSno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerCommissionData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "</GetCustomerCommissionData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerCommissionData" forHTTPHeaderField:@"SOAPAction"];
    
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
    

    
    if ([elementName isEqualToString:@"GetCustomerCommissionDataResult"]) {
        
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
    
    
    if ([elementName isEqualToString:@"GetCustomerCommissionDataResult"]) {//获取本页信息
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"奖励的数据:%@",dic);
        
        NSMutableArray *personData = [dic objectForKey:@"personData"];
        self.jlarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in personData) {
            JiangLi *jl = [JiangLi jiangliwithdiction:diction];
            [self.jlarray addObject:jl];
        }

        [self creatlablewithjiangli];
        [self creatcountwithjiangli];
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
