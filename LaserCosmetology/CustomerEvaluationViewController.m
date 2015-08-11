//
//  CustomerEvaluationViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "CustomerEvaluationViewController.h"
#import "TopBarView.h"
#import "customerViewCell.h"
#import "evaluateDoctorData.h"
#import "PrefixHeader.pch"
@interface CustomerEvaluationViewController ()

@end

@implementation CustomerEvaluationViewController

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
    titilelable.text = @"客户评价";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(comeback) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.showsVerticalScrollIndicator = NO;
    _tableview.showsHorizontalScrollIndicator = NO;
   // tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.rowHeight = 110;
    [self.view addSubview:_tableview];
    
    
    self.a = 1;
    _refreshControl=[[RefreshControl alloc] initWithScrollView:_tableview delegate:self];
    _refreshControl.topEnabled=YES;
    //_refreshControl.bottomEnabled=YES;//会崩
    
     _evaluateDoctorDataarray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self soaprequstWithdoctorSno:self.doctorsno customerSno:@"" strPageindex:@"1" strPagesize:@"20"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pingjia:) name:@"qupingjia" object:nil];
}

- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    if (direction==RefreshDirectionTop)
    {
        NSLog(@"下拉刷新");
        self.a = 1;
        self.istop = YES;
         [self soaprequstWithdoctorSno:self.doctorsno customerSno:@"" strPageindex:@"1" strPagesize:@"20"];
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
             [self soaprequstWithdoctorSno:self.doctorsno customerSno:@"" strPageindex:[NSString stringWithFormat:@"%ld",self.a] strPagesize:@"20"];
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

-(void)pingjia:(NSNotification *)notification
{
    NSInteger intstr = [[notification object] integerValue];
    evaluateDoctorData *evaluate = [_evaluateDoctorDataarray objectAtIndex:intstr];
    self.orderDetailSno = evaluate.Sno;
    
    if (_backview == nil) {
        
        _backview = [[UIView alloc] initWithFrame:self.view.bounds];
        _backview.backgroundColor = [UIColor blackColor];
        _backview.alpha = 0.6;
        [self.view addSubview:_backview];
    }

    if (_tunningview == nil) {
        
        _tunningview = [[UIView alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, self.view.bounds.size.height/2 )];
        _tunningview.backgroundColor = [UIColor whiteColor];
        _tunningview.layer.masksToBounds = YES;
        _tunningview.layer.masksToBounds = YES;
        _tunningview.layer.cornerRadius = 4;
        [self.view addSubview:_tunningview];
    }
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    background.layer.masksToBounds = YES;
    background.layer.cornerRadius = 4;
    [_tunningview addSubview:background];
    
    UIButton *off = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 35, 35)];
    [off setBackgroundImage:[UIImage imageNamed:@"c"] forState:UIControlStateNormal];
    [off addTarget:self action:@selector(offbuttunclick) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:off];
    
    UIButton *send = [[UIButton alloc] initWithFrame:CGRectMake(_tunningview.bounds.size.width - 40, 5, 35, 35)];
    [send setBackgroundImage:[UIImage imageNamed:@"g"] forState:UIControlStateNormal];
    [send addTarget:self action:@selector(sendbuttunclickd) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:send];
    
    
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, _tunningview.bounds.size.width - 20, _tunningview.bounds.size.height - 60)];
    [background addSubview:_textview];

}
-(void)offbuttunclick{
    
    if (_backview != nil) {
        [_backview removeFromSuperview];
        _backview = nil;
    }
    
    if (_tunningview != nil) {
        [_tunningview removeFromSuperview];
        _tunningview = nil;
    }
    
}

