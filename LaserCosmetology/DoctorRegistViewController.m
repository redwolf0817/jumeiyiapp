//
//  DoctorRegistViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/11.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "DoctorRegistViewController.h"
#import "DoctorMainViewController.h"
#import "PrefixHeader.pch"
@interface DoctorRegistViewController ()

@end

@implementation DoctorRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image.image = [UIImage imageNamed:@"医生登陆页面"];
    [self.view addSubview:image];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(50, 110, self.view.bounds.size.width - 100, 25)];
    lable.text = @"专家提交资料";
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:lable];
    
    _nametextf = [[UITextField alloc] initWithFrame:CGRectMake(50, 145, self.view.bounds.size.width/2 - 10, 30)];
    _nametextf.backgroundColor = [UIColor whiteColor];
    _nametextf.placeholder = @"  姓名";
    _nametextf.layer.masksToBounds = YES;
    _nametextf.layer.cornerRadius = 2;
    [self.view addSubview:_nametextf];
    
    _segment = [[UISegmentedControl alloc]initWithItems:@[@"男",@"女"]];
    _segment.frame = CGRectMake(_nametextf.frame.size.width + 60, 147, self.view.bounds.size.width/2 - 100, 25);
    _segment.selectedSegmentIndex = 1;
    self.sextyp = @"0";
    [_segment addTarget:self action:@selector(segmentclick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    
    _phonetextf = [[UILabel alloc] initWithFrame:CGRectMake(50, 190, self.view.bounds.size.width - 100, 30)];
    _phonetextf.backgroundColor = [UIColor whiteColor];
    _phonetextf.text = self.phone;
    _phonetextf.layer.masksToBounds = YES;
    _phonetextf.layer.cornerRadius = 2;
    [self.view addSubview:_phonetextf];
    
    
    _Companytextf = [[UITextField alloc] initWithFrame:CGRectMake(50, 245, self.view.bounds.size.width - 100, 30)];
    _Companytextf.backgroundColor = [UIColor whiteColor];
    _Companytextf.placeholder = @" 单位";
    _Companytextf.layer.masksToBounds = YES;
    _Companytextf.layer.cornerRadius = 2;
    [self.view addSubview:_Companytextf];
    
    
    _EMeltextf = [[UITextField alloc] initWithFrame:CGRectMake(50, 300, self.view.bounds.size.width - 100, 30)];
    _EMeltextf.backgroundColor = [UIColor whiteColor];
    _EMeltextf.placeholder = @" 邮箱";
    _EMeltextf.layer.masksToBounds = YES;
    _EMeltextf.layer.cornerRadius = 2;
    [self.view addSubview:_EMeltextf];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 360, self.view.bounds.size.width - 200, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"小按钮s"] forState:UIControlStateNormal];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(commitbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
    self.doctorSno =  [userdf objectForKey:@"customerSno"];//这个实际上医生的索引
    
}
-(void)gotodoctormainviewcv
{
    DoctorMainViewController *main = [[DoctorMainViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
}

-(void)segmentclick:(UISegmentedControl *)segment
{
    NSString *str = [NSString stringWithFormat:@"%ld",segment.selectedSegmentIndex];
    if ([str isEqualToString:@"0"]) {
        self.sextyp = @"1";
    }else{
    self.sextyp = @"0";
    }
    
}

-(void)commitbuttonclick
{

    [self soaprequestwithdoctorSno:self.doctorSno trueName:_nametextf.text emailNo:_EMeltextf.text sexType:self.sextyp workUnit:_Companytextf.text];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self gotodoctormainviewcv];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//手机号码+验证码+用户类型 登录验证,成功则返回客户/医生SNO      //超级验证码76983
#pragma mark SOAP请求方法 客户端注册医生信息补全
// 客户端注册医生信息补全
-(void)soaprequestwithdoctorSno:(NSString *)doctorSno trueName:(NSString *)trueName emailNo:(NSString *)emailNo sexType:(NSString *)sexType workUnit:(NSString *)workUnit
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SetNewDoctorData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<trueName>%@</trueName>\n"
                             "<emailNo>%@</emailNo>\n"
                             "<sexType>%@</sexType>\n"
                             "<workUnit>%@</workUnit>\n"
                             "</SetNewDoctorData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,trueName,emailNo,sexType,workUnit];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SetNewDoctorData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    
    if ([elementName isEqualToString:@"SetNewDoctorDataResult"]) {
        
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
    
    
    if ([elementName isEqualToString:@"SetNewDoctorDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"医生注册页面的结果:%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        NSString *str = [NSString stringWithFormat:@"%@: 您好!您的资料已收到，我们会尽快与您联系。感谢您对聚美医平台的支持！",_nametextf.text];
        if ([state isEqualToString:@"1"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
