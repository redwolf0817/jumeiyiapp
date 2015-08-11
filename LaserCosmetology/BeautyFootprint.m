//
//  BeautyFootprint.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/6.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "BeautyFootprint.h"
#import "TopBarView.h"
#import "customerBeautifyLogData.h"
#import "UIImageView+WebCache.h"
#import "BeautyFootprintclvLayout.h"
#import "zujigerenzhongxinViewController.h"
#import "BeautyFootTableViewCell.h"
#import "UIButton+WebCache.h"
#import "PrefixHeader.pch"
static NSString * const identifier = @"cell";

@interface BeautyFootprint ()

@property (nonatomic,strong)RefreshControl * refreshControl;

@end

@implementation BeautyFootprint

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
    titilelable.text = @"美容足迹";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];

    
    _btftableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _btftableview.dataSource = self;
    _btftableview.delegate = self;
    _btftableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_btftableview];

     _refreshControl=[[RefreshControl alloc] initWithScrollView:_btftableview delegate:self];
    _refreshControl.topEnabled=YES;
    //_refreshControl.bottomEnabled=YES;//会崩
    
    _customerBeautifyLogDataarray = [[NSMutableArray alloc] initWithCapacity:0];
    _contentshightarray = [[NSMutableArray alloc] initWithCapacity:0];
    self.a = 1;
    
    [self soaprequestwithstrPageindex:@"1" strPagesize:@"40"];
    
}

- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    if (direction==RefreshDirectionTop)
    {
        self.isdown = YES;
        NSLog(@"下拉刷新  ----");
        self.a = 1;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    // 假设偏移表格高度的20%进行刷新
    
    if (!_isLoading) { // 判断是否处于刷新状态，刷新中就不执行
        // 取内容的高度：
        //    如果内容高度大于UITableView高度，就取TableView高度
        //    如果内容高度小于UITableView高度，就取内容的实际高度
        float height = scrollView.contentSize.height > _btftableview.frame.size.height ?_btftableview.frame.size.height : scrollView.contentSize.height;
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
            // 调用上拉刷新方法
            NSLog(@"到底了");
            _isLoading = YES;
            self.a++;
          _timer1 = [NSTimer scheduledTimerWithTimeInterval:2.50 target:self selector:@selector(shuaxins) userInfo:nil repeats:NO];
             [self soaprequestwithstrPageindex:[NSString stringWithFormat:@"%ld",self.a] strPagesize:@"40"];
            NSLog(@"a的值：%ld",self.a);
        }
        if (- scrollView.contentOffset.y / _btftableview.frame.size.height > 0.2) {
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

-(void)backbuttonclick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
  
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = CGSizeMake(self.view.bounds.size.width/2 - 25,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;

    return gaodu;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(void)creatcollerctionview
//{
//}


//字体行间距
-(CGSize)jianjucontentLabel:(UILabel *)contentLabel
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:contentLabel.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentLabel.text.length)];
    contentLabel.attributedText = attributedString;
    
    //调节高度
    
    CGSize size = CGSizeMake(self.view.bounds.size.width - 20, 500000);
    CGSize labelSize = [contentLabel sizeThatFits:size];
    
    return labelSize;
}
#pragma mark---tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _customerBeautifyLogDataarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"tableviewcell";
    BeautyFootTableViewCell *tableviewcell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!tableviewcell) {
        tableviewcell = [[BeautyFootTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    customerBeautifyLogData *customer = [_customerBeautifyLogDataarray objectAtIndex:indexPath.item];

    tableviewcell.hengimage.frame = CGRectMake(0, 0, 0, 0);
    tableviewcell.hengimage.image = [UIImage imageNamed:@""];
    
    tableviewcell.Locationimage.frame = CGRectMake(0, 0, 0, 0);
    tableviewcell.Locationimage.image = [UIImage imageNamed:@""];
    
    tableviewcell.LocationStr.frame = CGRectMake(0, 0, 0, 0);
    tableviewcell.LocationStr.text =@"";
    
    [tableviewcell.PersonerimageStr1 sd_setImageWithURL:[NSURL URLWithString:@""]];
    tableviewcell.PersonerimageStr1.frame = CGRectMake(0, 0, 0, 0);
    
    [tableviewcell.PersonerimageStr2 sd_setImageWithURL:[NSURL URLWithString:@""]];
    tableviewcell.PersonerimageStr2.frame = CGRectMake(0, 0, 0, 0);
    
    
    tableviewcell.projectimage.frame = CGRectMake(0, 0, 0, 0);
    tableviewcell.projectimage.image = [UIImage imageNamed:@""];
    
    tableviewcell.doctorname.frame = CGRectMake(0, 0,0, 0);
    tableviewcell.doctorname.text = @"";
    
    tableviewcell.hostadress.frame = CGRectMake(0, 0,0, 0);
    tableviewcell.hostadress.text = @"";
    
    tableviewcell.PersonernameStr.frame = CGRectMake(0, 0, 0, 0);
    tableviewcell.PersonernameStr.text = @"";
    
    tableviewcell.projecttype.frame = CGRectMake(0, 0,0, 0);
    tableviewcell.projecttype.text = @"";
    
    tableviewcell.contentexts.text = @"";
    tableviewcell.contentexts.frame = CGRectMake(0,  0,  0, 0);
    
    [tableviewcell.PersonerheadimageUrl sd_setImageWithURL:[NSURL URLWithString:@""]];
    tableviewcell.PersonerheadimageUrl.frame = CGRectMake(0, 0, 0, 0);
    
    tableviewcell.Pinglunimage.frame = CGRectMake(0, 0 , 0, 0);
    tableviewcell.Pinglunimage.image = [UIImage imageNamed:@""];
    
    tableviewcell.Pingluncuonts.frame = CGRectMake(0, 0 , 0, 0);
    tableviewcell.Pingluncuonts.text = @"";
    
    tableviewcell.Liulanimage.frame = CGRectMake(0, 0, 0, 0);
    tableviewcell.Liulanimage.image = [UIImage imageNamed:@""];
    
    tableviewcell.Liulancuonts.frame = CGRectMake(0, 0, 0, 0);
    tableviewcell.Liulancuonts.text = @"";
    

        tableviewcell.hengimage.frame = CGRectMake(0, 0, self.view.bounds.size.width, 5);
        tableviewcell.hengimage.image = [UIImage imageNamed:@"fenge"];
    
        [tableviewcell.PersonerheadimageUrl sd_setImageWithURL:[NSURL URLWithString:customer.CusPicSrc]];
        tableviewcell.PersonerheadimageUrl.frame = CGRectMake(10, 7, 25, 25);
        tableviewcell.PersonerheadimageUrl.layer.masksToBounds = YES;
        tableviewcell.PersonerheadimageUrl.layer.cornerRadius = 12.5;
        
        tableviewcell.PersonernameStr.frame = CGRectMake(45, 11, 80, 20);
        tableviewcell.PersonernameStr.text = customer.CustomerName;
        tableviewcell.PersonernameStr.font = [UIFont systemFontOfSize:13];
        tableviewcell.PersonernameStr.alpha = 1.75;
        
        tableviewcell.Locationimage.frame = CGRectMake(self.view.bounds.size.width - 65, 12, 16, 16);
        tableviewcell.Locationimage.image = [UIImage imageNamed:@"chengshi"];
        
        tableviewcell.LocationStr.frame = CGRectMake(self.view.bounds.size.width - 50, 10, 60, 20);
        if (customer.CityName.length < 1) {
            tableviewcell.LocationStr.text =@"城市";
        }else{
            tableviewcell.LocationStr.text = customer.CityName;
        }
        tableviewcell.LocationStr.font = [UIFont systemFontOfSize:12];
        tableviewcell.LocationStr.alpha = 0.60;
    
    if (customer.PicSrc2.length > 5) {
        [tableviewcell.PersonerimageStr1 sd_setImageWithURL:[NSURL URLWithString:customer.PicSrc2]];
        tableviewcell.PersonerimageStr1.frame = CGRectMake(5, 40, (self.view.bounds.size.width - 15)/2, (self.view.bounds.size.width - 15)/2);
        
        [tableviewcell.PersonerimageStr2 sd_setImageWithURL:[NSURL URLWithString:customer.PicSrc]];
        tableviewcell.PersonerimageStr2.frame = CGRectMake((self.view.bounds.size.width - 15)/2 + 10, 40, (self.view.bounds.size.width - 15)/2, (self.view.bounds.size.width - 15)/2);
    }else{
        [tableviewcell.PersonerimageStr1 sd_setImageWithURL:[NSURL URLWithString:customer.PicSrc]];
        tableviewcell.PersonerimageStr1.frame = CGRectMake(5, 40, (self.view.bounds.size.width - 15)/2, (self.view.bounds.size.width - 15)/2);
        
    }

    
    
        tableviewcell.projectimage.frame = CGRectMake(10, 44 + (self.view.bounds.size.width - 15)/2, 9, 12);
        tableviewcell.projectimage.image = [UIImage imageNamed:@"xiangmubiaoshi"];
        
        tableviewcell.projecttype.frame = CGRectMake(25, 40 + (self.view.bounds.size.width - 15)/2,self.view.bounds.size.width, 20);
        tableviewcell.projecttype.font = [UIFont systemFontOfSize:13];
        tableviewcell.projecttype.text = customer.ProName;
        
        tableviewcell.doctorname.frame = CGRectMake(10, 58 + (self.view.bounds.size.width - 15)/2,self.view.bounds.size.width, 20);
        tableviewcell.doctorname.font = [UIFont systemFontOfSize:13];
        tableviewcell.doctorname.text = [NSString stringWithFormat:@"医生:%@",customer.DoctorName];
        tableviewcell.doctorname.alpha = 0.85;
        
        tableviewcell.hostadress.frame = CGRectMake(90, 58 + (self.view.bounds.size.width - 15)/2,self.view.bounds.size.width, 20);
        tableviewcell.hostadress.font = [UIFont systemFontOfSize:13];
        tableviewcell.hostadress.text = customer.HospitalName;
        tableviewcell.hostadress.alpha = 0.85;
        
        tableviewcell.contentexts.text = customer.Contents;
        tableviewcell.contentexts.frame = CGRectMake(10, 75 + (self.view.bounds.size.width - 15)/2,self.view.bounds.size.width - 20, 40);
        tableviewcell.contentexts.font = [UIFont systemFontOfSize:12];
        tableviewcell.contentexts.numberOfLines = 0;
        tableviewcell.contentexts.alpha = 0.60;
        
        tableviewcell.Pinglunimage.frame = CGRectMake(self.view.bounds.size.width/2 + 40, 30 + (self.view.bounds.size.width - 15)/2 + 82, 12, 12);
        tableviewcell.Pinglunimage.image = [UIImage imageNamed:@"pinglun"];
        
        tableviewcell.Pingluncuonts.frame = CGRectMake(self.view.bounds.size.width/2 + 60, 28 + (self.view.bounds.size.width - 15)/2 + 80, 45, 20);
        tableviewcell.Pingluncuonts.font = [UIFont systemFontOfSize:12];
        tableviewcell.Pingluncuonts.textColor = [UIColor redColor];
        tableviewcell.Pingluncuonts.text = customer.DiscussCount;
        tableviewcell.Pingluncuonts.alpha = 0.5;
        
        tableviewcell.Liulanimage.frame = CGRectMake(self.view.bounds.size.width/2 + 90, 32 + (self.view.bounds.size.width - 15)/2 + 80, 15, 17);
        tableviewcell.Liulanimage.image = [UIImage imageNamed:@"liulan"];
        
        tableviewcell.Liulancuonts.frame = CGRectMake(self.view.bounds.size.width/2 + 90 + 25, 28 + (self.view.bounds.size.width - 15)/2 + 80, 45, 20);
        tableviewcell.Liulancuonts.font = [UIFont systemFontOfSize:12];
        tableviewcell.Liulancuonts.textColor = [UIColor redColor];
        tableviewcell.Liulancuonts.text = customer.ClickCount;
        tableviewcell.Liulancuonts.alpha = 0.5;
        
        
    return tableviewcell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 30 + (self.view.bounds.size.width - 15)/2 + 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    customerBeautifyLogData *customer = [_customerBeautifyLogDataarray objectAtIndex:indexPath.item];
    
    zujigerenzhongxinViewController *gerenzhongxin = [[zujigerenzhongxinViewController alloc] init];
    gerenzhongxin.customersno = customer.OwnSno;
    gerenzhongxin.customername = customer.CustomerName;
    [self.navigationController pushViewController:gerenzhongxin animated:YES];
}

//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect images:(UIImage *)imag
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imag.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}
//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size image:(UIImage *)imags
{
    CGFloat width = CGImageGetWidth(imags.CGImage);
    CGFloat height = CGImageGetHeight(imags.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
//    if(verticalRadio &gt;1 &amp;&amp; horizontalRadio &gt;1)
//    {
//        radio = verticalRadio &gt; horizontalRadio ? horizontalRadio : verticalRadio;
//    }
//    else
//    {
//        radio = verticalRadio &lt; horizontalRadio ? verticalRadio : horizontalRadio;
//    }
    

    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [imags drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

#pragma mark---- SOAP请求
//获取美容足迹
-(void)soaprequestwithstrPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetAllCustomerBeautifyLogData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetAllCustomerBeautifyLogData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,strPageindex,strPagesize];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetAllCustomerBeautifyLogData" forHTTPHeaderField:@"SOAPAction"];
    
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
    // NSLog(@"ERROR with theConenction");[error description]
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
//    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
//    NSLog(@"美容足迹--%@",theXML);
    
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
    if ([elementName isEqualToString:@"GetAllCustomerBeautifyLogDataResult"]) {
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
    if ([elementName isEqualToString:@"GetAllCustomerBeautifyLogDataResult"]) {//获取本页信息
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"美容足迹的数据:%@",dic);
        
        NSString *str = [dic objectForKey:@"msg"];
        NSString *state = [dic objectForKey:@"state"];
        
        if (self.isdown == YES) {
            if (_customerBeautifyLogDataarray.count > 0) {
                [_customerBeautifyLogDataarray removeAllObjects];
                [_contentshightarray removeAllObjects];
            }
            
            self.isdown = NO;
        }
        
        NSMutableArray *logdata = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *hightary = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSMutableArray *customerBeautifyLogDatas = [dic objectForKey:@"customerBeautifyLogData"];
        for (NSDictionary *diction in customerBeautifyLogDatas) {
            customerBeautifyLogData *customerlog = [customerBeautifyLogData customerBeautifyLogDataWithDiction:diction];
            [logdata addObject:customerlog];
            NSString *strhight = [NSString stringWithFormat:@"%f",[self contentsWithnsstring:customerlog.Contents] + 20];
            [hightary addObject:strhight];
        }
        
        if (logdata.count > 0) {
            for (customerBeautifyLogData *cus in logdata) {
                [_customerBeautifyLogDataarray addObject:cus];
            }
            for (NSString *hig in hightary) {
                [_contentshightarray addObject:hig];
            }
            
             [_btftableview reloadData];
        }
        
       
        
        if ([state isEqualToString:@"0"]) {
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"操作提示" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
            
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
