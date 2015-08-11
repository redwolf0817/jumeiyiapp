//
//  AboutViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "AboutViewController.h"
#import "TopBarView.h"
#import "BottomBarView.h"
#import "BeautyFootprint.h"
#import "AdultsViewController.h"
#import "YouHuiViewController.h"
#import "HuQiJingsharManage.h"
#import "PrefixHeader.pch"
@interface AboutViewController ()

@end

@implementation AboutViewController

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
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, self.view.bounds.size.width, 25)];
    titilelable.text = @"更多";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    float hi = self.view.bounds.size.width/8.0;
    NSArray *titleary = [[NSArray alloc] initWithObjects:@"    美容足迹",@"    意见反馈",@"    优惠活动",@"    退出登录", nil];
    NSArray *buttonimagesary = [[NSArray alloc] initWithObjects:@"更多_02e",@"更多_02e",@"更多_02e",@"更多_02e", nil];
    for (int i = 0; i < 4; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, hi * i + 80, self.view.bounds.size.width , self.view.bounds.size.width/9.70)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:[titleary objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[self colorWithRGB:0x00c5bb alpha:1] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[buttonimagesary objectAtIndex:i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(gotomoreviewcr:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1 + i;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.view addSubview:button];
    }

    float botomerhight = 0.130667 * self.view.bounds.size.width;
    
    UIImageView *tabBarimage = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - botomerhight, self.view.bounds.size.width, botomerhight)];
    tabBarimage.image = [UIImage imageNamed:@"首页1_05ss"];
    [self.view addSubview:tabBarimage];
    
    BottomBarView *botom = [[BottomBarView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - botomerhight, self.view.bounds.size.width, botomerhight)];
    [self.view addSubview:botom];
    
    
}

-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}

-(void)gotomoreviewcr:(UIButton *)butn
{
    
    
    if (butn.tag == 1) {
       BeautyFootprint *footprint = [[BeautyFootprint alloc] init];
        [self.navigationController pushViewController:footprint animated:YES];
    }else if(butn.tag == 2){
    
    AdultsViewController *Adults = [[AdultsViewController alloc] init];
        [self.navigationController pushViewController:Adults animated:YES];
    }else if(butn.tag == 3){
        
        YouHuiViewController *youh = [[YouHuiViewController alloc] init];
        [self.navigationController pushViewController:youh animated:YES];
    }else{

        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示！" message:@"退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [aler show];
        
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *registration_id = [user objectForKey:@"registration_id"];
        NSString *customersno = [user objectForKey:@"customerSno"];
        [self soaprequstWithuserSno:customersno registrationId:registration_id];
        
        [user setObject:@"" forKey:@"CommomUserORCommomDoctor"];
        [user setObject:@"" forKey:@"customerSno"];
        
        //        NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
        //        NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
        //        NSString *phonenumber = [userDefatluts objectForKey:@"phonenumber"];
        //        for(NSString* key in [dictionary allKeys]){
        //            [userDefatluts removeObjectForKey:key];
        //            [userDefatluts synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dengluye" object:nil];
        
        [HuQiJingsharManage shareManage].sssss = @"3";
        // }
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
#pragma mark-----SOAP
//获取医生登录TOKEN和审核状态
-(void)soaprequstWithuserSno:(NSString *)userSno registrationId:(NSString *)registrationId
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<UserLoginOut xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<userSno>%@</userSno>\n"
                              "<registrationId>%@</registrationId>\n"
                             "</UserLoginOut>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,userSno,registrationId];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/UserLoginOut" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    NSLog(@"已经请求成功");
}

//如果电脑没有连接网络，则出现此信息（不是网络服务器不通）
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"链接失败---ERROR with theConenction");
    
    // NSLog(@"ERROR with theConenction");[error description]
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
    NSLog(@"提交预约的数据--%@",theXML);
    
    
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
    
    if ([elementName isEqualToString:@"UserLoginOutResult"]) {
        
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
    
    if ([elementName isEqualToString:@"UserLoginOutResult"]) {
        
        
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"退出登录------：dic%@",dic);
        

        
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
