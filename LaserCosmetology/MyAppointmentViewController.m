//
//  MyAppointmentViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/1.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "MyAppointmentViewController.h"
#import "TopBarView.h"
#import "MyAppointmentCollectionVC.h"
#import "MyAppointmentViewLayout.h"
#import "UIImageView+WebCache.h"
#import "customercenter.h"
#import "MyPoIntWebViewController.h"
#import "PrefixHeader.pch"
static NSString * const identifier = @"cell";

@interface MyAppointmentViewController ()

@end

@implementation MyAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height )];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 120, 25)];
    titilelable.text = @"我的预约";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(mypointmakebackbuttonclick1) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];

    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    image.image = [UIImage imageNamed:@"huisebeijing"];
    [self.view addSubview:image];


     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"tunruning" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelclicknotification:) name:@"cancelclick" object:nil];
    
    [self soaprequestwithcustomerSno:self.customerSno];

}
-(void)creatcollectionview
{
    MyAppointmentViewLayout *layout;
    if (!layout) {
        layout = [[MyAppointmentViewLayout alloc]init];
    }
    layout.layouhighary  = self.higthary;
    
    
    if (!self.clView) {
        self.clView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
        self.clView.backgroundColor = [UIColor clearColor];
        [self.clView registerClass:[MyAppointmentCollectionVC class] forCellWithReuseIdentifier:identifier];
        self.clView.dataSource = self;
        self.clView.delegate   = self;
        self.clView.tag = 51;
        self.clView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:self.clView];
        
        
        _refreshControl=[[RefreshControl alloc] initWithScrollView:self.clView delegate:self];
        _refreshControl.topEnabled=YES;
    }

}
- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    if (direction==RefreshDirectionTop)
    {
        NSLog(@"下拉刷新");
        [self soaprequestwithcustomerSno:self.customerSno];
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

-(void)mypointmakebackbuttonclick1
{
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark COllerctionView-dateScore
//告诉有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//告诉有多少个小方块
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mydataarray.count;
    
}
//告诉系统每个小方块展示什么内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //1 从环城池中去cell
    customercenter *cent = [self.mydataarray objectAtIndex:indexPath.row];
    
    MyAppointmentCollectionVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    if ([cent.OrderState isEqualToString:@"20150212170927542"]) {
        [cell.pjbutton setTitle:@"已评价" forState:UIControlStateNormal];
        [cell.pjbutton setTitleColor:[self colorWithRGB:0xb4b4b4 alpha:1] forState:UIControlStateNormal];
        cell.pjbutton.frame = CGRectMake(self.view.bounds.size.width - 160, 130, 50, 25);
        [cell.pjbutton setBackgroundImage:[UIImage imageNamed:@"ank_03"] forState:UIControlStateNormal];
        cell.pjbutton.userInteractionEnabled = NO;
    }else{
        [cell.pjbutton setTitle:@"评价" forState:UIControlStateNormal];
        cell.pjbutton.frame = CGRectMake(self.view.bounds.size.width - 160, 130, 50, 25);
        [cell.pjbutton setTitleColor:[self colorWithRGB:0x00c5bb alpha:1] forState:UIControlStateNormal];
        [cell.pjbutton setBackgroundImage:[UIImage imageNamed:@"ank_05"] forState:UIControlStateNormal];
        cell.pjbutton.userInteractionEnabled = YES;
    }
    
    [cell.imageurlstr sd_setImageWithURL:[NSURL URLWithString:cent.PicSrc]];
    cell.imageurlstr.frame = CGRectMake(5, 10, cell.bounds.size.width/3,cell.bounds.size.width/3 *0.953125);
    
    cell.xingming.text = cent.DoctorName;
    cell.xingming.frame =  CGRectMake(cell.zhuanjia.frame.origin.x + 40, cell.zhuanjia.frame.origin.y,[self NSStringwithsize:17 str:cent.DoctorName], 20);
    
    cell.xiangmuming.text = cent.ProductorName;
    cell.xiangmuming.frame = CGRectMake(cell.xiangmu.frame.origin.x + 40, cell.xiangmu.frame.origin.y,self.view.bounds.size.width - [self NSStringwithsize:17 str:cent.ProductorName] - 10, 20);

    
    cell.shijianshu.text = cent.BookDt;
    cell.shijianshu.frame = CGRectMake(5, 135,[self NSStringwithsize:17 str:cent.BookDt], 20);
    cell.shijianshu.textColor = [self colorWithRGB:0x707070 alpha:1];
    
    cell.didianstr.text = cent.HospitalName;
    cell.didianstr.frame = CGRectMake(cell.didian.frame.origin.x + 40, cell.didian.frame.origin.y,self.view.bounds.size.width - [self NSStringwithsize:17 str:cent.HospitalName] -10, 20);
    
    if ([cent.OrderState isEqualToString:@"20150212170826304"]) {
        cell.cancelbutton.frame = CGRectMake(self.view.bounds.size.width - 90, 130, 80, 25);
        [cell.cancelbutton setTitle:@"已取消" forState:UIControlStateNormal];
        [cell.cancelbutton setTitleColor:[self colorWithRGB:0xb4b4b4 alpha:1] forState:UIControlStateNormal];
        [cell.cancelbutton setBackgroundImage:[UIImage imageNamed:@"ank_03"] forState:UIControlStateNormal];
        cell.cancelbutton.layer.masksToBounds = YES;
        cell.cancelbutton.layer.cornerRadius = 2;
        
    }else{
    
        cell.cancelbutton.frame = CGRectMake(self.view.bounds.size.width - 90, 130, 80, 25);
        [cell.cancelbutton setTitle:@"取消预约" forState:UIControlStateNormal];
        [cell.cancelbutton setBackgroundImage:[UIImage imageNamed:@"ank_05"] forState:UIControlStateNormal];
        [cell.cancelbutton setTitleColor:[self colorWithRGB:0x00c5bb alpha:1] forState:UIControlStateNormal];
        cell.cancelbutton.layer.masksToBounds = YES;
        cell.cancelbutton.layer.cornerRadius = 2;
    }

    
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    customercenter *cent = [self.mydataarray objectAtIndex:indexPath.row];
    
    MyPoIntWebViewController *webview = [[MyPoIntWebViewController alloc] init];
    webview.produtsno = cent.Sno;
    [self.navigationController pushViewController:webview animated:YES];
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
-(void)notification:(NSNotification *)notiy
{
    
    customercenter *cent = [self.mydataarray objectAtIndex:[[notiy object] integerValue]];
     self.customerOrderDetailSno = cent.Sno;
    
    _backview = [[UIView alloc] initWithFrame:self.view.bounds];
    _backview.backgroundColor = [UIColor blackColor];
    _backview.alpha = 0.6;
    [self.view addSubview:_backview];
    
    _tunningview = [[UIView alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, self.view.bounds.size.height/2 + 40 )];
    _tunningview.backgroundColor = [UIColor whiteColor];
    _tunningview.layer.masksToBounds = YES;
    _tunningview.layer.masksToBounds = YES;
    _tunningview.layer.cornerRadius = 4;
    [self.view addSubview:_tunningview];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    background.layer.masksToBounds = YES;
    background.layer.cornerRadius = 4;
    [_tunningview addSubview:background];
    
    
    UIButton *off = [[UIButton alloc] initWithFrame:CGRectMake(5,5 , 35, 35)];
    [off setBackgroundImage:[UIImage imageNamed:@"c"] forState:UIControlStateNormal];
    [off addTarget:self action:@selector(offbuttunclick) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:off];
    
    
    UIButton *send = [[UIButton alloc] initWithFrame:CGRectMake(_tunningview.bounds.size.width - 40, 5, 35, 35)];
    [send setBackgroundImage:[UIImage imageNamed:@"g"] forState:UIControlStateNormal];
    [send addTarget:self action:@selector(sendbuttunclick) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:send];
    
    UILabel *pingjia = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 60, 20)];
    pingjia.text = @"评价:";
    [background addSubview:pingjia];
    
    for (int i = 0; i < 5; i++) {
        
        UIButton *pingjiabtn = [[UIButton alloc] initWithFrame:CGRectMake(25 + [self NSStringwithsize:17 str:@"评价:"] + (22 * i), 50, 18, 18)];
        [pingjiabtn setBackgroundImage:[UIImage imageNamed:@"wujiaoxing_03"] forState:UIControlStateNormal];
        [pingjiabtn addTarget:self action:@selector(pingjiabtnbuttunclick:) forControlEvents:UIControlEventTouchUpInside];
        pingjiabtn.tag = 20 + i;
        [background addSubview:pingjiabtn];
    }
    
    
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 80, _tunningview.bounds.size.width - 20, _tunningview.bounds.size.height - 90)];
    [background addSubview:_textview];
    

}

