//
//  MainViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "MainViewController.h"
#import "Detailsproject.h"
#import "UIImageView+WebCache.h"
#import "HuQiJingsharManage.h"
#import "zujigerenzhongxinViewController.h"
#import "BottomBarView.h"
#import "MaiTabieTableViewCell.h"
#import "UIButton+WebCache.h"
#import "MainWebViewController.h"
#import "BeautyFootprint.h"
#import "PrefixHeader.pch"
static NSString * const identifier = @"cell";

@interface MainViewController ()

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self creatNSTimer];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *ishaver = [def objectForKey:@"ishaver"];

    float botomerhight = 0.130667 * self.view.bounds.size.width;
    
    float x = self.view.bounds.size.width/5;

    if (!self.redbutton) {
        self.redbutton = [[UIButton alloc] initWithFrame:CGRectMake(3 * x + x/2 + 4,7 + self.view.bounds.size.height - botomerhight, 9, 9)];
        [self.view addSubview:self.redbutton];
    }

    
    if ([ishaver isEqualToString:@"1"]) {
        [self.redbutton setBackgroundImage:[UIImage imageNamed:@"个人中心44_03"] forState:UIControlStateNormal];
        
    }else{
        [self.redbutton setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
    }

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   [[HuQiJingsharManage shareManage] addObserver:self forKeyPath:@"sssss" options:NSKeyValueObservingOptionNew context:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self starlocation];

    TopBarView *topbar= [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"首页";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIImageView *dingweiimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 32, 12, 18)];
    dingweiimage.image = [UIImage imageNamed:@"location"];
    [topbar addSubview:dingweiimage];
    
    
    _locationbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 120, 25)];
    [_locationbtn setTitle:@"城市" forState:UIControlStateNormal];
    [_locationbtn addTarget:self action:@selector(shooseCiTy) forControlEvents:UIControlEventTouchUpInside];
    _locationbtn.backgroundColor = [UIColor clearColor];
    [_locationbtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [topbar addSubview:_locationbtn];
    
    float botomerhight = 0.130667 * self.view.bounds.size.width;

    _maintableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 - botomerhight)];
    _maintableview.delegate = self;
    _maintableview.dataSource = self;
    _maintableview.tag = 66;
    _maintableview.showsVerticalScrollIndicator = NO;
    _maintableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_maintableview];

    _refreshControl=[[RefreshControl alloc] initWithScrollView:_maintableview delegate:self];
    _refreshControl.topEnabled=YES;
    //_refreshControl.bottomEnabled=YES;//会崩
    
    [self soaprequstwithcity:@"" cityTypeNo:@"" isgetcitydate:@"1"];
    
    
    UIImageView *tabBarimage = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - botomerhight, self.view.bounds.size.width, botomerhight)];
    tabBarimage.image = [UIImage imageNamed:@"首页1_01ss"];
    [self.view addSubview:tabBarimage];
    
    BottomBarView *botom = [[BottomBarView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - botomerhight, self.view.bounds.size.width, botomerhight)];
    [self.view addSubview:botom];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chengeindexpage:) name:@"changeNotification" object:nil];

}


- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    
    if (direction==RefreshDirectionTop)
    {
        NSLog(@"下拉刷新");
        [self starlocation];
        [self soaprequstwithcity:self.CiTy cityTypeNo:self.cityNo isgetcitydate:@"1"];
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

//动态scrollerview
-(void)creatscrollerviewwitharray:(NSArray *)array
{
    NSInteger arraylong = [array count] ;
    
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.width/2.133333)];
        self.kuangaobi = self.view.bounds.size.width/150; ;
        _scrollview.contentSize = CGSizeMake(self.view.bounds.size.width * arraylong, 0);
        _scrollview.contentOffset = CGPointMake(0, 0);
        _scrollview.pagingEnabled = YES;
        _scrollview.delegate = self;
        _scrollview.backgroundColor = [UIColor whiteColor];
        
        _pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2.133333 - 20,  180, 120, 12)];
        [_pagecontrol addTarget:self action:@selector(pagecontrolclick) forControlEvents:UIControlEventTouchUpInside];
        _pagecontrol.numberOfPages = arraylong;
        _pagecontrol.center = CGPointMake(self.view.bounds.size.width  - 70, 180);
    }

    for (int i = 1 ; i < arraylong + 1; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * (i-1), 0, self.view.bounds.size.width , self.view.bounds.size.width/2.133333)];
        [imageview sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:i - 1]]];
        [_scrollview addSubview:imageview];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * (i-1), 0, self.view.bounds.size.width , self.view.bounds.size.width/2.133333)];
        [button addTarget:self action:@selector(webviewbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 80 + i;
        [_scrollview addSubview:button];
    }

    [self creatNSTimer];

}
-(void)webviewbtnclick:(UIButton *)button
{
    
    MainWebViewController *webv = [[MainWebViewController alloc] init];
    webv.url = [_DireUrlarray objectAtIndex:button.tag - 81];
    [self.navigationController pushViewController:webv animated:YES];
    
}
-(void)creatNSTimer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timelink) userInfo:nil repeats:YES];
    }
}
//KVO传值
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString *discciti = [change objectForKey:@"new"];
    
    self.tabBarController.selectedIndex = [discciti integerValue];
    if (self.tabBarController.selectedIndex == 4) {
        self.tabBarController.navigationItem.hidesBackButton = YES;
    }
    
    self.tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.y, self.view.bounds.size.height + 10, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);

}
-(void)chengeindexpage:(NSNotification *)noti
{
    self.tabBarController.selectedIndex = 3;
    
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
#pragma  mark   scrollview 的代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int a = _scrollview.contentOffset.x/self.view.bounds.size.width;
    _pagecontrol.currentPage = a;
    
}

-(void)pagecontrolclick
{
    _scrollview.contentOffset = CGPointMake((self.view.bounds.size.width) * _pagecontrol.currentPage, 0);

}
#pragma mark --SOAP请求
//获取首页的数据
-(void)soaprequstwithcity:(NSString *)city cityTypeNo:(NSString *)cityNo isgetcitydate:(NSString *)citydate
{

    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerDefaultPageData3 xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<cityName>%@</cityName>\n"
                             "<cityTypeNo>%@</cityTypeNo>\n"
                             "<isGetCityData>%@</isGetCityData>\n"
                             "</GetCustomerDefaultPageData3>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,
                             city,cityNo,citydate];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerDefaultPageData3" forHTTPHeaderField:@"SOAPAction"];
    
    
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
#pragma mark---根据城市名获取城市编码---
-(void)soaprequstwithCiTyNo:(NSString *)CityNo
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCityNoByCityName xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<cityName>%@</cityName>\n"
                             "</GetCityNoByCityName>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,
                             CityNo];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCityNoByCityName" forHTTPHeaderField:@"SOAPAction"];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  按钮绑定的方法
//定时器
-(void)timelink
{
    NSInteger a = [_itemimage count];
  static  int speed = 1;
   
    if (_pagecontrol.currentPage == (a - 1) || _pagecontrol.currentPage == 0) {
        speed = -speed;
    }
     _pagecontrol.currentPage += speed;
    _scrollview.contentOffset = CGPointMake((self.view.bounds.size.width) * _pagecontrol.currentPage, 0);
    
}

-(void)EightButtonClassificationBtnClick:(UIButton *)button
{
   
    discount *dis = [_proTopDataary objectAtIndex:button.tag - 60];

    Detailsproject *details = [[Detailsproject alloc] init];
    details.sno = dis.InfoSno;
    details.EnumName = dis.Title;
    [self.navigationController pushViewController:details animated:YES];

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
   // NSHTTPURLResponse *urlresponse = (NSHTTPURLResponse *)response;
   // NSLog(@"状态码----》%ld",(long)[urlresponse statusCode]);
   // NSLog(@"响应头部信息---》%@",[urlresponse allHeaderFields]);
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
    //NSLog(@"connection: didReceiveData:2");
    
}

