//
//  PersonDoctShooseViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "PersonDoctShooseViewController.h"
#import "PersonalViewController.h"
#import "BottomBarView.h"
#import "DoctorMainViewController.h"
#import "DoctorRegistViewController.h"
#import "PrefixHeader.pch"
@interface PersonDoctShooseViewController ()

@end

@implementation PersonDoctShooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self gotoIndividualcenter];
    
    UIImageView *backgroundimage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundimage.image = [UIImage imageNamed:@"医生登陆页面"];
    [self.view addSubview:backgroundimage];
    
    
    _phonenumber  =[[UITextField alloc] initWithFrame:CGRectMake(60, 130, 250, 30)];
    _phonenumber.backgroundColor = [UIColor whiteColor];
    _phonenumber.center = CGPointMake(self.view.bounds.size.width/2, 135);
    _phonenumber.placeholder = @" 请输入手机号码";
    //_phonenumber.text = @"  12345678901";//客户
    //_phonenumber.text = @"  13556789099";//医师
    _phonenumber.layer.masksToBounds = YES;
    _phonenumber.layer.cornerRadius = 4;
    [self.view addSubview:_phonenumber];
    
    _testnumber = [[UITextField alloc] initWithFrame:CGRectMake(_phonenumber.frame.origin.x, 170, 120, 30)];
    _testnumber.backgroundColor = [UIColor whiteColor];
    _testnumber.placeholder = @" 请输入验证码";
    _testnumber.layer.masksToBounds = YES;
    _testnumber.layer.cornerRadius = 4;
    [self.view addSubview:_testnumber];
    
    _testbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100 -(self.view.bounds.size.width - 250)/2, 170, 100, 30)];
    [_testbtn addTarget:self action:@selector(testbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_testbtn setBackgroundImage:[UIImage imageNamed:@"小按钮s"] forState:UIControlStateNormal];
    [_testbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _testbtn.layer.masksToBounds = YES;
    _testbtn.layer.cornerRadius = 4;
    [self.view addSubview:_testbtn];
    
    _recommendNotf = [[UITextField alloc] initWithFrame:CGRectMake(_phonenumber.frame.origin.x, 220, 120, 30)];
    _recommendNotf.backgroundColor = [UIColor whiteColor];
    _recommendNotf.placeholder = @" 客户推荐码";
    _recommendNotf.layer.masksToBounds = YES;
    _recommendNotf.layer.cornerRadius = 4;
    self.recommendNo = _recommendNotf.text;
    [self.view addSubview:_recommendNotf];
    
    UIButton *agreementbtn = [[UIButton alloc] initWithFrame:CGRectMake(_phonenumber.frame.origin.x, 275, 20, 20)];
    [agreementbtn addTarget:self action:@selector(agreementclick:) forControlEvents:UIControlEventTouchUpInside];
    [agreementbtn setBackgroundImage:[UIImage imageNamed:@"06"] forState:UIControlStateNormal];
    agreementbtn.tag = 10;
    agreementbtn.layer.masksToBounds = YES;
    agreementbtn.layer.cornerRadius = 4;
    [self.view addSubview:agreementbtn];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(_phonenumber.frame.origin.x + 30, 270, 100, 30)];
    lable.text = @"用户协议";
    lable.textColor = [UIColor whiteColor];
    [self.view addSubview:lable];
    
    UIButton *xieyiclick = [[UIButton alloc] initWithFrame:CGRectMake(_phonenumber.frame.origin.x + 30, 270, 100, 30)];
    [xieyiclick addTarget:self action:@selector(agreementclick:) forControlEvents:UIControlEventTouchUpInside];
    xieyiclick.layer.masksToBounds = YES;
    xieyiclick.layer.cornerRadius = 2;
    [self.view addSubview:xieyiclick];
    
    
    mybutton *consumer = [[mybutton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 130 -(self.view.bounds.size.width - 250)/2, 270, 65, 30)];
    [consumer addTarget:self action:@selector(consumerAndDoctor:) forControlEvents:UIControlEventTouchUpInside];
    [consumer setBackgroundImage:[UIImage imageNamed:@"01"] forState:UIControlStateNormal];
    [consumer setTitle:@"我是客户" forState:UIControlStateNormal];
    consumer.titleLabel.font = [UIFont systemFontOfSize:15];
    consumer.tag = 11;
    consumer.isclick = YES;
    [self.view addSubview:consumer];
    
    mybutton *doctor = [[mybutton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 65 -(self.view.bounds.size.width - 250)/2, 270, 65, 30)];
    [doctor addTarget:self action:@selector(consumerAndDoctor:) forControlEvents:UIControlEventTouchUpInside];
    [doctor setBackgroundImage:[UIImage imageNamed:@"03"] forState:UIControlStateNormal];
    [doctor setTitle:@"我是医生" forState:UIControlStateNormal];
    [doctor setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    doctor.titleLabel.font = [UIFont systemFontOfSize:15];
    doctor.tag = 12;
    [self.view addSubview:doctor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(60, 300, 200, 40)];
    [button addTarget:self action:@selector(commitclick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    button.center = CGPointMake(self.view.bounds.size.width/2, 380);
    [button setTitle:@"登录" forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 8;
    [self.view addSubview:button];
    
    self.Isxieyi = YES;
    
    float botomerhight = 0.130667 * self.view.bounds.size.width;
    
    UIImageView *tabBarimage = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - botomerhight, self.view.bounds.size.width, botomerhight)];
    tabBarimage.image = [UIImage imageNamed:@"首页1_04ss"];
    [self.view addSubview:tabBarimage];
    
    BottomBarView *botom = [[BottomBarView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - botomerhight, self.view.bounds.size.width, botomerhight)];
    [self.view addSubview:botom];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    _phonenumber.text = @"";
    _testnumber.text = @"";
    
   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *iscustomer =[user objectForKey:@"CommomUserORCommomDoctor"];
    
     NSLog(@"--CommomUserORCommomDoctor-%@",iscustomer);
    
    if ([iscustomer isEqualToString:@"CommomUser"]) {
        
         [self gotoIndividualcenter];//客户中心
        
    }else if([iscustomer isEqualToString:@"CommomDoctor"]){
        
    [self gotodoctercenter];//医生个人中心
    
    }else{
        return;
    }
    
    NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
    _phonenumber.text = [userd objectForKey:@"phonenumber"];
    NSLog(@"删除后的号码：%@",_phonenumber.text);
    NSLog(@"[userd objectForKey:phonenumber]--> %@",[userd objectForKey:@"phonenumber"]);

   
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark 按键区
//选择协议
-(void)agreementclick:(UIButton *)butn
{
   
    static int a = 0;
    
    if (butn.tag == 10) {
        if (a % 2 == 0) {
            [butn setBackgroundImage:[UIImage imageNamed:@"05"] forState:UIControlStateNormal];
            NSLog(@"05");
            self.Isxieyi = NO;
        }else{
        [butn setBackgroundImage:[UIImage imageNamed:@"06"] forState:UIControlStateNormal];
            NSLog(@"06");
            self.Isxieyi = YES;
        }
    }else{
     [self soaprequestwithinfoSno];
    }
    a++;
}
//显示协议窗口
-(void)xieyi
{
    
    if (_view0) {
        return;
    }else{
        _view0 = [[UIView alloc] initWithFrame:self.view.bounds];
        _view0.backgroundColor = [UIColor blackColor];
        _view0.alpha = 0.5;
        _view0.tag = 110;
        [self.view addSubview:_view0];
        
        _view1 = [[UIView alloc] initWithFrame:CGRectMake(30, 80, self.view.bounds.size.width - 60, self.view.bounds.size.height * 0.667)];
        _view1.backgroundColor = [UIColor whiteColor];
        _view1.layer.masksToBounds = YES;
        _view1.layer.cornerRadius = 8;
        _view1.tag = 120;
        [self.view addSubview:_view1];
    }


    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, _view1.bounds.size.width , _view1.bounds.size.height - 40)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.scalesPageToFit = NO;
    [_view1 addSubview:webView];
    NSString *html_str = self.Contents;
    [webView loadHTMLString:html_str baseURL:nil];
    

    UIButton *bbtt = [[UIButton alloc] initWithFrame:CGRectMake(50, _view1.bounds.size.height - 35, _view1.bounds.size.width - 100, 30)];
    [bbtt setTitle:@"已阅读" forState:UIControlStateNormal];
    [bbtt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bbtt.layer.masksToBounds = YES;
    bbtt.layer.cornerRadius = 7;
    [bbtt setBackgroundImage:[UIImage imageNamed:@"小按钮s"] forState:UIControlStateNormal];
    [bbtt addTarget:self action:@selector(ISAgree:) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:bbtt];


}
-(void)ISAgree:(UIButton *)button
{
    
    UIButton *setbtn = (UIButton *)[self.view viewWithTag:10];
    
        [setbtn setBackgroundImage:[UIImage imageNamed:@"06"] forState:UIControlStateNormal];//同意
    UIView *v1 = (UIView *)[self.view viewWithTag:110];
    [v1 removeFromSuperview]; v1 = nil;
    
    UIView *v2 = (UIView *)[self.view viewWithTag:120];
    [v2 removeFromSuperview]; v2 = nil;

    [_view0 removeFromSuperview];
    _view0 = nil;
    [_view1 removeFromSuperview];
    _view1 = nil;
    
     self.Isxieyi = YES;
    
}

//用户或医生选择
-(void)consumerAndDoctor:(mybutton *)button
{
    
    NSLog(@"用户或医生");
    
    
    if (button.tag == 11) { //我是用户
        
        if (button.isclick == NO) {
            button.isclick = YES;
            [button setBackgroundImage:[UIImage imageNamed:@"01"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            mybutton *btn = (mybutton *)[self.view viewWithTag:12];
            [btn setBackgroundImage:[UIImage imageNamed:@"03"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.isclick = NO;
            self.personordocter = NO;
        }
        
    }else{  //我是医生
        
        if (button.isclick == NO) {
            button.isclick = YES;
            [button setBackgroundImage:[UIImage imageNamed:@"04"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            mybutton *btn = (mybutton *)[self.view viewWithTag:11];
            [btn setBackgroundImage:[UIImage imageNamed:@"02"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.isclick = NO;
            self.personordocter = YES;
        }
        
    }
    
}
//提交
-(void)commitclick
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *registration_id = [user objectForKey:@"registration_id"];
    
    self.recommendNo = _recommendNotf.text;
    NSLog(@"提交");
    if ([_testnumber.text isEqualToString:@""] || _testnumber.text == nil) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"验证码不能为空！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertview show];
        return;
    }
    
    if (_testnumber.text.length < 4 || _testnumber.text.length > 4) {
        
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"输入的验证码有误！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertview show];
        return;
    }
    

        
        if (self.personordocter == NO) {
            [self soaprequestwithPhoneNo:_phonenumber.text AuthCode:_testnumber.text UserType:@"CommomUser" recommendNo:self.recommendNo registrationId:registration_id];
            
            //[self gotoIndividualcenter];//客户中心
        }else{
            
            [self soaprequestwithPhoneNo:_phonenumber.text AuthCode:_testnumber.text UserType:@"CommomDoctor" recommendNo:self.recommendNo registrationId:registration_id];
            //[self gotodoctercenter];//医生个人中心
        }
        

    
}
//进入页面
-(void)enter
{
    if (self.Isxieyi == YES) {
        
        if (self.personordocter == NO) {
            [self gotoIndividualcenter];//客户中心
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:@"CommomUser" forKey:@"CommomUserORCommomDoctor"];
            [user setObject:_phonenumber.text forKey:@"customerphonenumber"];
            [user synchronize];
            
        }else{
            
            [self gotodoctercenter];//医生个人中心
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:@"CommomDoctor" forKey:@"CommomUserORCommomDoctor"];
            [user setObject:_phonenumber.text forKey:@"customerphonenumber"];
            [user synchronize];
            
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请同意协议条款！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }


}

//获取验证码
-(void)testbtnclick:(UIButton *)button
{
    
    if ([_phonenumber.text isEqualToString:@""] || _phonenumber.text == nil) {
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入手机号码！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertview show];
        return;
    }
    if (_phonenumber.text.length < 11 || _phonenumber.text.length > 11) {
        
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"输入的号码有误！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertview show];
        return;
    }
    if (_timer == nil) {
        button.alpha = 0.7;
        [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setTitle:@"获取中" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor grayColor];
        _timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(dingshiqi) userInfo:nil repeats:NO];
       _testbtn.userInteractionEnabled = NO;
        [self soaprequestwithphonenumber];
        
//        UIAlertView *alerter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"等待手机收到验证码,如果未收到5秒后再请求！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alerter show];
        
        NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
        [userd setObject:_phonenumber.text forKey:@"phonenumber"];
        [userd synchronize];

    }

    
}

-(void)dingshiqi{
    _testbtn.alpha = 1;
    [_testbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_testbtn setBackgroundImage:[UIImage imageNamed:@"小按钮s"] forState:UIControlStateNormal];
    _testbtn.userInteractionEnabled = YES;
    [_timer invalidate];
    _timer = nil;
}
#pragma mark-- SOAP请求！
//用户协议
-(void)soaprequestwithinfoSno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetNewsDataBySno xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<infoSno>%@</infoSno>\n"
                             "</GetNewsDataBySno>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,@"8f327150-144f-4da1-9498-74e7024b9a96"
                             ];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetNewsDataBySno" forHTTPHeaderField:@"SOAPAction"];
    
    
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

//GetAuthCode
//发送验证码并返回发送内容
-(void)soaprequestwithphonenumber
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetAuthCode xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<phoneNo>%@</phoneNo>\n"
                             "</GetAuthCode>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,_phonenumber.text
                             ];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetAuthCode" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//CheckLogin
//手机号码+验证码+用户类型 登录验证,成功则返回客户/医生SNO     //超级验证码7698
-(void)soaprequestwithPhoneNo:(NSString *)phoneNo AuthCode:(NSString *)authCode UserType:(NSString *)userType recommendNo:(NSString *)recommendNo registrationId:(NSString *)registrationId
{

    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<CheckLogin3 xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<phoneNo>%@</phoneNo>\n"
                             "<authCode>%@</authCode>\n"
                             "<userType>%@</userType>\n"
                             "<recommendNo>%@</recommendNo>\n"
                             "<registrationId>%@</registrationId>\n"
                             "</CheckLogin3>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,_phonenumber.text
                             ,authCode,userType,recommendNo,registrationId];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/CheckLogin3" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    NSLog(@"请求回来的数据--%@",theXML);
    
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
    
    if ([elementName isEqualToString:@"CheckLogin3Result"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"GetAuthCodeResult"]) {//返回的验证码
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"GetNewsDataBySnoResult"]) {//返回的验证码
        
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
    
    
    if ([elementName isEqualToString:@"CheckLogin3Result"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"发送验证码返回的结果:%@",dic);
          NSString *ret = [dic objectForKey:@"ret"];
          NSString *msg = [dic objectForKey:@"msg"];
          NSString *state = [dic objectForKey:@"state"];
        NSString *loginToken = [dic objectForKey:@"loginToken"];
        
        
        self.isNew = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isNew"]];
        
        self.customerSno = ret;
        NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
        [userdf setObject:loginToken forKey:@"loginToken"];
        [userdf setObject:ret forKey:@"customerSno"];
        [userdf synchronize];
        
        
        NSLog(@"用户登录的客户索引:%@",ret);
        
      //  NSLog(@"登录的请求:ret%@-- msg%@--state%@",ret,msg,state);
        
        if ([state isEqualToString:@"1"]) {
            [self enter];
        }else if([state isEqualToString:@"0"]){
            UIAlertView *alerter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alerter show];
            [self dingshiqi];
        }else{
        
        }
        
        if ([ret isEqualToString:@"-1"]) {
            UIAlertView *alerter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alerter show];
            [self dingshiqi];
        }
    }
            //返回的验证码
    if ([elementName isEqualToString:@"GetAuthCodeResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        

        
    }
    
    
    if ([elementName isEqualToString:@"GetNewsDataBySnoResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"用户协议%@",dic);
        NSString *ret = [dic objectForKey:@"ret"];
        NSString *msg = [dic objectForKey:@"msg"];
        NSString *state = [dic objectForKey:@"state"];
        
        NSLog(@"获取验证码的请求:ret%@-- msg%@--state%@",ret,msg,state);
        
        NSMutableArray *infoData = [dic objectForKey:@"infoData"];
        for (NSDictionary *info in infoData) {
            
             self.Contents = [info objectForKey:@"Contents"];
            self.Description = [info objectForKey:@"Description"];
            self.PicSrc = [info objectForKey:@"PicSrc"];
             self.Title = [info objectForKey:@"Title"];
        }
        
        [self xieyi];
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
#pragma mark--- 个人中心
-(void)gotoIndividualcenter
{
    PersonalViewController *personal = [[PersonalViewController alloc] init];
    personal.customerSnos = self.customerSno;
    personal.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personal animated:YES];

}

#pragma mark--- 医生个人中心
-(void)gotodoctercenter
{
    NSLog(@"self.isNew--%@",self.isNew);
    if ([self.isNew isEqualToString:@"0"]) {
        DoctorMainViewController *main = [[DoctorMainViewController alloc] init];
        [self.navigationController pushViewController:main animated:YES];
    }else if([self.isNew isEqualToString:@"1"]){
        
        self.isNew = @"0";
        DoctorRegistViewController *regist = [[DoctorRegistViewController alloc] init];
        regist.doctorSno = self.customerSno;
        regist.phone = _phonenumber.text;
        [self.navigationController pushViewController:regist animated:YES];
    }else{
        DoctorMainViewController *main = [[DoctorMainViewController alloc] init];
        [self.navigationController pushViewController:main animated:YES];
    }
    

    
}

@end

