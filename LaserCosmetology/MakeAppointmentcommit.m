//
//  MakeAppointmentcommit.m
//  聚美医
//
//  Created by fenghuang on 15/7/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "MakeAppointmentcommit.h"
#import "TopBarView.h"
#import "PrefixHeader.pch"
@interface MakeAppointmentcommit ()

@end

@implementation MakeAppointmentcommit

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
    titilelable.text = @"提交订单";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(MakeAppointmentcommitretun) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 45)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [self NSStringwithsize:17 str:@"项目名称:"], 20)];
    name.text = @"项目:";
    [view1 addSubview:name];
    
    UILabel *proname = [[UILabel alloc] initWithFrame:CGRectMake(20 + [self NSStringwithsize:17 str:name.text], 10, [self NSStringwithsize:17 str:self.proname], 20)];
    proname.text = self.proname;
    [view1 addSubview:proname];
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 111, self.view.bounds.size.width, 45)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    UILabel *dingdanhao = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [self NSStringwithsize:17 str:@"订单号:"], 20)];
    dingdanhao.text = @"订单号:";
    [view2 addSubview:dingdanhao];
    
    UILabel *dingdannumber = [[UILabel alloc] initWithFrame:CGRectMake(20 + [self NSStringwithsize:17 str:dingdanhao.text], 10, 50, 20)];
    dingdannumber.text = self.dingdannumber;
    [view2 addSubview:dingdannumber];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 158, self.view.bounds.size.width, 45)];
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];
    
    UILabel *yuyuejin = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [self NSStringwithsize:17 str:@"预约金:"], 20)];
    yuyuejin.text = @"预约金:";
    [view3 addSubview:yuyuejin];
    
    UILabel *jine = [[UILabel alloc] initWithFrame:CGRectMake(20 + [self NSStringwithsize:17 str:yuyuejin.text], 10, 50, 20)];
    jine.text = self.shu;
    [view3 addSubview:jine];
    
    UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(20 + [self NSStringwithsize:17 str:yuyuejin.text] + [self NSStringwithsize:17 str:jine.text], 10, 50, 20)];
    yuan.text = @"元";
    [view3 addSubview:yuan];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 223, self.view.bounds.size.width, 45)];
    view4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view4];
    
    UILabel *meiquan = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [self NSStringwithsize:17 str:@"美 券:"], 20)];
    meiquan.text = @"美 券:";
    [view4 addSubview:meiquan];
    
    UILabel *keyong = [[UILabel alloc] initWithFrame:CGRectMake(20 + [self NSStringwithsize:17 str:meiquan.text], 10, 50, 20)];
    keyong.text = @"可用";
    [view4 addSubview:keyong];
    
    UILabel *shu = [[UILabel alloc] initWithFrame:CGRectMake(keyong.frame.origin.x + [self NSStringwithsize:17 str:keyong.text], 10, 50, 20)];
    shu.text = self.shu;
    shu.textColor = [UIColor redColor];
    [view4 addSubview:shu];
    
    UILabel *yuan2 = [[UILabel alloc] initWithFrame:CGRectMake(keyong.frame.origin.x + [self NSStringwithsize:17 str:keyong.text]+[self NSStringwithsize:17 str:shu.text], 10, [self NSStringwithsize:17 str:@"元，抵"], 20)];
    yuan2.text = @"元，抵";
    [view4 addSubview:yuan2];
    
    UILabel *shu2 = [[UILabel alloc] initWithFrame:CGRectMake(keyong.frame.origin.x + [self NSStringwithsize:17 str:keyong.text]+[self NSStringwithsize:17 str:shu.text] + [self NSStringwithsize:17 str:yuan2.text], 10, 50, 20)];
    shu2.text = self.shu2;
    shu2.textColor = [UIColor redColor];
    [view4 addSubview:shu2];

    //创建开关对象
    UISwitch *pSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 70, 7, 60, 20)];
    //给开关添加关联动作, 方法需要实现
    [pSwitch addTarget:self action:@selector(switchMethods:) forControlEvents:UIControlEventValueChanged];
    //    //设置ON一边的背景颜色，默认是绿色
    //    pSwitch.onTintColor=[UIColor yellowColor];
    //    //设置OFF一边的背景颜色，默认是灰色，发现OFF背景颜色其实也是控件”边框“颜色
    //    pSwitch.tintColor=[UIColor purpleColor];
    //    //设置滑块颜色
    //    pSwitch.thumbTintColor=[UIColor greenColor];
    //把开关添加到当前视图中
    [view4 addSubview:pSwitch];
    
    
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(0, 270, self.view.bounds.size.width, 45)];
    view5.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view5];
    
    UILabel *xu = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, [self NSStringwithsize:17 str:@"还需支付:"], 20)];
    xu.text = @"还需支付:";
    [view5 addSubview:xu];
    
    UILabel *shu3 = [[UILabel alloc] initWithFrame:CGRectMake(20 + [self NSStringwithsize:17 str:xu.text], 10, [self NSStringwithsize:17 str:[NSString stringWithFormat:@"%.2f",[self.shu floatValue] - [self.shu2 floatValue]]], 20)];
    shu3.text = [NSString stringWithFormat:@"%.2f",[self.shu floatValue] - [self.shu2 floatValue]];
    shu3.textColor = [UIColor redColor];
    [view5 addSubview:shu3];
    
    UILabel *yuan3 = [[UILabel alloc] initWithFrame:CGRectMake(20 + [self NSStringwithsize:17 str:xu.text] + [self NSStringwithsize:17 str:shu3.text], 10, 50, 20)];
    yuan3.text = @"元";
    [view5 addSubview:yuan3];
    

    
    UIButton *commit = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - (self.view.bounds.size.width * 0.446/2), self.view.bounds.size.height * 0.701 + 50, self.view.bounds.size.width * 0.446, 40)];
    [commit setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    [commit setTitle:@"提交订单" forState:UIControlStateNormal];
    [commit addTarget:self action:@selector(commitbtnclicka) forControlEvents:UIControlEventTouchUpInside];
    commit.layer.masksToBounds = YES;
    commit.layer.cornerRadius = 4;
    [self.view addSubview:commit];
    
    
    
}


