//
//  YouHuiViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "YouHuiViewController.h"
#import "TopBarView.h"
#import "TableViewCell.h"
#import "youhuihuodong.h"
#import "UIImageView+WebCache.h"
#import "MakeAppointment.h"
#import "youhuiwebViewController.h"
#import "ShareSDK/ShareSDK.h"
#import "PrefixHeader.pch"
@interface YouHuiViewController ()

@end

@implementation YouHuiViewController

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
    titilelable.text = @"优惠活动";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    

    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(gotobackbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    UIButton *fenxiang = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 50, 25, 40, 40)];
    [fenxiang setBackgroundImage:[UIImage imageNamed:@"fx"] forState:UIControlStateNormal];
    [fenxiang addTarget:self action:@selector(gotofenxiangclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:fenxiang];
    
    _youhuihuodong = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _youhuihuodong.delegate = self;
    _youhuihuodong.dataSource  = self;
    _youhuihuodong.rowHeight = 200;
    [self.view addSubview:_youhuihuodong];
    
    
    _refreshControl=[[RefreshControl alloc] initWithScrollView:_youhuihuodong delegate:self];
    _refreshControl.topEnabled=YES;
    //_refreshControl.bottomEnabled=YES;//会崩
    
    
    [self soaprequestwithstrPageindex:@"1" strPagesize:@"40"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"qianggou" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    
    if (direction==RefreshDirectionTop)
    {
        NSLog(@"下拉刷新");
        [self soaprequestwithstrPageindex:@"1" strPagesize:@"40"];
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

-(void)tongzhi:(NSNotification *)noti
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *isdoctor = [user objectForKey:@"CommomUserORCommomDoctor"];
    if ([isdoctor isEqualToString:@"CommomDoctor"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"医生不能抢购项目！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }else{
        
        youhuihuodong *youhui = [_beautifyProductSaleDataarray objectAtIndex:[[noti object] integerValue]];
        
        if ([youhui.IsCanUse integerValue] == 1) {
            MakeAppointment *make = [[MakeAppointment alloc] init];
            make.saleSno = youhui.Sno;
            make.hostitalname = youhui.HospitalName;
            make.date = youhui.BookDt;
            make.doctornames = youhui.DoctorName;
            [self.navigationController pushViewController:make animated:YES];
        }
    
    }


}


-(void)gotofenxiangclick
{

    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"AppIcon120x120" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享优惠活动！ "
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"聚美医"
                                                  url:HTTPREQUESTPDOMAIN@"/Front/Share/SharpPage.aspx?source=qj"
                                          description:@"这是一条分享信息"
                                            mediaType:SSPublishContentMediaTypeNews];//
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //[container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)gotobackbuttonclick
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark---uitableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _beautifyProductSaleDataarray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    youhuihuodong *yh = [_beautifyProductSaleDataarray objectAtIndex:indexPath.row];
    
    [cell.headimage sd_setImageWithURL:[NSURL URLWithString:yh.BeautifyProPic]];
    cell.productornametext.text = yh.BeautifyProName;
    cell.fuwushijiantext.text = yh.BookDt;
    cell.doctortext.text = yh.DoctorName;
    cell.Hospitaltext.text = yh.HospitalName;
    cell.shichangjia.text = [NSString stringWithFormat:@"市场价:%@元",yh.MarketPrice];
    cell.youhuijia.text = [NSString stringWithFormat:@"优惠价:%@元",yh.Price];
    
    if ([yh.IsCanUse isEqualToString:@"0"]) {
        [cell.qianggou setBackgroundImage:[UIImage imageNamed:@"yiqiangguang"] forState:UIControlStateNormal];
        cell.jiaoyizhuangtai.text = @"活动已结束";
        cell.jiaoyizhuangtai.textColor = [UIColor grayColor];
        cell.jiaoyizhuangtai.center = CGPointMake(self.view.bounds.size.width/2, 122);
        
    }else {
    cell.jiaoyizhuangtai.text = @"正在进行中";
        cell.jiaoyizhuangtai.textColor = [UIColor redColor];
        [cell.qianggou setBackgroundImage:[UIImage imageNamed:@"qiangding"] forState:UIControlStateNormal];
        cell.jiaoyizhuangtai.center = CGPointMake(self.view.bounds.size.width/2 , 122);
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    youhuihuodong *yh = [_beautifyProductSaleDataarray objectAtIndex:indexPath.row];
    youhuiwebViewController *youhui = [[youhuiwebViewController alloc] init];
    youhui.urlsno = yh.Sno;
    youhui.selectorindex = indexPath.row;
    youhui.beautifyProductSaleDataarray = _beautifyProductSaleDataarray;
    [self.navigationController pushViewController:youhui animated:YES];
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

#pragma mark---- SOAP请求
//获取美容项目抢购数据
-(void)soaprequestwithstrPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetBeautifyProductSaleData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetBeautifyProductSaleData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,strPageindex,strPagesize];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetBeautifyProductSaleData" forHTTPHeaderField:@"SOAPAction"];
    
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
    
    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSLog(@"写美容日记--%@",theXML);
    
    
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
    
    if ([elementName isEqualToString:@"GetBeautifyProductSaleDataResult"]) {
        
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
    if ([elementName isEqualToString:@"GetBeautifyProductSaleDataResult"]) {//获取本页信息
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"优惠活动请求回来的数据:%@",dic);
        NSMutableArray *beautifyProductSaleData = [dic objectForKey:@"beautifyProductSaleData"];
        _beautifyProductSaleDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *youhuidiction in beautifyProductSaleData) {
            youhuihuodong *yh = [youhuihuodong youhuiWithdiction:youhuidiction];
            [_beautifyProductSaleDataarray addObject:yh];
        }
        [_youhuihuodong reloadData];
        
//        NSString *str = [dic objectForKey:@"msg"];
//        NSString *state = [dic objectForKey:@"state"];
//        NSLog(@"msg:%@",str);
//        if ([state isEqualToString:@"1"]) {
//            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"操作提示" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [aler show];
//        }
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
