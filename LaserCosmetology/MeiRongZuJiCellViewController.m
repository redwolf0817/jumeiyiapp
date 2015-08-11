//
//  MeiRongZuJiCellViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/1.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "MeiRongZuJiCellViewController.h"
#import "TopBarView.h"
#import "customercenter.h"
#import "UIImageView+WebCache.h"

#import "MeiRongZuJiCollectionviewcell.h"
#import "MeiRongZuJiCollectionLayout.h"
#import "MeiRongZuJiCellVCperson.h"
#import "customerBeautifyLogData.h"
#import "discuse.h"//评论内容
#import "UpLoadingHeadImage.h"
#import "PrefixHeader.pch"
static NSString * const identifier = @"cell";

@interface MeiRongZuJiCellViewController ()

@end

@implementation MeiRongZuJiCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 160, 25)];
    titilelable.text = @"我的美容足迹";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(meirongzujibackbuttonclick1) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
    self.customersno = [userdf objectForKey:@"customerSno"];
    
    UIButton *xiezuji = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 50, 30, 30, 25)];
    [xiezuji setBackgroundImage:[UIImage imageNamed:@"个人美容足迹1_03"] forState:UIControlStateNormal];
    [xiezuji addTarget:self action:@selector(writedate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xiezuji];
    
    if (self.customersno == nil) {
        self.customersno = [[NSUserDefaults standardUserDefaults] objectForKey:@"customerSno"];
    }
    
        _contentshightarray = [[NSMutableArray alloc] initWithCapacity:0];
        _logDataarray = [[NSMutableArray alloc] initWithCapacity:0];
     self.a = 1;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancell:) name:@"shanchu" object:nil];
    
}
- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    if (direction==RefreshDirectionTop)
    {
        self.isloding = YES;
        NSLog(@"下拉刷新");
        self.a = 1;
         [self soaprequestwithcustomerSno:self.customersno strPageindex:@"1" strPagesize:@"40"];
        
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
    
    if (!self.isshuaxin) { // 判断是否处于刷新状态，刷新中就不执行
        // 取内容的高度：
        //    如果内容高度大于UITableView高度，就取TableView高度
        //    如果内容高度小于UITableView高度，就取内容的实际高度
        float height = scrollView.contentSize.height > _clView.frame.size.height ?_clView.frame.size.height : scrollView.contentSize.height;
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
//            // 调用上拉刷新方法
//            NSLog(@"到底了");
//            self.isshuaxin = YES;
//            self.a++;
            _timer1 = [NSTimer scheduledTimerWithTimeInterval:2.50 target:self selector:@selector(shuaxins) userInfo:nil repeats:NO];
            
            NSLog(@"self.a--到底了---%ld",self.a);
            
//             [self soaprequestwithcustomerSno:self.customersno strPageindex:[NSString stringWithFormat:@"%ld",self.a] strPagesize:@"40"];
        }
        if (- scrollView.contentOffset.y / _clView.frame.size.height > 0.2) {
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
    self.isshuaxin = NO;
    [_timer1 invalidate];
    _timer1 = nil;
    
   
}


-(void)writedate
{
    UpLoadingHeadImage *uploadingimage = [[UpLoadingHeadImage alloc] init];
    uploadingimage.customerSno = self.customersno;
    uploadingimage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:uploadingimage animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.isloding = YES;
    [self soaprequestwithcustomerSno:self.customersno strPageindex:@"1" strPagesize:@"40"];
    
}

-(void)cancell:(NSNotification *)notification
{
    NSInteger str = [[notification object] integerValue];
    
    customerBeautifyLogData *log = [_logDataarray objectAtIndex:str];
    self.logSno = log.Sno;
    
    [_logDataarray removeObjectAtIndex:str];
    
   
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要删除本条足迹吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertview show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

   
    if (buttonIndex == 0) {
        return;
    }else{
        [self soaprequestwithcustomerSno:self.customersno logSno:self.logSno];
    }
}
-(void)creatcollectionview
{
    MeiRongZuJiCollectionLayout *_layout;
    if (!_layout) {
      _layout = [[MeiRongZuJiCollectionLayout alloc]init];
         _layout.higtharrar = _contentshightarray;
    }else{
     _layout.higtharrar = _contentshightarray;
    }
   

    NSLog(@"_contentshightarray--3-->%ld",_contentshightarray.count);
    
    if (!_clView) {
        _clView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height- 64) collectionViewLayout:_layout];
        _clView.backgroundColor = [UIColor clearColor];
        [_clView registerClass:[MeiRongZuJiCollectionviewcell class] forCellWithReuseIdentifier:identifier];
        _clView.dataSource = self;
        _clView.delegate = self;
        _clView.tag = 51;
        _clView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_clView];
        
        _refreshControl=[[RefreshControl alloc] initWithScrollView:_clView delegate:self];
        _refreshControl.topEnabled=YES;
        //_refreshControl.bottomEnabled=YES;//会崩
    }

}
-(void)meirongzujibackbuttonclick1
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

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
    CGSize size = CGSizeMake(self.view.bounds.size.width - 25,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}
