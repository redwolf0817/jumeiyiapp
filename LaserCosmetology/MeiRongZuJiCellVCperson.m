//
//  MeiRongZuJiCellVCperson.m
//  聚美医
//
//  Created by fenghuang on 15/7/17.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "MeiRongZuJiCellVCperson.h"
#import "TopBarView.h"
#import "gerenzujiViewLayout.h"
#import "gerenzujiCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "customerBeautifyLogData.h"
#import "discuse.h"
#import "PrefixHeader.pch"
static NSString * const identifier = @"cell";

@interface MeiRongZuJiCellVCperson ()

@end

@implementation MeiRongZuJiCellVCperson

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 160, 25)];
    titilelable.text = @"足迹详情";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(meirongzujibackbuttonclick11) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagebuttonclickw:) name:@"imagebuttonclick" object:nil];
    
    [self soaprequestwithSno:self.sno];
}

-(void)meirongzujibackbuttonclick11
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)imagebuttonclickw:(NSNotification *)notifier
{
    // NSInteger str = [[notifier object] integerValue];
    
    NSArray *str1 = [[notifier object] componentsSeparatedByString:@"/"];
    NSString *indexpathrow = [str1 objectAtIndex:0];
    NSString *indexpathpistr = [str1 objectAtIndex:1];
    
    customerBeautifyLogData *customer = [_logDataarray objectAtIndex:[indexpathrow integerValue]];
    NSMutableArray *picstrarray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *dicary = customer.LogPicData;
    if (customer.PicSrc2.length > 5) {
        
        for (NSDictionary  *diction1 in dicary) {
            NSString *imagestr =[diction1 objectForKey:@"PicSrc"];
            if (imagestr.length > 5) {
                [picstrarray addObject:[diction1 objectForKey:@"PicSrc"]];
            }
        }
        [picstrarray insertObject:customer.PicSrc atIndex:0];
        
    }else{
        
        for (NSDictionary  *diction1 in dicary) {
            NSString *imagestr =[diction1 objectForKey:@"PicSrc"];
            if (imagestr.length > 5) {
                [picstrarray addObject:[diction1 objectForKey:@"PicSrc"]];
            }
        }
    }
    
    NSString *imageurlstr;
    if (customer.PicSrc2.length > 5) {
        imageurlstr = customer.PicSrc2;
    }else{
        imageurlstr = customer.PicSrc;
    }
    
    if (_imagebackview == nil) {
        _imagebackview = [[UIView alloc] initWithFrame:self.view.bounds];
        _imagebackview.backgroundColor = [UIColor blackColor];
        _imagebackview.alpha = 0.9;
        [self.view addSubview:_imagebackview];
    }
    
    if (_imagetunningview == nil) {
        _imagetunningview = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width , self.view.bounds.size.height)];
        _imagetunningview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_imagetunningview];
    }
    
    UIScrollView *imagescrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 100)];
    imagescrollview.contentSize = CGSizeMake((picstrarray.count + 1) * self.view.bounds.size.width, 0);
    imagescrollview.contentOffset = CGPointMake(self.view.bounds.size.width * ([indexpathpistr integerValue] - 10), 0);
    imagescrollview.pagingEnabled = YES;
    imagescrollview.backgroundColor = [UIColor clearColor];
    [_imagetunningview addSubview:imagescrollview];
    
    UIView *blackview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (picstrarray.count + 1) * self.view.bounds.size.width, self.view.bounds.size.height - 100)];
    blackview.backgroundColor = [UIColor blackColor];
    [imagescrollview addSubview:blackview];
    
    UIImageView *scrollimagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    [scrollimagev sd_setImageWithURL:[NSURL URLWithString:imageurlstr] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        scrollimagev.frame = CGRectMake(0, 0, self.view.bounds.size.width, scrollimagev.image.size.height/(scrollimagev.image.size.width/self.view.bounds.size.width));
    }];
    [imagescrollview addSubview:scrollimagev];
    
    
    for (int i = 0; i < picstrarray.count; i++) {
        
        UIImageView *scrollimagev2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i + self.view.bounds.size.width, 0,self.view.bounds.size.width,100)];
        [scrollimagev2 sd_setImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            scrollimagev2.frame = CGRectMake(self.view.bounds.size.width * i + self.view.bounds.size.width, 0, self.view.bounds.size.width, scrollimagev2.image.size.height/(scrollimagev2.image.size.width/self.view.bounds.size.width));
        }];
        scrollimagev2.userInteractionEnabled = YES;
        [imagescrollview addSubview:scrollimagev2];
        
        
        UIButton *scrollimagev = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i + self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
        scrollimagev.backgroundColor = [UIColor clearColor];
        [scrollimagev addTarget:self action:@selector(imageoffbuttunclick:) forControlEvents:UIControlEventTouchUpInside];
        [imagescrollview addSubview:scrollimagev];
    }
    
    
    //    //关闭按钮
    UIButton *off = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    [off addTarget:self action:@selector(imageoffbuttunclick:) forControlEvents:UIControlEventTouchUpInside];
    [imagescrollview addSubview:off];
    
}
-(void)imageoffbuttunclick:(UIButton *)btn
{
    
    NSLog(@"关闭");
    [_imagebackview removeFromSuperview];
    _imagebackview = nil;
    [_imagetunningview removeFromSuperview];
    _imagetunningview = nil;
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
-(CGFloat)contentsWithnsstringcell:(NSString *)str
{
    
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 25,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    
    return gaodu;
}
//评论的字号
-(CGFloat)contentsWithPinglunnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 100,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}
#pragma mark-------UICOllerctionView
-(void)creatcollerctionview
{
    
    gerenzujiViewLayout *layout;
    if (!layout) {
        layout = [[gerenzujiViewLayout alloc]init];
    }
    layout.hightarray = _contentshightarray;//给它一个高度数组
    
    
    if (!_clView) {
        _clView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64, self.view.bounds.size.width, self.view.bounds.size.height - 64)collectionViewLayout:layout];
    }
    _clView.backgroundColor = [UIColor clearColor];
    [_clView registerClass:[gerenzujiCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    _clView.dataSource = self;
    _clView.delegate   = self;
    _clView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_clView];
    
}