//如果电脑没有连接网络，则出现此信息（不是网络服务器不通）
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   // NSLog(@"ERROR with theConenction");

    // NSLog(@"ERROR with theConenction");[error description]
    UIAlertView * alert =
    [[UIAlertView alloc]
     initWithTitle:@"提示"
     message:@"链接超时或无网络！"
     delegate:self
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil];
    [alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // NSLog(@"3 DONE. Received Bytes: %ld", [webData length]);
//    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
//    NSLog(@"美容首页请求回来的数据--%@",theXML);
    
    
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

    if ([elementName isEqualToString:@"GetCustomerDefaultPageData3Result"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"GetCityNoByCityNameResult"]) {
        
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
    
    
    if ([elementName isEqualToString:@"GetCustomerDefaultPageData3Result"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"根据城市获取数据：%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        //NSString *msg = [dic objectForKey:@"msg"];
        
        if ([state isEqualToString:@"0"]) {
            return;
        }
       
        NSMutableArray *proTopData = [dic objectForKey:@"proTopData"];
        _proTopDataary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dict in proTopData) {
            discount *disct = [discount PicSrcwithdictionary:dict];
            [_proTopDataary addObject:disct];
        }
        
        
        NSArray *scrollerviewimagename = [dic objectForKey:@"focusData"];
        _itemimage = [[NSMutableArray alloc] initWithCapacity:0];
        _DireUrlarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic in scrollerviewimagename) {
            NSString *adtra = [dic objectForKey:@"PicSrc"];
            NSString *DireUrl = [dic objectForKey:@"DireUrl"];
            [_itemimage addObject:adtra];
            [_DireUrlarray addObject:DireUrl];
        }
        [self creatscrollerviewwitharray:_itemimage];
        
        NSArray *itemlist = [dic objectForKey:@"favorableProData"];
        _discountary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic2 in itemlist) {
            discount *disct = [discount PicSrcwithdictionary:dic2];
            [_discountary addObject:disct];
        }
        
        NSArray *startor = [dic objectForKey:@"pushDoctorData"];
        _starary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dic3 in startor) {
            discount *disct = [discount PicSrcwithdictionary:dic3];
            [_starary addObject:disct];
        }
       
        NSArray *zuji = [dic objectForKey:@"pushLogData"];//美容足迹
        _zujiarray = [[NSMutableArray alloc] initWithCapacity:0];
        _cellhightarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *citydict in zuji) {
            discount *disct = [discount PicSrcwithdictionary:citydict];
            [_zujiarray addObject:disct];
            
            //整个瀑布流单元格的高度
            NSString *cellhightstr = [NSString stringWithFormat:@"%f",40 + (self.view.bounds.size.width - 15)/2 + 20 + [self contentsWithnsstring:disct.Contents]];
            [_cellhightarray addObject:cellhightstr];
        }

        [_maintableview reloadData];
        
         NSArray *chengshishuju = [dic objectForKey:@"cityTypeData"];//城市数据
        _citidate = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *citydict in chengshishuju) {
            discount *disct = [discount PicSrcwithdictionary:citydict];
            [_citidate addObject:disct];
        }
        
        if (self.isjudge == NO) {
            BOOL iseq = YES;
            
            static int a = 0;
            //里面有异步运行段
            for (discount *disc in _citidate) {
                if (_locationcityN.count > 0) {
                    a++;
                    if ([disc.EnumName isEqualToString:[_locationcityN objectAtIndex:0]]) {
                        iseq = NO;
                        return;
                    }
                    self.isjudge = YES; //return;
                    if (a == _citidate.count) {
                        if (iseq == YES) {
                            [self alerterviewwithTitle:@"温馨提示" Mes:@"您所在的城市没有适合的机构，请选择以下城市" Cancel:@"取消"  Other:@"进入选择" IsShow:iseq];
                            _locationcityN = nil;
                        }
                        
                    }
                }
  
                }
            
            //有相等的进来
        }
        
        NSLog(@"state运行状态-5---");
    }
    
    //根据定位的城市名获取城市的编码（就一个城市的）
    if ([elementName isEqualToString:@"GetCityNoByCityNameResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *Dictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                                     error:&err];
        
        NSLog(@"根据定位的城市名获取城市的编码（就一个城市的）Dictionary%@",Dictionary);

        
        NSString *CityNo = [Dictionary objectForKey:@"cityNo"];
        self.cityNo = CityNo;//获取城市编码
        NSMutableDictionary *citydictin =[[NSMutableDictionary alloc] init];
        
        if (_locationcityN.count > 0) {
            
            [citydictin setValue:[_locationcityN objectAtIndex:0] forKey:@"cityname"];
            [citydictin setValue:CityNo forKey:@"cityno"];
        }
 
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:citydictin forKey:@"citydiction"];
        [defaults synchronize];
        
        if (_locationcityN.count > 0) {
            
            if ([_locationcityN objectAtIndex:0]) {
                self.CiTy = [_locationcityN objectAtIndex:0];
                [self soaprequstwithcity:[_locationcityN objectAtIndex:0] cityTypeNo:self.cityNo isgetcitydate:@"1"];
                
            }
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
#pragma mark---UIAlertView方法及其协议
-(void)alerterviewwithTitle:(NSString *)title Mes:(NSString *)message Cancel:(NSString *)cancsl Other:(NSString *)other IsShow:(BOOL)a
{
    if (a == YES) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancsl otherButtonTitles:other, nil];
        [aler show];
    }

    return;

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (buttonIndex == 0) {
        //点击了取消按钮
    }else{
     //点击了确定按钮按钮，进入城市的选择
        [self shooseCiTy];
    }

}
-(void)shooseCiTy
{
    if (!_citytableview) {
        _citytableview = [[UITableView alloc] initWithFrame:CGRectMake(15, 60, 70, 140)];
        _citytableview.delegate = self;
        _citytableview.dataSource = self;
        _citytableview.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_citytableview];
        
    }else{
        [_citytableview removeFromSuperview];
        _citytableview = nil;
    }

   }


