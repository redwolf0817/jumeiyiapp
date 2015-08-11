//
//  MakeAppointment.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/5.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "MakeAppointment.h"
#import "TopBarView.h"
#import "mybutton.h"
#import "yuyuexiandeqingqiu.h"
#import "MakeAppointmentcommit.h"
#import "PrefixHeader.pch"
@interface MakeAppointment ()

@end

@implementation MakeAppointment

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"获取的hospitalSno ：%@",self.hospitalSno);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"订单详情";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];

    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 45)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 50, 20)];
    name.text = @"姓 名:";
    [view1 addSubview:name];
    
    _nametextfield = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, self.view.bounds.size.width - 90 , 30)];
    _nametextfield.backgroundColor = [UIColor whiteColor];
    if (self.TrueNames.length >= 2) {
        _nametextfield.text = self.TrueNames;
    }else{
     _nametextfield.placeholder = @"请输入您的真实姓名！";
    }
    _nametextfield.layer.masksToBounds = YES;
    _nametextfield.layer.cornerRadius = 4;
    [view1 addSubview:_nametextfield];
    
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 111, self.view.bounds.size.width, 45)];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    
    UILabel *phone = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 50, 20)];
    phone.text = @"手 机:";
    [view2 addSubview:phone];
    
    _phonetextfield = [[UITextField alloc] initWithFrame:CGRectMake(70, 5, self.view.bounds.size.width - 90 , 30)];
    _phonetextfield.backgroundColor = [UIColor whiteColor];
    _phonetextfield.text = self.PhoneNos;
    _phonetextfield.layer.masksToBounds = YES;
    _phonetextfield.layer.cornerRadius = 4;
    [view2 addSubview:_phonetextfield];
    
    UIView *view30 = [[UIView alloc] initWithFrame:CGRectMake(0, 168, self.view.bounds.size.width, 45)];
    view30.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view30];
    
    UILabel *project = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 20)];
    project.text = @"项目名称:";
    [view30 addSubview:project];
    
    _projectname = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, self.view.bounds.size.width - 90, 30)];
    _projectname.backgroundColor = [UIColor whiteColor];
    _projectname.text = self.proname;
    _projectname.layer.masksToBounds = YES;
    _projectname.layer.cornerRadius = 4;
    _projectname.font = [UIFont systemFontOfSize:16];
    [view30 addSubview:_projectname];
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 215, self.view.bounds.size.width, 45)];
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];
    
    UILabel *expert = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 50, 20)];
    expert.text = @"专 家:";
    [view3 addSubview:expert];
    
    _experttextview = [[UITextView alloc] initWithFrame:CGRectMake(70, 5, self.view.bounds.size.width - 90, 30)];
    _experttextview.backgroundColor = [UIColor whiteColor];
    _experttextview.editable = NO;
    _experttextview.text = self.doctornames;
    _experttextview.layer.masksToBounds = YES;
    _experttextview.layer.cornerRadius = 4;
    _experttextview.font = [UIFont systemFontOfSize:16];
    [view3 addSubview:_experttextview];
    
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(0, 262, self.view.bounds.size.width, 45)];
    view5.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view5];
    
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 50, 20)];
    address.text = @"医 院:";
    [view5 addSubview:address];
    
    _addresstextview = [[UITextView alloc] initWithFrame:CGRectMake(70, 5, self.view.bounds.size.width - 90, 30)];
    _addresstextview.backgroundColor = [UIColor whiteColor];
    _addresstextview.editable = NO;
    _addresstextview.text = self.hostitalname;
    _addresstextview.layer.masksToBounds = YES;
    _addresstextview.layer.cornerRadius = 4;
    _addresstextview.font = [UIFont systemFontOfSize:15];
    [view5 addSubview:_addresstextview];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 318, self.view.bounds.size.width, 45)];
    view4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view4];
    
    UILabel *times = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 50, 20)];
    times.text = @"时 间:";
    [view4 addSubview:times];
    
    _timestextview = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, self.view.bounds.size.width - 90, 20)];
    _timestextview.backgroundColor = [UIColor whiteColor];
    _timestextview.text = self.date;
    _timestextview.layer.masksToBounds = YES;
    _timestextview.layer.cornerRadius = 4;
    _timestextview.font = [UIFont systemFontOfSize:16];
    _timestextview.textColor = [UIColor redColor];
    [view4 addSubview:_timestextview];
    

    
    UIView *view6 = [[UIView alloc] initWithFrame:CGRectMake(0, 365, self.view.bounds.size.width, 45)];
    view6.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view6];
    
    _dingjin = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 20)];
    _dingjin.text = @"定 金:";
    [view6 addSubview:_dingjin];
    
    _jine = [[UILabel alloc] initWithFrame:CGRectMake(25 + [self NSStringwithsize:17 str:_dingjin.text], 5, 100, 30)];
    _jine.backgroundColor = [UIColor whiteColor];
    _jine.layer.masksToBounds = YES;
    _jine.layer.cornerRadius = 4;
    _jine.font = [UIFont systemFontOfSize:15];
    _jine.textColor = [UIColor redColor];
    _jine.text = self.ProBookAmoumt;
    [view6 addSubview:_jine];
    
    _dingjinleixing = [[UILabel alloc] initWithFrame:CGRectMake(30 + [self NSStringwithsize:17 str:_dingjin.text] + [self NSStringwithsize:15 str:_jine.text], 10, 30, 20)];
    _dingjinleixing.text = @"元";
    [view6 addSubview:_dingjinleixing];

    
    UIButton *commit = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - (self.view.bounds.size.width * 0.446/2), self.view.bounds.size.height * 0.701 + 50, self.view.bounds.size.width * 0.446, 40)];
    [commit setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    [commit setTitle:@"确认订单" forState:UIControlStateNormal];
    [commit addTarget:self action:@selector(commitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    commit.layer.masksToBounds = YES;
    commit.layer.cornerRadius = 4;
    [self.view addSubview:commit];
    
    
   NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.cusSno = [user objectForKey:@"customerSno"];
    _phonetextfield.text = [user objectForKey:@"customerphonenumber"];
    
    
    [self soaprequestwithdoctorSno:self.doctorSno proSno:self.proSno customerSno:self.cusSno];
}
-(void)creatshoose
{
    _projectname.text = self.proname;
    _jine.text = self.ProBookAmoumt;
    _dingjinleixing.frame = CGRectMake(30 + [self NSStringwithsize:17 str:_dingjin.text] + [self NSStringwithsize:15 str:_jine.text], 10, 30, 20);
    
//    if ([self.isHaveCoupon isEqualToString:@"1"]) {
//        _segment = [[UISegmentedControl alloc] initWithItems:@[@"抵扣",@"不抵扣"]];
//        _segment.frame = CGRectMake(20, 340, 100, 20);
//        [_segment addTarget:self action:@selector(segmentchengeclick:) forControlEvents:UIControlEventValueChanged];
//        _segment.selectedSegmentIndex = 0;
//        self.isUseCoupon = @"1";
//        [self.view addSubview:_segment];
//    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)backbuttonclick
{
    [self.navigationController popViewControllerAnimated:YES];
   

}
-(void)choosebuttonclick:(mybutton *)btn{
    
    if (btn.isclick == YES) {
        
        [btn setBackgroundImage:[UIImage imageNamed:@"yuwenjiesao"] forState:UIControlStateNormal];
        btn.isclick = NO;
        
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
        btn.isclick = YES;
    }
    
}
-(void)commitbtnclick
{

    if (_nametextfield.text.length < 2) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入姓名！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show];
        return;
    }else if(_phonetextfield.text.length < 11){
        
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入手机号！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show];
        return;
    }else if(_phonetextfield.text.length > 11){
        
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号格式不对！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show];
        return;
    }else{
        if (self.saleSno.length > 0) {
            [self soaprequestwithsaleSno:self.saleSno customerSno:self.cusSno trueName:self.TrueNames phoneNo:self
             .PhoneNos];
        }else{
            
            [self totonext];
        }
        return;
    }

}
-(void)totonext
{
    MakeAppointmentcommit *make = [[MakeAppointmentcommit alloc]init];
    
    make.proname = self.proname;
    make.shu = self.ProBookAmoumt;
    make.shu2 = self.ProBookAmoumt;
    
    make.cusSno = self.cusSno;
    make.hospitalSno = self.hospitalSno;
    make.doctorSno = self.doctorSno;
    make.proSno = self.proSno;
    make.bookdt = self.date;
    make.TrueNames = _nametextfield.text;
    make.PhoneNos = _phonetextfield.text;
    make.isUseCoupon = self.isUseCoupon;
    
    [self.navigationController pushViewController:make animated:YES];
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
#pragma mark --SOAP请求
//生成抢购订单数据
-(void)soaprequestwithsaleSno:(NSString *)saleSno customerSno:(NSString *)customerSno trueName:(NSString *)trueName  phoneNo:(NSString *)phoneNo
{
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<AddBeautifyProductSaleData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<saleSno>%@</saleSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<trueName>%@</trueName>\n"
                             "<phoneNo>%@</phoneNo>\n"
                             "</AddBeautifyProductSaleData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,saleSno,customerSno,trueName,phoneNo];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/AddBeautifyProductSaleData" forHTTPHeaderField:@"SOAPAction"];
    
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


//获取预约提交前数据 医院-项目等
-(void)soaprequestwithdoctorSno:(NSString *)doctorSno proSno:(NSString *)proSno customerSno:(NSString *)customerSno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetBeforeBookData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<proSno>%@</proSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "</GetBeforeBookData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,proSno,customerSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetBeforeBookData" forHTTPHeaderField:@"SOAPAction"];
    
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
    
    if ([elementName isEqualToString:@"GetBeforeBookDataResult"]) {
        
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
            
            [self backbuttonclick];
        }else{
        
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
 
    }
    
    if ([elementName isEqualToString:@"GetBeforeBookDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"预约前详情：dic%@",dic);
        
        self.isHaveCoupon = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isHaveCoupon"]];
        
        NSMutableArray *DoctorProData = [dic objectForKey:@"DoctorProData"];
        _DoctorProDataary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in DoctorProData) {
            yuyuexiandeqingqiu *yuyuexian = [yuyuexiandeqingqiu yuyuexiandeshujuWithdiction:diction];
            self.ProBookAmoumt = yuyuexian.ProBookAmoumt;
            self.proname = yuyuexian.BeautifyProName;
            [_DoctorProDataary addObject:yuyuexian];
        }
        
        NSMutableArray *customerData = [dic objectForKey:@"customerData"];
        _customerDataary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction1 in customerData) {
            yuyuexiandeqingqiu *yuyuexian = [yuyuexiandeqingqiu yuyuexiandeshujuWithdiction:diction1];
            self.TrueNames = yuyuexian.TrueName;
            _nametextfield.text = yuyuexian.TrueName;
            [_customerDataary addObject:yuyuexian];
        }
        
        NSMutableArray *hospitalDoctorRelateData = [dic objectForKey:@"hospitalDoctorRelateData"];
        _hospitalDoctorRelateDataary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction2 in hospitalDoctorRelateData) {
            yuyuexiandeqingqiu *yuyuexian = [yuyuexiandeqingqiu yuyuexiandeshujuWithdiction:diction2];
            [_hospitalDoctorRelateDataary addObject:yuyuexian];
        }
        
        [self creatshoose];
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
