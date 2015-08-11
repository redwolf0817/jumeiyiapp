//
//  mymakeController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "mymakeController.h"
#import "TopBarView.h"
#import "mymakerCell.h"
#import "doctorinmymaker.h"
#import "UPMedicalRecord.h"
#import "PrefixHeader.pch"
@interface mymakeController ()

@end

@implementation mymakeController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:@"0" forKey:@"ishaver"];
    [def synchronize];
    
     self.a = 1;
     _customerOrderDataarray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self soaprequstWithdoctorSno:self.doctorSno customerSno:@"" orderState:@"" strPageindex:@"1" strPagesize:@"15"];
}

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
    titilelable.text = @"我的预约";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(huiqu) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    _refreshControl=[[RefreshControl alloc] initWithScrollView:_table delegate:self];
    _refreshControl.topEnabled=YES;
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updata:) name:@"updata" object:nil];
}


- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    if (direction==RefreshDirectionTop)
    {
        self.a = 1;
        self.istop = YES;
         [self soaprequstWithdoctorSno:self.doctorSno customerSno:@"" orderState:@"" strPageindex:@"1" strPagesize:@"15"];
    }
    else if (direction==RefreshDirectionBottom)
    {
        NSLog(@"上拉刷新");
    }
    
    __weak typeof(self)weakSelf=self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf)strongSelf=weakSelf;
        [strongSelf reloadData];
    });
    
}
-(void)reloadData
{
    
    if (self.refreshControl.refreshingDirection==RefreshingDirectionTop)
    {
        [self.refreshControl finishRefreshingDirection:RefreshDirectionTop];
    }
    else if (self.refreshControl.refreshingDirection==RefreshingDirectionBottom)
    {
        [self.refreshControl finishRefreshingDirection:RefreshDirectionBottom];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 假设偏移表格高度的20%进行刷新
    if (!_isLoading) { // 判断是否处于刷新状态，刷新中就不执行
        // 取内容的高度：
        //    如果内容高度大于UITableView高度，就取TableView高度
        //    如果内容高度小于UITableView高度，就取内容的实际高度
        float height = scrollView.contentSize.height > _table.frame.size.height ?_table.frame.size.height : scrollView.contentSize.height;
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
            // 调用上拉刷新方法
            NSLog(@"到底了");
            _isLoading = YES;
            self.a++;
            _timer1 = [NSTimer scheduledTimerWithTimeInterval:2.50 target:self selector:@selector(shuaxins) userInfo:nil repeats:NO];
            
             [self soaprequstWithdoctorSno:self.doctorSno customerSno:@"" orderState:@"" strPageindex:[NSString stringWithFormat:@"%ld",self.a] strPagesize:@"15"];
            NSLog(@"a的值：%ld",self.a);
        }
        if (- scrollView.contentOffset.y / _table.frame.size.height > 0.2) {
            //            _isLoading = YES;
            //            self.a = 0;
            //            // 调用下拉刷新方法
            //            NSLog(@"到顶了");
            //
            //             _timer1 = [NSTimer scheduledTimerWithTimeInterval:2.50 target:self selector:@selector(shuaxins) userInfo:nil repeats:NO];
        }
    }
    
}
-(void)shuaxins
{
    _isLoading = NO;
    [_timer1 invalidate];
    _timer1 = nil;
    
    NSLog(@"到底了8899");
}

-(void)updata:(NSNotification *)Notification
{
    
    doctorinmymaker *doctor = [_customerOrderDataarray objectAtIndex:[[Notification object] integerValue]];
    
    UPMedicalRecord *medicalrecord = [[UPMedicalRecord alloc] init];
    medicalrecord.productorsno = doctor.Sno;
    medicalrecord.doctorsno = self.doctorSno;
    medicalrecord.customersno = doctor.CusSno;
    medicalrecord.orderDetailSno = doctor.Sno;
    medicalrecord.name = doctor.CusName;
    medicalrecord.phonenumber = doctor.CusPhone;
    medicalrecord.project = doctor.ProductName;
    medicalrecord.date = doctor.BookDt;
    [self.navigationController pushViewController:medicalrecord animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)huiqu
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSLog(@"numberOfRowsInSection--%ld",_customerOrderDataarray.count);
    return _customerOrderDataarray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *identifier = @"cell";
    mymakerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"mymakerCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.tiemess.textColor = [UIColor redColor];
    
    NSLog(@"_customerOrderDataarray.count--%ld",_customerOrderDataarray.count);
    
    doctorinmymaker *doctor = [_customerOrderDataarray objectAtIndex:indexPath.row];
    cell.maketiem.text = doctor.BookDt;
    cell.maketiem.alpha = 0.8;
    cell.name.text = doctor.CusName;
    cell.object.text = doctor.ProductName;
    cell.phonenumber.text = doctor.CusPhone;
    cell.phonenumber.alpha = 0.8;
    
    if ([doctor.NowState isEqualToString:@"1"]) {
        cell.shijianimage1.image = [UIImage imageNamed:@"shijianzhou"];
        [cell.binglibtn setBackgroundImage:[UIImage imageNamed:@"我的预约20150402_03(1)"] forState:UIControlStateNormal];
    }else if ([doctor.NowState isEqualToString:@"2"]){
        cell.shijianimage1.image = [UIImage imageNamed:@"shijianzhou"];
        cell.shijianimage2.image = [UIImage imageNamed:@"shijianzhou"];
        [cell.binglibtn setBackgroundImage:[UIImage imageNamed:@"我的预约20150402_03"] forState:UIControlStateNormal];
    }else if ([doctor.NowState isEqualToString:@"3"]){
        cell.shijianimage1.image = [UIImage imageNamed:@"shijianzhou"];
        cell.shijianimage2.image = [UIImage imageNamed:@"shijianzhou"];
        cell.shijianimage3.image = [UIImage imageNamed:@"shijianzhou"];
        [cell.binglibtn setBackgroundImage:[UIImage imageNamed:@"我的预约20150402_06"] forState:UIControlStateNormal];
    }else{
        
    
    }
    NSLog(@"时间轴--------------> %@",doctor.NowState);
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;

}

#pragma mark -- soap请求
//获取预约了该医生的订单数据
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno customerSno:(NSString *)customerSno orderState:(NSString *)orderState
                  strPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorCusOrderData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<orderState>%@</orderState>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetDoctorCusOrderData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,customerSno,orderState,strPageindex,strPagesize];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorCusOrderData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
//    NSLog(@"我的预约的数据--%@",theXML);
    
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
    
    if ([elementName isEqualToString:@"GetDoctorCusOrderDataResult"]) {
        
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
    
    if ([elementName isEqualToString:@"GetDoctorCusOrderDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
       // NSLog(@"医生里面我的预约资料的数据：dic%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        
        NSString *msg = [dic objectForKey:@"msg"];
        
        if (self.istop == YES) {
            [_customerOrderDataarray removeAllObjects];
            self.istop = NO;
        }
        
        NSMutableArray *customerOrderData = [dic objectForKey:@"customerOrderData"];
        for (NSDictionary *diction in customerOrderData) {
            doctorinmymaker *doctor = [doctorinmymaker mymakerWithDiction:diction];
            [_customerOrderDataarray addObject:doctor];
        }
        [_table reloadData];
        
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