#pragma mark COllerctionView-dateScore
//告诉有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//告诉有多少个小方块
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"_logDataarray.count--1-->%ld",_logDataarray.count);
    return _logDataarray.count;
    
}
//告诉系统每个小方块展示什么内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //1 从环城池中去cell
    MeiRongZuJiCollectionviewcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
     NSLog(@"_logDataarray.count--2-->%ld",_logDataarray.count);
    customerBeautifyLogData *customer = [_logDataarray objectAtIndex:indexPath.row];
    
//    NSMutableArray *picstrarray = [[NSMutableArray alloc] initWithCapacity:0];
//    NSMutableArray *dicary = customer.LogPicData;


    [cell.imageurlstr1 sd_setImageWithURL:[NSURL URLWithString:@""]];
    [cell.imageurlstr2 sd_setImageWithURL:[NSURL URLWithString:@""]];
    

    if (customer.PicSrc2.length < 5) {
        [cell.imageurlstr1 sd_setImageWithURL:[NSURL URLWithString:customer.PicSrc]];
    }else{
        [cell.imageurlstr1 sd_setImageWithURL:[NSURL URLWithString:customer.PicSrc2]];
        [cell.imageurlstr2 sd_setImageWithURL:[NSURL URLWithString:customer.PicSrc]];
    }

    cell.imagefenge.frame = CGRectMake(0, cell.bounds.size.height - 2, cell.bounds.size.width, 2);
    cell.imagefenge.image = [UIImage imageNamed:@"fenge"];
    

    NSInteger c = 0;
//    if (picstrarray.count > 3) {
//        c = 1;
//    }else{
//     c = picstrarray.count / 2;
//    }
   
    float hight = (c + 1) * 160;
    
    cell.CreateDt.text = customer.CreateDt;
    cell.CreateDt.frame = CGRectMake(10, hight + 15,[self NSStringwithsize:14 str:customer.CreateDt],  20);
    cell.CreateDt.textColor = [UIColor redColor];

    
    cell.Contents.text = customer.Contents;
    cell.Contents.alpha = 0.75;
    cell.Contents.font = [UIFont systemFontOfSize:15];
    cell.Contents.frame = CGRectMake(10, hight + 38,cell.bounds.size.width - 20 ,[self contentsWithnsstring:customer.Contents]);
    //[self jianjucontentLabel:cell.Contents];
    
    cell.pinglun.frame = CGRectMake(10, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 5, 60, 20);
    
    cell.DiscussCount.text = customer.DiscussCount;
    cell.DiscussCount.textColor = [UIColor redColor];
    cell.DiscussCount.frame = CGRectMake(40 + 10, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 5, 100, 20);
    
    cell.liulan.frame = CGRectMake(120, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 5, 60, 20);
    
    cell.ClickCount.text = customer.ClickCount;
    cell.ClickCount.textColor = [UIColor redColor];
    cell.ClickCount.frame = CGRectMake(160, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 5, 100, 20);
    
    cell.button.frame = CGRectMake(cell.bounds.size.width - 80, cell.Contents.frame.origin.y + cell.Contents.frame.size.height, 60, 25);
    
    
    UIView *vie = (UIView *)[cell viewWithTag:3];
    if (vie) {
        [vie removeFromSuperview];
    }
    
    UIView *moreDiscussCounts = [[UIView alloc] initWithFrame:CGRectMake(5, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 30, cell.bounds.size.width - 15,cell.bounds.size.height - (cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 30))];
    moreDiscussCounts.backgroundColor = [UIColor clearColor];
    moreDiscussCounts.tag = 3;
    [cell addSubview:moreDiscussCounts];
    
//    discuse *discus = [[discuse alloc] initWithFrame:moreDiscussCounts.bounds and:[self.pinglunARRAYary objectAtIndex:indexPath.item]];
//    [moreDiscussCounts addSubview:discus];
    
   
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_clView.collectionViewLayout invalidateLayout];//刷新前调用该方法，不会崩。
    
    customerBeautifyLogData *customer = [_logDataarray objectAtIndex:indexPath.row];
    
    MeiRongZuJiCellVCperson *zuji = [[MeiRongZuJiCellVCperson alloc] init];
    zuji.sno = customer.Sno;
    
    [self.navigationController pushViewController:zuji animated:YES];
    
}

//字体行间距
-(CGSize)jianjucontentLabel:(UILabel *)contentLabel
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:contentLabel.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentLabel.text.length)];
    contentLabel.attributedText = attributedString;
    
    //调节高度
    CGSize size = CGSizeMake(self.view.bounds.size.width - 20, 500000);
    CGSize labelSize = [contentLabel sizeThatFits:size];
    
    return labelSize;
}

