//
//  PersonalViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "PersonalViewController.h"
#import "TopBarView.h"
#import "BottomBarView.h"
#import "UpLoadingHeadImage.h"
#import "MySecretaryVC.h"
#import "MyRewardVC.h"
#import "customercenter.h"
#import "UIImageView+WebCache.h"
#import "CashCouponVC.h"
#import "MyExpertCLViewCR.h"
#import "MyAppointmentCollectionVC.h"
#import "MyAppointmentViewLayout.h"

#import "MyAppointmentViewController.h"
#import "MeiRongZuJiCellViewController.h"
#import "EditDataVC.h"
#import "StarBeauticianViewController.h"
#import "MyPoints.h"
#import "persens.h"
#import "PrefixHeader.pch"
static NSString * const identifier = @"cell";
static NSString * const MyExpertidentifier = @"MyExpertCLViewCell";

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.backgroundColor = [UIColor whiteColor];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"个人中心";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
     float botomerhight = 0.130667 * self.view.bounds.size.width;

    if (self.customerSnos == nil) {
        self.customerSnos = [[NSUserDefaults standardUserDefaults] objectForKey:@"customerSno"];
    }
    
    UIImageView *redbackimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height/2 - 30)];
    redbackimage.image = [UIImage imageNamed:@"个人中心底色_02s"];
    redbackimage.userInteractionEnabled = YES;
    [self.view addSubview:redbackimage];
    
    UIImageView *vipimage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 + 60, redbackimage.bounds.size.height * 0.062, 45, 20)];
    vipimage.image = [UIImage imageNamed:@"个人中心_034_03"];
    [redbackimage addSubview:vipimage];
    
    
     _headimage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 60,redbackimage.bounds.size.height * 0.1297, 120, 120)];
    _headimage.image = [UIImage imageNamed:@"jumei"];
    _headimage.center = CGPointMake(self.view.bounds.size.width/2, redbackimage.bounds.size.height * 0.1297 + 40);
    _headimage.layer.masksToBounds = YES;
    _headimage.layer.cornerRadius = 60;
    [redbackimage addSubview:_headimage];
    
    
    UIButton *mishu = [[UIButton alloc] initWithFrame:CGRectMake(20, redbackimage.bounds.size.height - 50, 100, 25)];
    [mishu addTarget:self action:@selector(mysecretarybtnclick) forControlEvents:UIControlEventTouchUpInside];
    [mishu setBackgroundImage:[UIImage imageNamed:@"个人中心4_03"] forState:UIControlStateNormal];
    [redbackimage addSubview:mishu];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *ishaver = [def objectForKey:@"ishaver"];
    self.redsmlimgae = [[UIImageView alloc] initWithFrame:CGRectMake(110, redbackimage.bounds.size.height - 50, 12, 12)];
    [redbackimage addSubview:self.redsmlimgae];
    if ([ishaver isEqualToString:@"1"]) {
        self.redsmlimgae.image = [UIImage imageNamed:@"个人中心44_03"];
    }
    
    UIButton *bianji = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 120, redbackimage.bounds.size.height - 50, 100, 25)];
    [bianji addTarget:self action:@selector(bianjiclick) forControlEvents:UIControlEventTouchUpInside];
    [bianji setBackgroundImage:[UIImage imageNamed:@"个人中心4_05"] forState:UIControlStateNormal];
    [redbackimage addSubview:bianji];

   
    
    UIImageView *tabBarimage = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - botomerhight, self.view.bounds.size.width, botomerhight)];
    tabBarimage.image = [UIImage imageNamed:@"首页1_04ss"];
    [self.view addSubview:tabBarimage];
    
    BottomBarView *botom = [[BottomBarView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - botomerhight, self.view.bounds.size.width, botomerhight)];
    [self.view addSubview:botom];
    

    NSMutableArray *buttonimagearray = [[NSMutableArray alloc] initWithObjects:@"个人中心4_02",@"个人中心4_04",@"个人中心4_06",@"个人中心4_10",@"个人中心4_11",@"个人中心4_12", nil];
    float btnheigth = (self.view.bounds.size.width - 4)/3;
    float y1 = self.view.bounds.size.height/2 - 30 + redbackimage.frame.origin.y;
    float btnhigth = ((self.view.bounds.size.height - y1 - botom.frame.size.height) - 2)/2;
    for (int i = 0; i < 6; i ++) {
        
        float x = (btnheigth + 2) * (i % 3) + 2;
        float y = (btnhigth + 2) * (i/3) + y1;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y , btnheigth, btnhigth)];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[buttonimagearray objectAtIndex:i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sixButtonClassificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 60 + i;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 1;
        [self.view addSubview:button];
    }
    
    


}