-(void)sendbuttunclickd
{
    if (_backview != nil) {
        [_backview removeFromSuperview];
        _backview = nil;
    }
    
    if (_tunningview != nil) {
        [_tunningview removeFromSuperview];
        _tunningview = nil;
    }
    
    if (_textview.text.length < 2) {

        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示！" message:@"内容不能为空！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定！", nil];
        [alter show];
        return;
    }

    [self soaprequstWithdoctorSno:self.doctorsno orderDetailSno:self.orderDetailSno replyInfo:_textview.text];
    

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
    return _evaluateDoctorDataarray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    customerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[customerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    evaluateDoctorData *doctorevaluate = [_evaluateDoctorDataarray objectAtIndex:indexPath.row];
    
    cell.xing1.image = [UIImage imageNamed:@"客户评价_05a"];
    cell.xing2.image = [UIImage imageNamed:@"客户评价_05a"];
    cell.xing3.image = [UIImage imageNamed:@"客户评价_05a"];
    cell.xing4.image = [UIImage imageNamed:@"客户评价_05a"];
    cell.xing5.image = [UIImage imageNamed:@"客户评价_05a"];
    
    if ([doctorevaluate.EvaluateLevel isEqualToString:@"0"]) {
        cell.xing1.image = [UIImage imageNamed:@"客户评价_05a"];
        cell.xing2.image = [UIImage imageNamed:@"客户评价_05a"];
        cell.xing3.image = [UIImage imageNamed:@"客户评价_05a"];
        cell.xing4.image = [UIImage imageNamed:@"客户评价_05a"];
        cell.xing5.image = [UIImage imageNamed:@"客户评价_05a"];
    }else if ([doctorevaluate.EvaluateLevel isEqualToString:@"1"]){
    
        cell.xing1.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing2.image = [UIImage imageNamed:@"客户评价_05a"];
        cell.xing3.image = [UIImage imageNamed:@"客户评价_05a"];
        cell.xing4.image = [UIImage imageNamed:@"客户评价_05a"];
        cell.xing5.image = [UIImage imageNamed:@"客户评价_05a"];
    }else if ([doctorevaluate.EvaluateLevel isEqualToString:@"2"]){
    
        cell.xing1.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing2.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing3.image = [UIImage imageNamed:@"客户评价_05a"];
        cell.xing4.image = [UIImage imageNamed:@"客户评价_05a"];
        cell.xing5.image = [UIImage imageNamed:@"客户评价_05a"];
    }else if ([doctorevaluate.EvaluateLevel isEqualToString:@"3"]){
    
        cell.xing1.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing2.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing3.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing4.image = [UIImage imageNamed:@"客户评价_05a"];
        cell.xing5.image = [UIImage imageNamed:@"客户评价_05a"];
    }else if ([doctorevaluate.EvaluateLevel isEqualToString:@"4"]){
        
        cell.xing1.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing2.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing3.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing4.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing5.image = [UIImage imageNamed:@"客户评价_05a"];
    }else{
        cell.xing1.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing2.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing3.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing4.image = [UIImage imageNamed:@"客户评价_03a"];
        cell.xing5.image = [UIImage imageNamed:@"客户评价_03a"];
    }
    
    if ([doctorevaluate.IsReturnEvaluate isEqualToString:@"0"]) {
        [cell.huifu setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [cell.huifu setTitle:@"回复" forState:UIControlStateNormal];
         cell.huifu.userInteractionEnabled = YES;
    }else{
     [cell.huifu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [cell.huifu setTitle:@"已回复" forState:UIControlStateNormal];
        cell.huifu.userInteractionEnabled = NO;
    }

    
    cell.phonenumber.text = doctorevaluate.CusPhone;
    cell.contents.text = doctorevaluate.EvaluateContents;
    cell.contents.alpha = 0.8;
    cell.dates.text = doctorevaluate.EvaluateDt;
    cell.retunstring.text = [NSString stringWithFormat:@"我的回复:%@",doctorevaluate.EvaluateReturnContents];
    cell.retunstring.alpha = 0.8;
    
    cell.contents.frame = CGRectMake(10, 60, self.view.bounds.size.width - 20, [self contentsWithnsstring:cell.contents.text]);
    cell.dates.frame = CGRectMake(10, 65 + [self contentsWithnsstring:cell.contents.text], self.view.bounds.size.width - 20, 20);
    cell.huifu.frame = CGRectMake(self.view.bounds.size.width - 60, 50 + [self contentsWithnsstring:cell.contents.text], 60, 50);
    cell.retunstring.frame = CGRectMake(10, 70 + [self contentsWithnsstring:cell.contents.text] + 20, self.view.bounds.size.width - 20, [self contentsWithnsstring:cell.retunstring.text]);
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    evaluateDoctorData *doctorevaluate = [_evaluateDoctorDataarray objectAtIndex:indexPath.row];
    NSString *str = [NSString stringWithFormat:@"我的回复:%@",doctorevaluate.EvaluateReturnContents];
    return 100 + [self contentsWithnsstring:doctorevaluate.EvaluateContents] + [self contentsWithnsstring:str];

}
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 20,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
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

#pragma mark -- soap请求
//获取客户关怀
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno customerSno:(NSString *)customerSno strPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetEvaluateDoctorData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetEvaluateDoctorData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,customerSno,strPageindex,strPagesize];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetEvaluateDoctorData" forHTTPHeaderField:@"SOAPAction"];
    
    
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

//医生回复客户订单评价
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno orderDetailSno:(NSString *)orderDetailSno replyInfo:(NSString *)replyInfo
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<DoctorReplyEvaluate xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<orderDetailSno>%@</orderDetailSno>\n"
                             "<replyInfo>%@</replyInfo>\n"
                             "</DoctorReplyEvaluate>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,orderDetailSno,replyInfo];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/DoctorReplyEvaluate" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    NSLog(@"我的预约的数据--%@",theXML);
    
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
    
    if ([elementName isEqualToString:@"GetEvaluateDoctorDataResult"]) {
        
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
    
    if ([elementName isEqualToString:@"GetEvaluateDoctorDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"客户关怀的数据：dic%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        
        NSString *msg = [dic objectForKey:@"msg"];
        if (self.istop == YES) {
            [_evaluateDoctorDataarray removeAllObjects];
            self.istop = NO;
        }
        
        NSMutableArray *evaluateDoctorDatas = [dic objectForKey:@"evaluateDoctorData"];
        for (NSDictionary *diction in evaluateDoctorDatas) {
            evaluateDoctorData *evaluate = [evaluateDoctorData evaluateDoctorDataWithdictionnary:diction];
            [_evaluateDoctorDataarray addObject:evaluate];
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
