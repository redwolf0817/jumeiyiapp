//
//  ModifyTheTemplate.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "ModifyTheTemplate.h"
#import "TopBarView.h"
#import "PrefixHeader.pch"
@interface ModifyTheTemplate ()

@end

@implementation ModifyTheTemplate

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
    titilelable.text = @"完善资料";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    imageview.image = [UIImage imageNamed:@"huidi"];
    imageview.userInteractionEnabled = YES;
    [self.view addSubview:imageview];
    
    _commitbtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80 - 20, 70, 80, 30)];
    [_commitbtn setTitle:@"提交" forState:UIControlStateNormal];
    [_commitbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_commitbtn addTarget:self action:@selector(commitbtnclickwithimageandtext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commitbtn];
    
    _Photo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, self.view.bounds.size.width - 40, self.view.bounds.size.height - 240)];
    _Photo.image = self.myimage;
    _Photo.userInteractionEnabled = NO;
    _Photo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_Photo];
    
    UIButton *shooseimage = [[UIButton alloc] initWithFrame:CGRectMake(20, 120, self.view.bounds.size.width - 40, self.view.bounds.size.height - 240)];
    [shooseimage addTarget:self action:@selector(updatawithimage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shooseimage];
    
    UIImageView *lableback = [[UIImageView alloc] initWithFrame:CGRectMake(20,_Photo.center.y - 60 ,self.view.bounds.size.width - 40, 120)];
    lableback.image = [UIImage imageNamed:@"zhuanjiabeijing4"];
    [self.view addSubview:lableback];
    
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(20, _Photo.center.y - 45, lableback.bounds.size.width, lableback.bounds.size.height - 30)];
    _textview.text = self.picDesc;
    _textview.textColor = [UIColor whiteColor];
    _textview.font = [UIFont systemFontOfSize:15];
    _textview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_textview];

    
    UIButton *Thenextpage = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height - 70, 140, 35)];
    [Thenextpage setTitle:@"下一张" forState:UIControlStateNormal];
    [Thenextpage setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    Thenextpage.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height - 100 + 15);
    [Thenextpage addTarget:self action:@selector(Thenextpagetbtnclick) forControlEvents:UIControlEventTouchUpInside];
    Thenextpage.layer.masksToBounds = YES;
    Thenextpage.layer.cornerRadius = 3;
    [self.view addSubview:Thenextpage];
    
   
//    
//    NSString *ssimg = self.data;
//    NSData *image = [NSData dataWithContentsOfFile:ssimg];
//    UIImage *tmpimage=[UIImage imageWithData:image];
//    _Photo.image = tmpimage;
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

#pragma mark -- 按钮区

-(void)fanhui
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitbtnclickwithimageandtext
{
    _commitbtn.userInteractionEnabled = NO;
    self.picDesc = _textview.text;
   
    //发送请求
    [self soaprequstWithdoctorSno:self.doctorSno modelNo:self.modelNo picSno:self.picSno data:self.data fileTypeName:@"png" picDesc:self.picDesc doType:self.doType];
    NSLog(@"提交== 提交== 提交");

}
-(void)Thenextpagetbtnclick
{
    _Photo.image = [UIImage imageNamed:@""];
    _textview.text = @"";
    
}

-(void)updatawithimage
{
    NSLog(@"要上传照片");
    
    [self.view endEditing:YES];
    
    pickerimageViewController *picker = [[pickerimageViewController alloc] init];
    picker.delegate1 = self;
    [self.navigationController pushViewController:picker animated:YES];
}
-(void)sendimage:(UIImage *)imagess{
    
    _Photo.image  = imagess;
    NSData *_data = UIImageJPEGRepresentation(imagess, 0.4f);
    NSString *_encodedImageStr = [_data base64Encoding];
    self.data = _encodedImageStr;
}

#pragma mark -- soap请求

-(void)soaprequstWithdoctorSno:(NSString *)doctorSno modelNo:(NSString *)modelNo picSno:(NSString *)picSno data:(NSString *)data fileTypeName:(NSString *)fileTypeName  picDesc:(NSString *)picDesc doType:(NSString *)doType
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SetDoctorPictureData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<modelNo>%@</modelNo>\n"
                             "<picSno>%@</picSno>\n"
                             "<data>%@</data>\n"
                             "<fileTypeName>%@</fileTypeName>\n"
                             "<picDesc>%@</picDesc>\n"
                             "<doType>%@</doType>\n"
                             "</SetDoctorPictureData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,modelNo,picSno,data,fileTypeName,picDesc,doType];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SetDoctorPictureData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    
    if ((long)[urlresponse statusCode] == 400) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"链接失败，请返回上一页再回来！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
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
    
    if ([elementName isEqualToString:@"SetDoctorPictureDataResult"]) {
        
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
    
    if ([elementName isEqualToString:@"SetDoctorPictureDataResult"]) {
        
        
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
       // NSLog(@"医生时间表详情：dic%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        
        NSString *msg = [dic objectForKey:@"msg"];
        
        
        
        
        if ([state isEqualToString:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
           
            [alert show];
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    _commitbtn.userInteractionEnabled = YES;
   [self fanhui];
}

@end
