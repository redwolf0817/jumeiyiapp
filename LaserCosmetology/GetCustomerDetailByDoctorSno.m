//
//  GetCustomerDetailByDoctorSno.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "GetCustomerDetailByDoctorSno.h"
#import "TopBarView.h"
#import "MyCusTomerDetails.h"
#import "CustomerDetailcell.h"
#import "checkmedicalredcord.h"
#import "GuestbookChatVC.h"
#import "UPMedicalRecord.h"
#import "PrefixHeader.pch"
@interface GetCustomerDetailByDoctorSno ()

@end

@implementation GetCustomerDetailByDoctorSno

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
    titilelable.text = @"我的客户";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];

    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(comebacks) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    [self soaprequst2WithdoctorSno:self.mydoctorsno customerSno:self.mycustomersno];
}

-(void)creatmycustomerandcustomename:(NSString *)name andphone:(NSString *)phone
{
    
    UILabel *mycustomer = [[UILabel alloc] initWithFrame:CGRectMake(20, 80,120, 20)];
    mycustomer.text = name;
    [self.view addSubview:mycustomer];
    
    UILabel *phonenumber = [[UILabel alloc] initWithFrame:CGRectMake(100, 80,120 , 20)];
    phonenumber.text = phone;
    phonenumber.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phonenumber];
    
    UILabel *Record = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 80, 20)];
    Record.text = @"服务记录";
    Record.textColor = [UIColor redColor];
    [self.view addSubview:Record];
    
    //查看病历
//    UIButton *chakan = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 70, 110, 60, 25)];
//    [chakan setBackgroundImage:[UIImage imageNamed:@"我的客户_03(2)"] forState:UIControlStateNormal];
//    [chakan addTarget:self action:@selector(chakanbingli:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:chakan];
    
    [self creattableview];
    
    _botomview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2 + 30, self.view.bounds.size.width, self.view.bounds.size.height - self.view.bounds.size.height/2 - 30)];
    [self.view addSubview:_botomview];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _botomview.bounds.size.width, _botomview.bounds.size.height)];
    image.userInteractionEnabled = YES;
    image.image = [UIImage imageNamed:@"huisebeijing"];
    [_botomview addSubview:image];
    
    UIButton *updown = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    updown.backgroundColor = [UIColor clearColor];
    [updown addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [_botomview addSubview:updown];

    
    _Thechatrecord = [[UITableView alloc] initWithFrame:CGRectMake(10, 50, self.view.bounds.size.width - 20, _botomview.bounds.size.height - 110)];
    _Thechatrecord.backgroundColor =[UIColor whiteColor];
    _Thechatrecord.delegate = self;
    _Thechatrecord.dataSource = self;
    _Thechatrecord.tag = 21;
    [_botomview addSubview:_Thechatrecord];

    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20,15, 80, 20)];
    lable.text = @"沟通记录";
    lable.textColor = [UIColor redColor];
    lable.userInteractionEnabled = YES;
    [_botomview addSubview:lable];
    

    UIButton *huifu = [[UIButton alloc] initWithFrame:CGRectMake(100, _botomview.bounds.size.height - 50 , self.view.bounds.size.width - 200, 30)];
    [huifu setBackgroundImage:[UIImage imageNamed:@"小按钮s"] forState:UIControlStateNormal];
    [huifu setTitle:@"回复" forState:UIControlStateNormal];
    [huifu addTarget:self action:@selector(huifuclick) forControlEvents:UIControlEventTouchUpInside];
    huifu.layer.masksToBounds = YES;
    huifu.layer.cornerRadius = 4;
    [_botomview addSubview:huifu];
    
}