-(void)refresheadimage
{
    if (_customerDataary.count > 0) {
        persens *center = [_customerDataary objectAtIndex:0];
        NSLog(@"center.PicSrc--->%@",center.PicSrc);
        [_headimage sd_setImageWithURL:[NSURL URLWithString:center.PicSrc]];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    [self soaprequestwithcustomerSno:self.customerSnos];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(personbackbuttonclick) name:@"dengluye" object:nil];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *ishaver = [def objectForKey:@"ishaver"];


    float botomerhight = 0.130667 * self.view.bounds.size.width;
    
    float x = self.view.bounds.size.width/5;
    if (!self.redbutton) {
        self.redbutton = [[UIButton alloc] initWithFrame:CGRectMake(3 * x + x/2 + 4,7 + self.view.bounds.size.height - botomerhight, 9, 9)];
        [self.view addSubview:self.redbutton];
    }
    if ([ishaver isEqualToString:@"1"]) {
        [self.redbutton setBackgroundImage:[UIImage imageNamed:@"个人中心44_03"] forState:UIControlStateNormal];
        
    }else{
        [self.redbutton setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
        self.redsmlimgae.image = [UIImage imageNamed:@" "];
    }
    NSString *registID =  [def objectForKey:@"registration_id"];
    
    [self soaprequestwithuserSno:self.customerSnos registrationId:registID];
    
  
}

#pragma mark--- scrollerview的拖动

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSLog(@"scrollViewDidScroll");
    
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

//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 20,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}

#pragma mark---按钮点击事件
-(void)bianjiclick
{
    EditDataVC *editing = [[EditDataVC alloc] init];
    editing.customerSno = self.customerSnos;
    [self.navigationController pushViewController:editing animated:YES];
}
-(void)sixButtonClassificationBtnClick:(UIButton *)btn
{
    if (btn.tag == 60) {
        NSLog(@"我的专家");
        MyExpertCLViewCR *myexpert = [[MyExpertCLViewCR alloc] init];
        myexpert.customerSno = self.customerSnos;
        [self.navigationController pushViewController:myexpert animated:YES];
        
    }else if (btn.tag == 61){
     
        self.higthary = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < _customerOrderDataarray.count; i++) {
            customercenter *center = [_customerOrderDataarray objectAtIndex:i];
            if (center.EvaluateReturnContents.length > 5) {
                [self.higthary addObject:[NSString stringWithFormat:@"%f",[self contentsWithnsstring:center.EvaluateReturnContents]]];
            }else{
                [self.higthary addObject:@"0"];
            }
        }
         MyAppointmentViewController *mypointment = [[MyAppointmentViewController alloc] init];
        mypointment.higthary = self.higthary;
        mypointment.customerSno = self.customerSnos;
        [self.navigationController pushViewController:mypointment animated:YES];
        
    }else if (btn.tag == 62){
         NSLog(@"美容足迹");
        
        MeiRongZuJiCellViewController *meirong =[[MeiRongZuJiCellViewController alloc] init];
        meirong.dataarray = _customerBeautifyLogDataarray;
        [self.navigationController pushViewController:meirong animated:YES];
        
    }else if (btn.tag == 63){
         NSLog(@"现金券");
        CashCouponVC *cash = [[CashCouponVC alloc] init];
        [self.navigationController pushViewController:cash animated:YES];
    }else if (btn.tag == 64){
         NSLog(@"奖励");
        MyRewardVC *myreward = [[MyRewardVC alloc] init];
        myreward.mycustomerSno = self.customerSnos;
        myreward.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myreward animated:YES];
    }else{
    
        MyPoints *mypoint = [[MyPoints alloc] init];
        mypoint.customerSno = self.customerSnos;
        [self.navigationController pushViewController:mypoint animated:YES];
    }


}
-(void)gotodoctor:(UIButton *)btn
{
    customercenter *xp = [_customerFocusDoctorDataarray objectAtIndex:btn.tag - 20];
    StarBeauticianViewController *xiangqing = [[StarBeauticianViewController alloc] init];
    xiangqing.sno = xp.DoctorSno;
    xiangqing.doctorname = xp.DoctorName;
    [self.navigationController pushViewController:xiangqing animated:YES];
}