#pragma mark dateScore
//告诉有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//告诉有多少个小方块
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _logDataarray.count;
}
//告诉系统每个小方块展示什么内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    customerBeautifyLogData *customer = [_logDataarray objectAtIndex:indexPath.row];
    //1 从环城池中去cell
    gerenzujiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    NSMutableArray *picstrarray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *dicary = customer.LogPicData;
    for (NSDictionary  *diction1 in dicary) {
        NSString *imagestr =[diction1 objectForKey:@"PicSrc"];
        if (imagestr.length > 5) {
            [picstrarray addObject:[diction1 objectForKey:@"PicSrc"]];
        }
    }
    cell.picarray = picstrarray;
    
    [cell.imageurl1 sd_setImageWithURL:[NSURL URLWithString:@""]];
    [cell.imageurl2 sd_setImageWithURL:[NSURL URLWithString:@""]];
    [cell.imageurl3 sd_setImageWithURL:[NSURL URLWithString:@""]];
    [cell.imageurl4 sd_setImageWithURL:[NSURL URLWithString:@""]];
    [cell.imageurl5 sd_setImageWithURL:[NSURL URLWithString:@""]];
    [cell.imageurlpistr sd_setImageWithURL:[NSURL URLWithString:@""]];
    [cell.imageurlpistr2 sd_setImageWithURL:[NSURL URLWithString:@""]];
    cell.imagebtn1.userInteractionEnabled = NO;
    cell.imagebtn2.userInteractionEnabled = NO;
    cell.imagebtn3.userInteractionEnabled = NO;
    cell.imagebtn4.userInteractionEnabled = NO;
    cell.imagebtn5.userInteractionEnabled = NO;
    cell.imagebtn6.userInteractionEnabled = NO;
    
    float imageX = (self.view.bounds.size.width - 8)/3;
    //float imageY = ((self.view.bounds.size.width - 8)/3)/0.75;
    
    if (customer.PicSrc2.length < 5) {
        
        for (int i = 0; i < picstrarray.count; i++) {
            if (i == 0) {
                [cell.imageurl1 sd_setImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:0]]];
                cell.imageurl1.frame = CGRectMake(imageX + 4, 25, imageX, imageX);
                cell.imagebtn2.frame = CGRectMake(imageX + 4, 25, imageX, imageX);
                cell.imagebtn2.userInteractionEnabled = YES;
            }else if (i == 1){
                [cell.imageurl2 sd_setImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:1]]];
                cell.imageurl2.frame = CGRectMake(imageX * 2 + 6, 25, imageX, imageX);
                cell.imagebtn3.frame = CGRectMake(imageX * 2 + 6, 25, imageX, imageX);
                cell.imagebtn3.userInteractionEnabled = YES;
            }else if (i == 2){
                [cell.imageurl3 sd_setImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:2]]];
                cell.imageurl3.frame = CGRectMake(2 , 25+ imageX + 2, imageX, imageX);
                cell.imagebtn4.frame = CGRectMake(2 , 25+ imageX + 2, imageX, imageX);
                cell.imagebtn4.userInteractionEnabled = YES;
            }else if (i == 3){
                [cell.imageurl4 sd_setImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:3]]];
                cell.imageurl4.frame = CGRectMake(imageX + 4, 25+ imageX + 2, imageX, imageX);
                cell.imagebtn5.frame = CGRectMake(imageX + 4, 25+ imageX + 2, imageX, imageX);
                cell.imagebtn5.userInteractionEnabled = YES;
            }else {
                [cell.imageurl5 sd_setImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:4]]];
                cell.imageurl5.frame = CGRectMake(imageX * 2 + 6, 25+ imageX + 2, imageX, imageX);
                cell.imagebtn6.frame = CGRectMake(imageX * 2 + 6, 25+ imageX + 2, imageX, imageX);
                cell.imagebtn6.userInteractionEnabled = YES;
            }
        }
    }else{
        
        for (int i = 0; i < picstrarray.count; i++) {
            if (i == 0) {
                [cell.imageurl2 sd_setImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:0]]];
                cell.imageurl2.frame = CGRectMake(imageX * 2 + 6, 25, imageX, imageX);
                cell.imagebtn3.frame = CGRectMake(imageX * 2 + 6, 25, imageX, imageX);
                cell.imagebtn3.userInteractionEnabled = YES;
            }else if (i == 1){
                [cell.imageurl3 sd_setImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:1]]];
                cell.imageurl3.frame = CGRectMake(2 , 25+ imageX + 2, imageX, imageX);
                cell.imagebtn4.frame = CGRectMake(2 , 25+ imageX + 2, imageX, imageX);
                cell.imagebtn4.userInteractionEnabled = YES;
            }else if (i == 2){
                [cell.imageurl4 sd_setImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:2]]];
                cell.imageurl4.frame = CGRectMake(imageX + 4, 25+ imageX + 2, imageX, imageX);
                cell.imagebtn5.frame = CGRectMake(imageX + 4, 25+ imageX + 2, imageX, imageX);
                cell.imagebtn5.userInteractionEnabled = YES;
            }else {
                [cell.imageurl5 sd_setImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:3]]];
                cell.imageurl5.frame = CGRectMake(imageX * 2 + 6, 25+ imageX + 2, imageX, imageX);
                cell.imagebtn6.frame = CGRectMake(imageX * 2 + 6, 25+ imageX + 2, imageX, imageX);
                cell.imagebtn6.userInteractionEnabled = YES;
            }
        }
    }
    
    cell.fengexian.image = [UIImage imageNamed:@"fenge"];
    NSInteger  c = picstrarray.count / 3;
    if (customer.PicSrc2.length > 5) {
        c = (picstrarray.count + 1) / 3;
    }
    if (c >= 2) {
        c = 1;
    }
    float hight = (c + 1) * imageX;
    
    cell.CreateDt.text = customer.CreateDt;
    cell.CreateDt.frame = CGRectMake(5,4,[self NSStringwithsize:14 str:customer.CreateDt],20);
    
    if (customer.PicSrc2.length > 5) {
        [cell.imageurlpistr sd_setImageWithURL:[NSURL URLWithString:customer.PicSrc2]];
        cell.imageurlpistr.frame = CGRectMake(2, 25, imageX, imageX);
        cell.imagebtn1.frame = CGRectMake(2, 25, imageX, imageX);
        cell.imagebtn1.userInteractionEnabled = YES;
        
        [cell.imageurlpistr2 sd_setImageWithURL:[NSURL URLWithString:customer.PicSrc]];
        cell.imageurlpistr2.frame = CGRectMake(imageX + 4, 25, imageX, imageX);
        cell.imagebtn2.frame = CGRectMake(imageX + 4, 25, imageX, imageX);
        cell.imagebtn2.userInteractionEnabled = YES;
    }else{
        
        [cell.imageurlpistr sd_setImageWithURL:[NSURL URLWithString:customer.PicSrc]];
        cell.imageurlpistr.frame = CGRectMake(2, 25, imageX, imageX);
        cell.imagebtn1.frame = CGRectMake(2, 25, imageX, imageX);
        cell.imagebtn1.userInteractionEnabled = YES;
    }
    
    
    cell.projectimage.frame = CGRectMake(5, hight + 30, 10, 14);
    cell.projectimage.image = [UIImage imageNamed:@"xiangmubiaoshi"];
    
    cell.projecttype.frame = CGRectMake(17, hight + 28,[self NSStringwithsize:14 str:customer.ProName],18);
    cell.projecttype.font = [UIFont systemFontOfSize:12];
    cell.projecttype.text = customer.ProName;
    
    cell.doctorname.text = [NSString stringWithFormat:@"医生:%@",customer.DoctorName];
    cell.doctorname.frame = CGRectMake(5, hight + 45, cell.bounds.size.width - 10, 20);
    
    cell.hospitol.frame = CGRectMake(100, hight + 45, [self NSStringwithsize:14 str:customer.HospitalName],20);
    cell.hospitol.text = customer.HospitalName;
    cell.hospitol.font = [UIFont systemFontOfSize:13];
    
    cell.Contents.text = customer.Contents;
    cell.Contents.alpha = 0.75;
    cell.Contents.font = [UIFont systemFontOfSize:14];
    cell.Contents.frame = CGRectMake(10, hight + 38 + 30,cell.bounds.size.width - 20 ,[self contentsWithnsstringcell:customer.Contents]);
    
    cell.pinglun.frame = CGRectMake(25, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 8, 20, 15);
    
    cell.DiscussCount.text = customer.DiscussCount;
    cell.DiscussCount.frame = CGRectMake(40 + 10, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 5, 100, 20);
    
    cell.liulan.frame = CGRectMake(135, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 8, 22, 20);
    
    cell.ClickCount.text = customer.ClickCount;
    cell.ClickCount.frame = CGRectMake(160, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 5, 100, 20);
    
    
    UIView *vie = (UIView *)[cell viewWithTag:3];
    if (vie) {
        [vie removeFromSuperview];
    }
    
    UIView *moreDiscussCounts = [[UIView alloc] initWithFrame:CGRectMake(5, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 30, cell.bounds.size.width - 15,cell.bounds.size.height - (cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 30))];
    moreDiscussCounts.backgroundColor = [UIColor whiteColor];
    moreDiscussCounts.tag = 3;
    [cell addSubview:moreDiscussCounts];
    
    discuse *discus = [[discuse alloc] initWithFrame:moreDiscussCounts.bounds and:[self.pinglunARRAYary objectAtIndex:indexPath.item]];
    [moreDiscussCounts addSubview:discus];
    
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark SOAP 请求
//获取指定客户的指定一篇美容日志数据
-(void)soaprequestwithSno:(NSString *)sno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerBeautifyLogByLogSno xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<sno>%@</sno>\n"
                             "</GetCustomerBeautifyLogByLogSno>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,sno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerBeautifyLogByLogSno" forHTTPHeaderField:@"SOAPAction"];
    
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
    
    
    if ([elementName isEqualToString:@"GetCustomerBeautifyLogByLogSnoResult"]) {
        
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
    if ([elementName isEqualToString:@"GetCustomerBeautifyLogByLogSnoResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"美容足迹个人足迹单条信息--%@",dic);

        
        
        self.pinglunARRAYary = [[NSMutableArray alloc] initWithCapacity:0];//预存多条足迹的评论数组
        
        NSMutableArray *logData = [dic objectForKey:@"customerBeautifyLogData"];
        if (_logDataarray) {
            [_logDataarray removeAllObjects];
            [_contentshightarray removeAllObjects];
        }else{
            _logDataarray = [[NSMutableArray alloc] initWithCapacity:0];
            _contentshightarray = [[NSMutableArray alloc] initWithCapacity:0];
        }
        
        for (NSDictionary *diction in logData) {
            customerBeautifyLogData *BeautifyLogData = [customerBeautifyLogData customerBeautifyLogDataWithDiction:diction];
            [_logDataarray addObject:BeautifyLogData];
            
            CGFloat a = [self contentsWithnsstringcell:BeautifyLogData.Contents] + 200;
            
            NSMutableArray *pinglunarray = [[NSMutableArray alloc] initWithCapacity:0];
            CGFloat b = 0;
            NSMutableArray *DiscussDataarray = [diction objectForKey:@"LogDiscussData"];
            for (NSDictionary  *diction1 in DiscussDataarray) {
                customerBeautifyLogData *BeautifyLogData = [customerBeautifyLogData customerBeautifyLogDataWithDiction:diction1];
                [pinglunarray addObject:BeautifyLogData];
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
            NSString *PicSrc2 = [diction objectForKey:@"PicSrc2"];
            
            NSInteger  c ;
            if (PicSrc2.length > 5) {
                c  = (PicSrcarray.count + 1) / 3;
            }else{
                c  = PicSrcarray.count / 3;
            }
            
            
            float hight = c * (self.view.bounds.size.width - 8)/3;//图片高度
            [_contentshightarray addObject:[NSString stringWithFormat:@"%f",a + hight + b + 20]];//内容的高度 + 评论的高度 + 图片的高度
        }
        
        [self creatcollerctionview];
        [_clView reloadData];
        
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