-(void)commitbtnclicka
{
    if (self.hospitalSno == nil) {
        self.hospitalSno = @"";
    }else{
        
    }
    
    NSLog(@"预约的参数  self.cusSno:%@----self.hospitalSno:%@----self.doctorSno:%@---self.proSno:%@---self.bookdt:%@---self.TrueNames:%@----self.PhoneNos:%@---self.isUseCoupon:%@",self.cusSno,self.hospitalSno,self.doctorSno,self.proSno,self.bookdt,self.TrueNames,self.PhoneNos,self.isUseCoupon);
        
     [self soaprequstWithcusSno:self.cusSno hospitalSno:self.hospitalSno doctorSno:self.doctorSno proSno:self.proSno bookDt:self.bookdt isBookCar:@"0" trueName:self.TrueNames phoneNo:self.PhoneNos isUseCoupon:self.isUseCoupon];
}

-(void)switchMethods:(UISwitch *)swith
{
    
    UISwitch *swi2=(UISwitch *)swith;
    if (swi2.isOn) {
        NSLog(@"On");
        self.ispublic = 1;
         self.isUseCoupon = @"1";
    }else{
        NSLog(@"Off");
        self.ispublic = 0;
        self.isUseCoupon = @"0";
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
-(void)MakeAppointmentcommitretun
{
    [self.navigationController popViewControllerAnimated:YES];
}

//计算字体长度
-(float)NSStringwithsize:(int)a str:(NSString *)string
{
    
    UIFont *font = [UIFont systemFontOfSize:a];
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat strwidth = size.width;
    return strwidth;
}
#pragma mark soap请求
//提交预约
-(void)soaprequstWithcusSno:(NSString *)cusSno hospitalSno:(NSString *)hospitalSno doctorSno:(NSString *)doctorSno proSno:(NSString *)proSno bookDt:(NSString *)bookDt isBookCar:(NSString *)isBookCar trueName:(NSString *)trueName phoneNo:(NSString *)phoneNo isUseCoupon:(NSString *)isUseCoupon
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<CreateCustomerBookOrder2 xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<cusSno>%@</cusSno>\n"
                             "<hospitalSno>%@</hospitalSno>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<proSno>%@</proSno>\n"
                             "<bookDt>%@</bookDt>\n"
                             "<isBookCar>%@</isBookCar>\n"
                             "<trueName>%@</trueName>\n"
                             "<phoneNo>%@</phoneNo>\n"
                             "<isUseCoupon>%@</isUseCoupon>\n"
                             "</CreateCustomerBookOrder2>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,cusSno,hospitalSno,doctorSno,proSno,bookDt,isBookCar,trueName,phoneNo,isUseCoupon
                             ];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/CreateCustomerBookOrder2" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    
    if ([elementName isEqualToString:@"CreateCustomerBookOrder2Result"]) {
        
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
    
    if ([elementName isEqualToString:@"CreateCustomerBookOrder2Result"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"项目详情：dic%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        
        NSString *msg = [dic objectForKey:@"msg"];
        
        // NSString *total = [dic objectForKey:@"total"];
        
        if ([state isEqualToString:@"1"]) {
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
    _soapResults = [[NSMutableString alloc] initWithCapacity:0];//解析开始了，创建空字符串来存
    
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------end--------------");
    
}


@end