-(void)cancelclicknotification:(NSNotification *)noti
{
    customercenter *cent = [self.mydataarray objectAtIndex:[[noti object] integerValue]];
    NSString *OrderStatestr = cent.OrderState;
    NSString *ordersno = cent.Sno;
    if ([OrderStatestr isEqualToString:@"20150212170826304"]) {
        return;
    }else{
        [self soaprequestwithsendjudgecustomerOrderDetailSno:ordersno];
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)offbuttunclick
{
    
    NSLog(@"关闭");
    [_backview removeFromSuperview];
    _backview = nil;
    [_tunningview removeFromSuperview];
    _tunningview = nil;
}
-(void)pingjiabtnbuttunclick:(UIButton *)btn
{
    NSLog(@"我点击了第 %ld个星星",btn.tag);
    
    for (int i = 20; i< btn.tag + 1 ; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        [button setBackgroundImage:[UIImage imageNamed:@"wujiaoxing_05"] forState:UIControlStateNormal];
        NSLog(@"评价1");
    }
    
    for (NSInteger i = btn.tag + 1; i < 25; i++) {
        NSLog(@"评价2");
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        [button setBackgroundImage:[UIImage imageNamed:@"wujiaoxing_03"] forState:UIControlStateNormal];
        
    }
    self.evaluateLevel = [NSString stringWithFormat:@"%ld",btn.tag - 19];
    
    
}
-(void)sendbuttunclick
{
    NSLog(@"发送评价");
    self.evaluateContents = _textview.text;
    if (self.evaluateContents.length < 2) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有内容！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show]; return;
    }
    if( self.evaluateLevel == nil)
    {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"选择星级！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show];
        return;
    
    }
    
    [self soaprequestwithsendjudgecustomerOrderDetailSno:self.customerOrderDetailSno evaluateLevel:self.evaluateLevel evaluateContents:self.evaluateContents];
    
    [self offbuttunclick];
}