-(CGFloat)contentsWithPinglunnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 100,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}
-(void)reloaddata
{
     [self soaprequestwithcustomerSno:self.customersno strPageindex:@"1" strPagesize:@"40"];
    
}

#pragma mark-- SOAP请求！
//获取指定客户的美容日志数据
-(void)soaprequestwithcustomerSno:(NSString *)customerSno strPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetMyCustomerBeautifyLogData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetMyCustomerBeautifyLogData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,strPageindex,strPagesize];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetMyCustomerBeautifyLogData" forHTTPHeaderField:@"SOAPAction"];
    
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
//根据日志标识删除美容日志数据
-(void)soaprequestwithcustomerSno:(NSString *)customerSno logSno:(NSString *)logSno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<DeleteCustomerBeautifyLogBySno xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<logSno>%@</logSno>\n"
                             "</DeleteCustomerBeautifyLogBySno>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,logSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/DeleteCustomerBeautifyLogBySno" forHTTPHeaderField:@"SOAPAction"];
    
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
//        NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
//        NSLog(@"请求回来的数据--%@",theXML);
    

    
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
    
    
    if ([elementName isEqualToString:@"GetMyCustomerBeautifyLogDataResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    
    if ([elementName isEqualToString:@"DeleteCustomerBeautifyLogBySnoResult"]) {
        
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
    if ([elementName isEqualToString:@"GetMyCustomerBeautifyLogDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"我的美容足迹--%@--",dic);
        if (self.isloding == YES) {
            [_logDataarray removeAllObjects];
            [_contentshightarray removeAllObjects];
            self.isloding = NO;
        }
        
        NSLog(@"_logDataarray----4---> %ld",_logDataarray.count);
        
        NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            self.pinglunARRAYary = [[NSMutableArray alloc] initWithCapacity:0];//预存读条足迹的评论数组
            NSMutableArray *logData = [dic objectForKey:@"customerBeautifyLogData"];

            for (NSDictionary *diction in logData) {
                customerBeautifyLogData *BeautifyLogData = [customerBeautifyLogData customerBeautifyLogDataWithDiction:diction];
                [_logDataarray addObject:BeautifyLogData];
                
                CGFloat a = [self contentsWithnsstring:BeautifyLogData.Contents] + 200 + [BeautifyLogData.DiscussCount floatValue];
                
                NSMutableArray *pinglunarray = [[NSMutableArray alloc] initWithCapacity:0];
                CGFloat b = 0;
                NSMutableArray *DiscussDataarray = [diction objectForKey:@"LogDiscussData"];
                for (NSDictionary  *diction1 in DiscussDataarray) {
                    customerBeautifyLogData *BeautifyLogData = [customerBeautifyLogData customerBeautifyLogDataWithDiction:diction1];
                    [pinglunarray addObject:BeautifyLogData];
                    NSLog(@"字典里的对象-%@",[diction1 objectForKey:@"ManSno"]);
                    b = b + [self contentsWithPinglunnsstring:[diction1 objectForKey:@"Contents"]] + 5;//每个评论的高度加十间隔
                }
                
                [self.pinglunARRAYary addObject:pinglunarray];
                
                NSMutableArray *PicSrcarray = [[NSMutableArray alloc] initWithCapacity:0];
                NSMutableArray *LogPicDataarray = [diction objectForKey:@"LogPicData"];
                for (NSDictionary  *diction1 in LogPicDataarray) {
                    NSString *str = [diction1 objectForKey:@"PicSrc"];
                    if (str.length > 5) {
                        [PicSrcarray addObject:[diction1 objectForKey:@"PicSrc"]];
                    }
                }
                NSInteger  c = PicSrcarray.count / 2;
                if (c > 1) {
                    c = 1;
                }
                float hight = c * 160;
                
                NSLog(@"实际多高:PicSrcarray.count的值是： %@",[NSString stringWithFormat:@"%f",a + 40+ hight + b]);
                [_contentshightarray addObject:[NSString stringWithFormat:@"%f",a + 40+ hight + b]];//内容的高度 + 评论的高度 + 图片的高度
            }
           [self creatcollectionview];
            
            [_clView reloadData];
        }
        
        
    }
    
        
        if ([elementName isEqualToString:@"DeleteCustomerBeautifyLogBySnoResult"]) {
            
            NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            NSLog(@"删除个人美容足迹数据的数据:%@",dic);
            
            NSString *state = [dic objectForKey:@"state"];
            NSString *msg = [dic objectForKey:@"msg"];
            
            if ([state isEqualToString:@"1"]) {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alter show];
                
                if (_clView) {
                    [_clView removeFromSuperview];
                    _clView = nil;
                    self.isloding  = YES;
                }
                
                [self reloaddata];
                
               
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