//我的秘书
-(void)mysecretarybtnclick
{
    MySecretaryVC *mysecretar = [[MySecretaryVC alloc] init];
    mysecretar.customerSno = self.customerSnos;
    mysecretar.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mysecretar animated:YES];
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
-(void)personbackbuttonclick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark-- SOAP请求！

//给医生评价
-(void)soaprequestwithsendjudgecustomerOrderDetailSno:(NSString *)customerOrderDetailSno evaluateLevel:(NSString *)evaluateLevel evaluateContents:(NSString *)evaluateContents
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SendCustomerOrderDetailEvaluate xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerOrderDetailSno>%@</customerOrderDetailSno>\n"
                             "<evaluateLevel>%@</evaluateLevel>\n"
                             "<evaluateContents>%@</evaluateContents>\n"
                             "</SendCustomerOrderDetailEvaluate>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerOrderDetailSno,evaluateLevel,evaluateContents];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SendCustomerOrderDetailEvaluate" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//获取个人中心的数据
-(void)soaprequestwithcustomerSno:(NSString *)customerSno
{
    NSLog(@"获取到的用户索引%@",self.customerSnos);
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerCenterData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "</GetCustomerCenterData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerCenterData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//用户和设备编号关联
-(void)soaprequestwithuserSno:(NSString *)userSno registrationId:(NSString *)registrationId
{
    NSLog(@"获取到的用户索引%@",self.customerSnos);
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerCenterData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<userSno>%@</userSno>\n"
                             "<registrationId>%@</registrationId>\n"
                             "</GetCustomerCenterData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,userSno,registrationId];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerCenterData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//    
//    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
//    NSLog(@"请求回来的数据--%@",theXML);
    
    //        [theXML release];
    
    //        NSString *str = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    //
    //
    //             NSLog(@"请求回来的数据-2--%@",str);
    
    //重新加載xmlParser
    //    if( xmlParser )
    //    {
    //        [xmlParser release];
    //    }
    
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
    
    if ([elementName isEqualToString:@"GetCustomerCenterDataResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"SendCustomerOrderDetailEvaluateResult"]) {
        
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
    
                                    
    if ([elementName isEqualToString:@"GetCustomerCenterDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
         NSLog(@"1122个人中心的数据:%@",dic);
        
        NSMutableArray *customerBeautifyLogData = [dic objectForKey:@"customerBeautifyLogData"];
        _customerBeautifyLogDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in customerBeautifyLogData) {
            customercenter *center = [customercenter pointTotalCountwithdiction:diction];
            [_customerBeautifyLogDataarray addObject:center];
        }
        
        NSMutableArray *customerFocusDoctorData = [dic objectForKey:@"customerFocusDoctorData"];
        _customerFocusDoctorDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in customerFocusDoctorData) {
            customercenter *center = [customercenter pointTotalCountwithdiction:diction];
            [_customerFocusDoctorDataarray addObject:center];
        }
        
        NSMutableArray *customerOrderData = [dic objectForKey:@"customerOrderData"];
        _customerOrderDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in customerOrderData) {
            customercenter *center = [customercenter pointTotalCountwithdiction:diction];
            [_customerOrderDataarray addObject:center];
        }
        
        NSMutableArray *personData = [dic objectForKey:@"personData"];
       _personDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in personData) {
            customercenter *center = [customercenter pointTotalCountwithdiction:diction];
            [_personDataarray addObject:center];
        }
        
        NSMutableArray *customerData = [dic objectForKey:@"customerData"];
        _customerDataary = [[NSMutableArray alloc]initWithCapacity:0];
        for (NSDictionary *diction in customerData) {
            persens *center = [persens persensWithdictionary:diction];
            [_customerDataary addObject:center];
        }
        [self refresheadimage];
        
    }
    
    if ([elementName isEqualToString:@"SendCustomerOrderDetailEvaluateResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"发送医生评价返回的数据:%@",dic);
        
        NSString *msg = [dic objectForKey:@"msg"];
        NSString *ret = [dic objectForKey:@"ret"];
        NSString *state = [dic objectForKey:@"state"];
        
        NSLog(@"msg:%@-ret:%@-state:%@",msg,ret,state);
        if ([state isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