-(void)creattableview
{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(10, 140, self.view.bounds.size.width - 20 , self.view.bounds.size.height -145 - 50)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.rowHeight = 60;
    //_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.tag = 20;
    [self.view addSubview:_tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)comebacks
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnclick
{
    NSLog(@"上下");
   
    if (self.isup == NO) {
        _botomview.frame = CGRectMake(0, self.view.bounds.size.height - 70, self.view.bounds.size.width, self.view.bounds.size.height - self.view.bounds.size.height/2 + 50);
        self.isup  = YES;
    }else{
        _botomview.frame = CGRectMake(0, self.view.bounds.size.height/2 + 30, self.view.bounds.size.width, self.view.bounds.size.height - self.view.bounds.size.height/2 + 50);
        self.isup = NO;
    }
    
}
-(void)huifuclick
{
    NSLog(@"回复");
    
    GuestbookChatVC *chat = [[GuestbookChatVC alloc] init];
    chat.doctorsno = self.mydoctorsno;
    chat.customerSno = self.mycustomersno;
    [self.navigationController pushViewController:chat animated:YES];
    
    NSLog(@"---self.mycustomersno--%@------self.mydoctorsno-%@-----",self.mycustomersno,self.mydoctorsno);

}
-(void)chakanbingli:(UIButton *)btn
{
    checkmedicalredcord *medicalrecord = [[checkmedicalredcord alloc] init];
    medicalrecord.customersno = self.mycustomersno;
    [self.navigationController pushViewController:medicalrecord animated:YES];
}

#pragma mark tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 20) {
        return _orderDataarray.count;
    }else{
    return _talkDataarray.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 20) {
        static NSString *identifier = @"cell";
        
        CustomerDetailcell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomerDetailcell" owner:nil options:nil] objectAtIndex:0];
        }
        
        MyCusTomerDetails *customer = [_orderDataarray objectAtIndex:indexPath.row];
        cell.productorname.text = customer.ProductorName;
        cell.productorname.font = [UIFont systemFontOfSize:14];
        cell.bookdate.text = customer.CreateDt;
        cell.bookdate.font = [UIFont systemFontOfSize:14];
        
        NSLog(@"-customer.ProductName--%@---%@--",customer.ProductorName,customer.DoctorName);
        
        return cell;

    }else{
    
        static NSString *identifier = @"cell1";
        
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell1) {
            
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        MyCusTomerDetails *customer = [_talkDataarray objectAtIndex:indexPath.row];
        cell1.textLabel.text = customer.TextInfo;
        
        NSLog(@"--customer.TextInfo--%@---",customer.TextInfo);
        
        return cell1;

    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 20) {
          MyCusTomerDetails *customer = [_orderDataarray objectAtIndex:indexPath.row];
        MyCusTomerDetails *mycustomers = [_customerDataarray objectAtIndex:0];
        
        UPMedicalRecord *medicalrecord = [[UPMedicalRecord alloc] init];
        medicalrecord.doctorsno = self.mydoctorsno;
        medicalrecord.orderDetailSno = customer.Sno;
        medicalrecord.productorsno = customer.ProductSno;
        medicalrecord.customersno = self.mycustomersno;
        medicalrecord.name = mycustomers.Name;
        medicalrecord.phonenumber = mycustomers.CellPhone;
        medicalrecord.project = customer.ProductorName;
        medicalrecord.date = customer.BookDt;
        [self.navigationController pushViewController:medicalrecord animated:YES];
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

#pragma mark -- soap请求
//我的客户详情
-(void)soaprequst2WithdoctorSno:(NSString *)doctorSno customerSno:(NSString *)customerSno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerDetailByDoctorSno xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "</GetCustomerDetailByDoctorSno>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,customerSno];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerDetailByDoctorSno" forHTTPHeaderField:@"SOAPAction"];
    
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
    NSLog(@"我的客户的数据--%@",theXML);
    //        NSString *str = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];

}

#pragma mark - XML数据接收
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"GetCustomerDetailByDoctorSnoResult"]) {
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
    
    if ([elementName isEqualToString:@"GetCustomerDetailByDoctorSnoResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"我的客户的数据：dic%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            
            NSMutableArray *customerData = [dic objectForKey:@"customerData"];
            _customerDataarray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *diction in customerData) {
                MyCusTomerDetails *mycustomer = [MyCusTomerDetails MyCusTomerDetailsWithdiction:diction];
                [_customerDataarray addObject:mycustomer];
            }
            
            MyCusTomerDetails *mycustomers = [_customerDataarray objectAtIndex:0];
            [self creatmycustomerandcustomename:mycustomers.Name andphone:mycustomers.CellPhone];
            
            NSMutableArray *orderData = [dic objectForKey:@"orderData"];
            _orderDataarray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *diction in orderData) {
                MyCusTomerDetails *mycustomer = [MyCusTomerDetails MyCusTomerDetailsWithdiction:diction];
                [_orderDataarray addObject:mycustomer];
            }
            [_tableview reloadData];
            
            NSMutableArray *talkData = [dic objectForKey:@"talkData"];
            _talkDataarray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *diction in talkData) {
                MyCusTomerDetails *mycustomer = [MyCusTomerDetails MyCusTomerDetailsWithdiction:diction];
                [_talkDataarray addObject:mycustomer];
            }

        }
        NSString *msg = [dic objectForKey:@"msg"];
        
        if ([state isEqualToString:@"0"]) {
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
