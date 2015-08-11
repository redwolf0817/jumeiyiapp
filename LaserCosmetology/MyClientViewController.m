//
//  MyClientViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "MyClientViewController.h"
#import "TopBarView.h"
#import "myClientCell.h"
#import "mycustomerdata.h"
#import "GetCustomerDetailByDoctorSno.h"
#import "PrefixHeader.pch"
@interface MyClientViewController ()

@end

@implementation MyClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"huisebeijing"];
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
    [backbtn addTarget:self action:@selector(comeback) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    NSArray *btntitle = [[NSArray alloc] initWithObjects:@"正在服务",@"预约",@"休眠客户", nil];
    float btnwidth = (self.view.bounds.size.width - 20)/3;
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((5 + btnwidth) * i + 5, 75, btnwidth, 30)];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:[btntitle objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //[btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn addTarget:self action:@selector(xuanxaing:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 20 + i;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 4;
        [self.view addSubview:btn];
    }
    

    
    _headnamearray = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];

    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 125, self.view.bounds.size.width, self.view.bounds.size.height - 125)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.rowHeight = 80;
    _tableview.layer.cornerRadius = 8;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.tag = 60;
    [self.view addSubview:_tableview];
    
    _refreshControl=[[RefreshControl alloc] initWithScrollView:_tableview delegate:self];
    _refreshControl.topEnabled=YES;
    //_refreshControl.bottomEnabled=YES;//会崩
    
    _mycustomerDataarray = [[NSMutableArray alloc] initWithCapacity:0];
    
    self.typeInfo = @"";  self.a = 1;
    [self soaprequst2WithdoctorSno:self.doctorsno typeInfo:self.typeInfo firstWord:@"" strPageindex:@"1" strPagesize:@"15"];
    
    
    UITableView *headnametableview = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 45, 115, 45, self.view.bounds.size.height - 120)];
    headnametableview.delegate = self;
    headnametableview.dataSource = self;
    headnametableview.rowHeight = 20;
    headnametableview.tag = 61;
    headnametableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:headnametableview];
    
}

- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    if (direction==RefreshDirectionTop)
    {
        NSLog(@"下拉刷新");
        self.a = 1;
        self.istop = YES;
         [self soaprequst2WithdoctorSno:self.doctorsno typeInfo:self.typeInfo firstWord:@"" strPageindex:@"1" strPagesize:@"15"];
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
        float height = scrollView.contentSize.height > _tableview.frame.size.height ?_tableview.frame.size.height : scrollView.contentSize.height;
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
            // 调用上拉刷新方法
            NSLog(@"到底了");
            _isLoading = YES;
            self.a++;
            _timer1 = [NSTimer scheduledTimerWithTimeInterval:2.50 target:self selector:@selector(shuaxins) userInfo:nil repeats:NO];

             [self soaprequst2WithdoctorSno:self.doctorsno typeInfo:self.typeInfo firstWord:@"" strPageindex:[NSString stringWithFormat:@"%ld",self.a] strPagesize:@"15"];
            
            NSLog(@"a的值：%ld",self.a);
        }
        if (- scrollView.contentOffset.y / _tableview.frame.size.height > 0.2) {
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


-(void)comeback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)xuanxaing:(UIButton *)button
{
    NSLog(@"button.tag-%ld",button.tag);
    
    if (button.tag == 20) {
        self.typeInfo = @"1";
        UIButton *butn1 = (UIButton *)[self.view viewWithTag:21];
        UIButton *butn2 = (UIButton *)[self.view viewWithTag:22];
        [butn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [butn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }else if (button.tag == 21){
        
        UIButton *butn1 = (UIButton *)[self.view viewWithTag:20];
        UIButton *butn2 = (UIButton *)[self.view viewWithTag:22];
        [butn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [butn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
        self.typeInfo = @"2";
    }else{
    self.typeInfo = @"3";
        
        UIButton *butn1 = (UIButton *)[self.view viewWithTag:20];
        UIButton *butn2 = (UIButton *)[self.view viewWithTag:21];
        [butn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [butn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    [self soaprequst2WithdoctorSno:self.doctorsno typeInfo:self.typeInfo firstWord:@"" strPageindex:@"1" strPagesize:@"15"];

    
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

#pragma mark tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 60) {
        return _mycustomerDataarray.count;
    }else{
        return 26;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 60) {
        
        static NSString *identifier = @"cell";
        
        myClientCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"myClientCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 8;
        mycustomerdata *mycustom = [_mycustomerDataarray objectAtIndex:indexPath.row];
        
        cell.xiaoview.layer.masksToBounds = YES;
        cell.xiaoview.layer.cornerRadius = 5;
        
        cell.customname.text = mycustom.TrueName;
        cell.customname.font = [UIFont systemFontOfSize:14];
        
        cell.customphone.text = mycustom.CellPhone;
        cell.customphone.font = [UIFont systemFontOfSize:14];
        
        cell.customordproduction.text = mycustom.BuyProductNames;
        cell.customordproduction.font = [UIFont systemFontOfSize:14];
        
        return cell;

    }else{
    
        static NSString *ident = @"cell1";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:ident];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        }
        cell1.textLabel.text = [_headnamearray objectAtIndex:indexPath.row];
        cell1.textLabel.font = [UIFont systemFontOfSize:15];
        cell1.textLabel.textColor = [UIColor redColor];
    
        return cell1;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 60) {
        
        mycustomerdata *mycustom = [_mycustomerDataarray objectAtIndex:indexPath.row];
        self.customersno = mycustom.Sno;
        
        GetCustomerDetailByDoctorSno *getcustomdetail = [[GetCustomerDetailByDoctorSno alloc] init];
        getcustomdetail.mydoctorsno = self.doctorsno;
        getcustomdetail.mycustomersno = self.customersno;
        [self.navigationController pushViewController:getcustomdetail animated:YES];
        
    }else{
    
     self.firstWord = [_headnamearray objectAtIndex:indexPath.row];
    
        
        [self soaprequst2WithdoctorSno:self.doctorsno typeInfo:self.typeInfo firstWord:self.firstWord strPageindex:@"1" strPagesize:@"40"];
        
    }

    
}


#pragma mark -- soap请求
//我的客户
-(void)soaprequst2WithdoctorSno:(NSString *)doctorSno typeInfo:(NSString *)typeInfo firstWord:(NSString *)firstWord strPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerByDoctorSno xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<typeInfo>%@</typeInfo>\n"
                             "<firstWord>%@</firstWord>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetCustomerByDoctorSno>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,typeInfo,firstWord,strPageindex,strPagesize];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerByDoctorSno" forHTTPHeaderField:@"SOAPAction"];
    
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
    NSLog(@"我的客户的数据--%@",theXML);
    
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
    
    if ([elementName isEqualToString:@"GetCustomerByDoctorSnoResult"]) {
        
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
    
    if ([elementName isEqualToString:@"GetCustomerByDoctorSnoResult"]) {
        
        
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"我的客户的数据：dic%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        
        NSString *msg = [dic objectForKey:@"msg"];
        
        if (self.istop == YES) {
            [_mycustomerDataarray removeAllObjects];
            self.istop = NO;
        }
        
        NSMutableArray *customerData = [dic objectForKey:@"customerData"];
        for (NSDictionary *mycusdiction in customerData) {
            mycustomerdata *mycustom = [mycustomerdata mycustomerdataWithdiction:mycusdiction];
            [_mycustomerDataarray addObject:mycustom];
        }
        [_tableview reloadData];
        
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