//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = CGSizeMake((self.view.bounds.size.width - 30)/2  + 2,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    
    return gaodu;
}


#pragma mark------UITableView协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 66) {
        return 4;
    }else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 66) {
        if (section == 0) {
            return 1;
        }else if(section == 1){
            return 1;
        }else if(section == 2){
        return _zujiarray.count;
        }else{
            return 1;
        }
    }else{
     return [_citidate count];
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 66) {
        static NSString *identifier = @"maincell";
        MaiTabieTableViewCell *maincell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!maincell) {
            maincell = [[MaiTabieTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        maincell.btItemerimageurl1.frame = CGRectMake( 0, 0, 0, 0);
        [maincell.btItemerimageurl1 sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal];
        maincell.btItemerimageurl2.frame = CGRectMake( 0, 0, 0, 0);
        [maincell.btItemerimageurl2 sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal];
        maincell.btItemerimageurl3.frame = CGRectMake( 0, 0, 0, 0);
        [maincell.btItemerimageurl3 sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal];
        maincell.btItemerimageurl4.frame = CGRectMake( 0, 0, 0, 0);
        [maincell.btItemerimageurl4 sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal];
        maincell.btItemerimageurl5.frame = CGRectMake( 0, 0, 0, 0);
        [maincell.btItemerimageurl5 sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal];
        maincell.btItemerimageurl6.frame = CGRectMake( 0, 0, 0, 0);
        [maincell.btItemerimageurl6 sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal];
        maincell.btItemerimageurl7.frame = CGRectMake( 0, 0, 0, 0);
        [maincell.btItemerimageurl7 sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal];
        maincell.btItemerimageurl8.frame = CGRectMake( 0, 0, 0, 0);
        [maincell.btItemerimageurl8 sd_setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal];
        
        maincell.hengimage.frame = CGRectMake(0, 0,0, 0);
        maincell.hengimage.image = [UIImage imageNamed:@""];
        
        maincell.Locationimage.frame = CGRectMake(0, 0, 0, 0);
        maincell.Locationimage.image = [UIImage imageNamed:@""];
        
        maincell.LocationStr.frame = CGRectMake(0, 0, 0, 0);
        maincell.LocationStr.text =@"";

        [maincell.PersonerimageStr1 sd_setImageWithURL:[NSURL URLWithString:@""]];
        maincell.PersonerimageStr1.frame = CGRectMake(0, 0, 0, 0);
        
        [maincell.PersonerimageStr2 sd_setImageWithURL:[NSURL URLWithString:@""]];
        maincell.PersonerimageStr2.frame = CGRectMake(0, 0, 0, 0);
        maincell.Cellview.frame = CGRectMake(0, 0, 0, 0);
        
        maincell.projectimage.frame = CGRectMake(0, 0, 0, 0);
        maincell.projectimage.image = [UIImage imageNamed:@""];
        
        maincell.doctorname.frame = CGRectMake(0, 0,0, 0);
        maincell.doctorname.text = @"";
        
        maincell.hostadress.frame = CGRectMake(0, 0,0, 0);
        maincell.hostadress.text = @"";
        
        maincell.PersonernameStr.frame = CGRectMake(0, 0, 0, 0);
        maincell.PersonernameStr.text = @"";
        
        maincell.projecttype.frame = CGRectMake(0, 0,0, 0);
        maincell.projecttype.text = @"";
        
        maincell.contentexts.text = @"";
        maincell.contentexts.frame = CGRectMake(0,  0,  0, 0);
        
        [maincell.PersonerheadimageUrl sd_setImageWithURL:[NSURL URLWithString:@""]];
        maincell.PersonerheadimageUrl.frame = CGRectMake(0, 0, 0, 0);
        
        maincell.Pinglunimage.frame = CGRectMake(0, 0 , 0, 0);
        maincell.Pinglunimage.image = [UIImage imageNamed:@""];
        
        maincell.Pingluncuonts.frame = CGRectMake(0, 0 , 0, 0);
        maincell.Pingluncuonts.text = @"";
        
        maincell.Liulanimage.frame = CGRectMake(0, 0, 0, 0);
        maincell.Liulanimage.image = [UIImage imageNamed:@""];
        
        maincell.Liulancuonts.frame = CGRectMake(0, 0, 0, 0);
        maincell.Liulancuonts.text = @"";
        
        if (indexPath.section == 0) {
            
            maincell.Cellview.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width/2.133333);
            [maincell.Cellview addSubview:_scrollview];
            
        }else if (indexPath.section == 1){
            maincell.Cellview.frame = CGRectMake(self.view.bounds.size.width, 0, 0, 0);
            
            maincell.backgroundColor = [UIColor whiteColor];
            
            float EightButtonkuandu = (self.view.bounds.size.width - 10)/4;

            discount *dids1 = [_proTopDataary objectAtIndex:0];
            maincell.btItemerimageurl1.frame = CGRectMake( 2, 0, EightButtonkuandu, EightButtonkuandu);
            [maincell.btItemerimageurl1 sd_setBackgroundImageWithURL:[NSURL URLWithString:dids1.PicSrc] forState:UIControlStateNormal];
            maincell.btItemerimageurl1.tag = 60;
            [maincell.btItemerimageurl1 addTarget:self action:@selector(EightButtonClassificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            discount *dids2 = [_proTopDataary objectAtIndex:1];
            maincell.btItemerimageurl2.frame = CGRectMake( (EightButtonkuandu + 2) * (1 % 4) + 2, (EightButtonkuandu + 2) * (1/4), EightButtonkuandu, EightButtonkuandu);
            [maincell.btItemerimageurl2 sd_setBackgroundImageWithURL:[NSURL URLWithString:dids2.PicSrc] forState:UIControlStateNormal];
            maincell.btItemerimageurl2.tag = 61;
            [maincell.btItemerimageurl2 addTarget:self action:@selector(EightButtonClassificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            discount *dids3 = [_proTopDataary objectAtIndex:2];
           maincell.btItemerimageurl3.frame = CGRectMake( (EightButtonkuandu + 2) * (2 % 4) + 2, (EightButtonkuandu + 2) * (2/4), EightButtonkuandu, EightButtonkuandu);
            [maincell.btItemerimageurl3 sd_setBackgroundImageWithURL:[NSURL URLWithString:dids3.PicSrc] forState:UIControlStateNormal];
            maincell.btItemerimageurl3.tag = 62;
            [maincell.btItemerimageurl3 addTarget:self action:@selector(EightButtonClassificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            discount *dids4 = [_proTopDataary objectAtIndex:3];
           maincell.btItemerimageurl4.frame = CGRectMake( (EightButtonkuandu + 2) * (3 % 4) + 2, (EightButtonkuandu + 2) * (3/4), EightButtonkuandu, EightButtonkuandu);
            [maincell.btItemerimageurl4 sd_setBackgroundImageWithURL:[NSURL URLWithString:dids4.PicSrc] forState:UIControlStateNormal];
            maincell.btItemerimageurl4.tag = 63;
            [maincell.btItemerimageurl4 addTarget:self action:@selector(EightButtonClassificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            discount *dids5 = [_proTopDataary objectAtIndex:4];
           maincell.btItemerimageurl5.frame = CGRectMake( (EightButtonkuandu + 2) * (4 % 4) + 2, (EightButtonkuandu + 2) * (4/4), EightButtonkuandu, EightButtonkuandu);
            [maincell.btItemerimageurl5 sd_setBackgroundImageWithURL:[NSURL URLWithString:dids5.PicSrc] forState:UIControlStateNormal];
            maincell.btItemerimageurl5.tag = 64;
            [maincell.btItemerimageurl5 addTarget:self action:@selector(EightButtonClassificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            discount *dids6 = [_proTopDataary objectAtIndex:5];
           maincell.btItemerimageurl6.frame = CGRectMake( (EightButtonkuandu + 2) * (5 % 4) + 2, (EightButtonkuandu + 2) * (5/4), EightButtonkuandu, EightButtonkuandu);
            [maincell.btItemerimageurl6 sd_setBackgroundImageWithURL:[NSURL URLWithString:dids6.PicSrc] forState:UIControlStateNormal];
            maincell.btItemerimageurl6.tag = 65;
            [maincell.btItemerimageurl6 addTarget:self action:@selector(EightButtonClassificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            discount *dids7 = [_proTopDataary objectAtIndex:6];
           maincell.btItemerimageurl7.frame = CGRectMake( (EightButtonkuandu + 2) * (6 % 4) + 2, (EightButtonkuandu + 2) * (6/4), EightButtonkuandu, EightButtonkuandu);
            [maincell.btItemerimageurl7 sd_setBackgroundImageWithURL:[NSURL URLWithString:dids7.PicSrc] forState:UIControlStateNormal];
            maincell.btItemerimageurl7.tag = 66;
            [maincell.btItemerimageurl7 addTarget:self action:@selector(EightButtonClassificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            discount *dids8 = [_proTopDataary objectAtIndex:7];
           maincell.btItemerimageurl8.frame = CGRectMake( (EightButtonkuandu + 2) * (7 % 4) + 2, (EightButtonkuandu + 2) * (7/4), EightButtonkuandu, EightButtonkuandu);
            [maincell.btItemerimageurl8 sd_setBackgroundImageWithURL:[NSURL URLWithString:dids8.PicSrc] forState:UIControlStateNormal];
            maincell.btItemerimageurl8.tag = 67;
            [maincell.btItemerimageurl8 addTarget:self action:@selector(EightButtonClassificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            }else if (indexPath.section == 2){
                
            maincell.hengimage.frame = CGRectMake(0, 0, self.view.bounds.size.width, 5);
            maincell.hengimage.image = [UIImage imageNamed:@"fenge"];
                
            maincell.Cellview.frame = CGRectMake(self.view.bounds.size.width, 0, 0, 0);
            discount *disc = [_zujiarray objectAtIndex:indexPath.row];
            
            [maincell.PersonerheadimageUrl sd_setImageWithURL:[NSURL URLWithString:disc.UserPicSrc]];
            maincell.PersonerheadimageUrl.frame = CGRectMake(10, 7, 25, 25);
            maincell.PersonerheadimageUrl.layer.masksToBounds = YES;
            maincell.PersonerheadimageUrl.layer.cornerRadius = 12.5;
                
            maincell.PersonernameStr.frame = CGRectMake(45, 11, 80, 20);
            maincell.PersonernameStr.text = disc.TrueName;
            maincell.PersonernameStr.font = [UIFont systemFontOfSize:13];
            maincell.PersonernameStr.alpha = 1.75;
                
            maincell.Locationimage.frame = CGRectMake(self.view.bounds.size.width - 65, 12, 16, 16);
            maincell.Locationimage.image = [UIImage imageNamed:@"chengshi"];
                
            maincell.LocationStr.frame = CGRectMake(self.view.bounds.size.width - 50, 10, 60, 20);
            if (disc.CityName.length < 1) {
            maincell.LocationStr.text =@"城市";
            }else{
            maincell.LocationStr.text = disc.CityName;
            }
            maincell.LocationStr.font = [UIFont systemFontOfSize:12];
            maincell.LocationStr.alpha = 0.60;
                
            [maincell.PersonerimageStr1 sd_setImageWithURL:[NSURL URLWithString:disc.PicSrc2]];
            maincell.PersonerimageStr1.frame = CGRectMake(5, 40, (self.view.bounds.size.width - 15)/2, (self.view.bounds.size.width - 15)/2);

            [maincell.PersonerimageStr2 sd_setImageWithURL:[NSURL URLWithString:disc.PicSrc]];
            maincell.PersonerimageStr2.frame = CGRectMake((self.view.bounds.size.width - 15)/2 + 10, 40, (self.view.bounds.size.width - 15)/2, (self.view.bounds.size.width - 15)/2);

            maincell.projectimage.frame = CGRectMake(10, 44 + (self.view.bounds.size.width - 15)/2, 9, 12);
            maincell.projectimage.image = [UIImage imageNamed:@"xiangmubiaoshi"];
                
            maincell.projecttype.frame = CGRectMake(25, 40 + (self.view.bounds.size.width - 15)/2,self.view.bounds.size.width, 20);
            maincell.projecttype.font = [UIFont systemFontOfSize:13];
            maincell.projecttype.text = disc.ProName;
                
            maincell.doctorname.frame = CGRectMake(10, 58 + (self.view.bounds.size.width - 15)/2,self.view.bounds.size.width, 20);
            maincell.doctorname.font = [UIFont systemFontOfSize:13];
                maincell.doctorname.text = [NSString stringWithFormat:@"医生:%@",disc.DoctorName];
            maincell.doctorname.alpha = 0.85;
                
            maincell.hostadress.frame = CGRectMake(90, 58 + (self.view.bounds.size.width - 15)/2,self.view.bounds.size.width, 20);
            maincell.hostadress.font = [UIFont systemFontOfSize:13];
            maincell.hostadress.text = disc.HospitalName;
            maincell.hostadress.alpha = 0.85;
            
            maincell.contentexts.text = disc.Contents;
            maincell.contentexts.frame = CGRectMake(10, 75 + (self.view.bounds.size.width - 15)/2,self.view.bounds.size.width - 20, 40);
            maincell.contentexts.font = [UIFont systemFontOfSize:12];
            maincell.contentexts.numberOfLines = 0;
            maincell.contentexts.alpha = 0.60;
                
            maincell.Pinglunimage.frame = CGRectMake(self.view.bounds.size.width/2 + 40, 30 + (self.view.bounds.size.width - 15)/2 + 82, 12, 12);
            maincell.Pinglunimage.image = [UIImage imageNamed:@"pinglun"];
                
            maincell.Pingluncuonts.frame = CGRectMake(self.view.bounds.size.width/2 + 60, 28 + (self.view.bounds.size.width - 15)/2 + 80, 45, 20);
            maincell.Pingluncuonts.font = [UIFont systemFontOfSize:12];
            maincell.Pingluncuonts.textColor = [UIColor redColor];
            maincell.Pingluncuonts.text = disc.DiscussCount;
            maincell.Pingluncuonts.alpha = 0.5;
                
            maincell.Liulanimage.frame = CGRectMake(self.view.bounds.size.width/2 + 90, 32 + (self.view.bounds.size.width - 15)/2 + 80, 15, 17);
            maincell.Liulanimage.image = [UIImage imageNamed:@"liulan"];
              
            maincell.Liulancuonts.frame = CGRectMake(self.view.bounds.size.width/2 + 90 + 25, 28 + (self.view.bounds.size.width - 15)/2 + 80, 45, 20);
            maincell.Liulancuonts.font = [UIFont systemFontOfSize:12];
            maincell.Liulancuonts.textColor = [UIColor redColor];
            maincell.Liulancuonts.text = disc.ClickCount;
            maincell.Liulancuonts.alpha = 0.5;
                
            maincell.cheke.frame = CGRectMake(0, 0, 0, 0);
            maincell.cheke.image = [UIImage imageNamed:@""];
                
            maincell.chemore.frame = CGRectMake(0, 0, 0, 0);
            maincell.chemore.text = @"";
                
            }else{
                maincell.cheke.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
                maincell.cheke.image = [UIImage imageNamed:@"fenge"];
                
                maincell.chemore.frame = CGRectMake(self.view.bounds.size.width/2 - 34, 10, 70, 20);
                maincell.chemore.text = @"查看更多";
            }
        
        return maincell;
        
    }else{
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        discount *disct = [_citidate objectAtIndex:indexPath.row];
        cell.textLabel.text = disct.EnumName;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        NSLog(@"disct.EnumName:%@",disct.EnumName);
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 66) {
        if (indexPath.section == 0) {
            return self.view.bounds.size.width/2.133333;
        }else if (indexPath.section == 1){
            return ((self.view.bounds.size.width - 10)/4) * 2 + 4;
        }else if (indexPath.section == 2){
           return 30 + (self.view.bounds.size.width - 15)/2 + 100;
        }else{
            return 40;
        }
    }else{
        return 40;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag == 66) {
        
        if (indexPath.section == 3) {
            BeautyFootprint *bety = [[BeautyFootprint alloc] init];
            [self.navigationController pushViewController:bety animated:YES];
        }else{
            discount *disc = [_zujiarray objectAtIndex:indexPath.item];
            zujigerenzhongxinViewController *zuji = [[zujigerenzhongxinViewController alloc] init];
            zuji.customersno = disc.OwnSno;
            zuji.customername = disc.TrueName;
            [self.navigationController pushViewController:zuji animated:YES];
        }
        
    }else{
    
        discount *disct = [_citidate objectAtIndex:indexPath.row];
        [_locationbtn setTitle:disct.EnumName forState:UIControlStateNormal];
        [_citytableview removeFromSuperview];
        _citytableview = nil;
        
        [HuQiJingsharManage shareManage].changecity = disct;
        
        NSMutableDictionary* citydiction = [[NSMutableDictionary alloc] init];
        [citydiction setValue:disct.EnumName forKey:@"cityname"];
        [citydiction setValue:disct.EnumNo forKey:@"cityno"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:citydiction forKey:@"citydiction"];
        [defaults synchronize];
        
        [self soaprequstwithcity:disct.EnumName cityTypeNo:disct.EnumNo isgetcitydate:@"1"];
    }

}

#pragma mark  地理定位
-(void)starlocation
{
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }else{
        
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        // CLLocationDistance distance=0.01;//十米定位一次
        // _locationManager.distanceFilter=distance;
        
        [_locationManager requestAlwaysAuthorization];
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
        
    }
   
    //    //如果没有授权则请求用户授权
    //    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
    //        [_locationManager requestWhenInUseAuthorization];
    //    }
    //    else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse)
    //    {
    //        //设置代理
    //        _locationManager.delegate=self;
    //        //设置定位精度
    //        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //        //定位频率,每隔多少米定位一次
    //        // CLLocationDistance distance=0.01;//十米定位一次
    //        // _locationManager.distanceFilter=distance;
    //
    //        [_locationManager requestAlwaysAuthorization];
    //        //启动跟踪定位
    //        [_locationManager startUpdatingLocation];
    //        NSLog(@"开始定位！");
    //    }
   
    self.islocation = YES;
}


#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location=[locations lastObject];//取出最后一个位置
    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
    

    NSLog(@"-经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    
    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
    
    //地理编码
    _geocoder=[[CLGeocoder alloc]init];
   // [self getCoordinateByAddress:@"深圳"];
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];

}
//处理定位成功
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    CLLocation *curLocation = [locations lastObject];
//
//    if(curLocation.horizontalAccuracy >= 0)
//    {
//        self.recentLocation = curLocation;
//
//        CLLocation *destLocation = [[CLLocation alloc] initWithLatitude:kDestLatitude longitude:kDestLongitude];
//
//        CLLocationDistance distance = [destLocation distanceFromLocation:curLocation];
//
//        if(distance<500)
//        {
//            [self.locationManager stopUpdatingLocation];
//            [self.locationManager stopUpdatingHeading];
//            self.lblMessage.text = @"您已经到达目的地!";
//        }
//        else
//        {
//            self.lblMessage.text = [NSString stringWithFormat:@"距离目的地还有%f米",distance];
//        }
//    }
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark 根据地名确定地理坐标
-(void)getCoordinateByAddress:(NSString *)address{
    //地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
       // CLPlacemark *placemark=[placemarks firstObject];
        
//        CLLocation *location=placemark.location;//位置
//        CLRegion *region=placemark.region;//区域
//        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
        //                NSString *name=placemark.name;//地名
        //                NSString *thoroughfare=placemark.thoroughfare;//街道
        //                NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        //                NSString *locality=placemark.locality; // 城市
        //                NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        //                NSString *administrativeArea=placemark.administrativeArea; // 州
        //                NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        //                NSString *postalCode=placemark.postalCode; //邮编
        //                NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        //                NSString *country=placemark.country; //国家
        //                NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        //                NSString *ocean=placemark.ocean; // 海洋
        //                NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
       // NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
    }];
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        
        NSString *citi = [placemark.addressDictionary objectForKey:@"City"];
        [_locationbtn setTitle:citi forState:UIControlStateNormal];
        
        _locationcityN = [[NSArray alloc] initWithObjects:citi, nil];
    
        if (self.islocation == YES) {
            [self soaprequstwithCiTyNo:citi];
            self.islocation = NO;
             self.isjudge = NO;
        }

}];}


@end