#pragma mark-- SOAP请求！
//获取客户用户中心我的预约订单数据
-(void)soaprequestwithcustomerSno:(NSString *)customerSno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerBookOrderData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "</GetCustomerBookOrderData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerBookOrderData" forHTTPHeaderField:@"SOAPAction"];
    
    
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


//给医生评价
-(void)soaprequestwithsendjudgecustomerOrderDetailSno:(NSString *)customerOrderDetailSno evaluateLevel:(NSString *)evaluateLevel evaluateContents:(NSString *)evaluateContents
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SendCustomerOrderDetailEvaluate xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerOrderDetailSno>%@</customerOrderDetailSno>\n"
                             "<evaluateLevel>%@</evaluateLevel>\n"
                             "<evaluateContents>%@</evaluateContents>\n"
                             "</SendCustomerOrderDetailEvaluate>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerOrderDetailSno,evaluateLevel,evaluateContents];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SendCustomerOrderDetailEvaluate" forHTTPHeaderField:@"SOAPAction"];
    
    
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

//取消预约
-(void)soaprequestwithsendjudgecustomerOrderDetailSno:(NSString *)customerOrderDetailSno 
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<CancelOrder xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<orderDetailSno>%@</orderDetailSno>\n"
                             "</CancelOrder>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerOrderDetailSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/CancelOrder" forHTTPHeaderField:@"SOAPAction"];
    
    
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

    
    if ([elementName isEqualToString:@"SendCustomerOrderDetailEvaluateResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"GetCustomerBookOrderDataResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"CancelOrderResult"]) {
        
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
    
    if ([elementName isEqualToString:@"SendCustomerOrderDetailEvaluateResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
      //  NSLog(@"发送医生评价返回的数据:%@",dic);
        
        NSString *msg = [dic objectForKey:@"msg"];
        NSString *ret = [dic objectForKey:@"ret"];
        NSString *state = [dic objectForKey:@"state"];
        
        NSLog(@"msg:%@-ret:%@-state:%@",msg,ret,state);
        if ([state isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            [self.clView reloadData];
        }
    }
    
    
    if ([elementName isEqualToString:@"GetCustomerBookOrderDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"我的预约的数据:%@",dic);
        
        NSMutableArray *customerOrderData = [dic objectForKey:@"customerOrderData"];
        self.mydataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in customerOrderData) {
            customercenter *center = [customercenter pointTotalCountwithdiction:diction];
            [self.mydataarray addObject:center];
        }
        
        self.higthary = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < self.mydataarray.count; i++) {
            customercenter *center = [self.mydataarray objectAtIndex:i];
            if (center.EvaluateReturnContents.length > 5) {
                [self.higthary addObject:[NSString stringWithFormat:@"%f",[self contentsWithnsstring:center.EvaluateReturnContents]]];
            }else{
                [self.higthary addObject:@"0"];
            }
        }
       
        [self creatcollectionview];
        [self.clView reloadData];
    }
    
    if ([elementName isEqualToString:@"CancelOrderResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                                                 error:&err];
        NSLog(@"刷新已预约--%@",dic);
        
         [self soaprequestwithcustomerSno:self.customerSno];
        
        NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消预约成功！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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

-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}

@end
