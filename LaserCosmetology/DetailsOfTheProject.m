//
//  DetailsOfTheProject.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#define UID @"wdc001"
#define PSW @"dcg658"

#import "DetailsOfTheProject.h"
#import "TopBarView.h"
#import "Detailsproject.h"
#import "mybutton.h"
#import "Beautyitems.h"
#import "CLCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
static NSString *cellIdentifier = @"cell";
@interface DetailsOfTheProject ()

@end

@implementation DetailsOfTheProject

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
    
    _titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    _titilelable.text = self.titlename;
    _titilelable.textColor = [UIColor whiteColor];
    _titilelable.font = [UIFont systemFontOfSize:22];
    _titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    _titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:_titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(fenleibackbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    UIButton *fenleibtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 55, 25, 40, 30)];
    [fenleibtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fenleibtn setBackgroundImage:[UIImage imageNamed:@"fenleiimages"] forState:UIControlStateNormal];
    fenleibtn.layer.masksToBounds = YES;
    fenleibtn.layer.cornerRadius = 4;
    [fenleibtn addTarget:self action:@selector(xiangmufenleibtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:fenleibtn];
    
    [self creatitemsubviewwitharray:_itemsary];
    
    NSLog(@"请求的标识码---------->>%@",self.beautyEnumNo);
    [self soaprequstWithproductType:self.beautyEnumNo isGetTypeInfo:@"1" strPageindex:@"1" strPagesize:@"40"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 211) {
        return _productTypeDataarray.count + 1;
    }else if (tableView.tag == 212){
        return [[_itemsarray objectAtIndex:self.SelectRowAtIndexPath] count] + 1;
    }else{
        return 0;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 211) {
        static NSString *identifier = @"cell1";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell1.backgroundColor = [UIColor clearColor];
        
        
        if (indexPath.row >= 1) {
            Beautyitems *beauty = [_productTypeDataarray objectAtIndex:indexPath.row - 1];
            cell1.textLabel.text = beauty.text;
        }else{
            cell1.textLabel.text = @"全部";
        }
        
        return cell1;
    }else if (tableView.tag == 212){
        
        static NSString *identifier2 = @"cell2";
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell2) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        
        if (indexPath.row >= 1) {
            NSMutableArray *smallary = [_itemsarray objectAtIndex:self.SelectRowAtIndexPath];
            Beautyitems *beauty = [smallary objectAtIndex:indexPath.row - 1];
            cell2.textLabel.text = beauty.text;
        }else{
            cell2.textLabel.text = @"全部";
        }
        
        return cell2;
    }else{
        return nil;
    }
    
    
}
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 211) {
        if (indexPath.row == 0) {
            [self soaprequstWithproductType:@"" isGetTypeInfo:@"1" strPageindex:@"1" strPagesize:@"40"];
            [self removeshoosetableviewFromSuperview];
            _titilelable.text = @"全部";
        }else{
            Beautyitems *beauty = [_productTypeDataarray objectAtIndex:indexPath.row-1];
            self.itemesID = beauty.itmesid;
            
            self.SelectRowAtIndexPath = indexPath.row - 1;
            [self.Righttableview reloadData];
             _titilelable.text = beauty.text;
        }
        
        
        
    }else{
        
        if (indexPath.row == 0) {
            NSLog(@"左边列表的项目编号：%@",self.itemesID);
            [self soaprequstWithproductType:self.itemesID isGetTypeInfo:@"1" strPageindex:@"1" strPagesize:@"40"];
            [self removeshoosetableviewFromSuperview];
        }else{
            
            NSMutableArray *smallary = [_itemsarray objectAtIndex:self.SelectRowAtIndexPath];
            Beautyitems *beauty = [smallary objectAtIndex:indexPath.row - 1];
            
            [self soaprequstWithproductType:beauty.itmesid isGetTypeInfo:@"1" strPageindex:@"1" strPagesize:@"40"];
            [self removeshoosetableviewFromSuperview];
        }
    }
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemsary.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    Beautyitems *beauty = [_itemsary objectAtIndex:indexPath.row];
    
    [cell.immagg sd_setImageWithURL:[NSURL URLWithString:beauty.PicSrc]];
    
    cell.namelable.text = [NSString  stringWithFormat:@"%@",beauty.Name];
    cell.namelable.frame = CGRectMake(5, cell.bounds.size.height-43, [self NSStringwithfont:cell.namelable.text], 18);
    cell.layer.masksToBounds = YES;
    
    cell.prilable.text = @"￥";
    cell.prilable.frame = CGRectMake(5, cell.bounds.size.height-25,[self NSStringwithfont:cell.prilable.text], 18);
    
    cell.prilablenumber.text = beauty.ReferencePrice;
    cell.prilablenumber.frame = CGRectMake([self NSStringwithfont:cell.prilable.text] + 5, cell.bounds.size.height-25, [self NSStringwithfont:cell.prilablenumber.text], 18);
    
    cell.prilablelater.text = @"";
    cell.prilablelater.frame = CGRectMake(cell.prilablenumber.frame.origin.x + [self NSStringwithfont:cell.prilablenumber.text], cell.bounds.size.height-25, [self NSStringwithfont:cell.prilablelater.text], 18);
    
    cell.hotlable.text = @"人气:";
    cell.hotlable.frame = CGRectMake(cell.prilablenumber.frame.origin.x + [self NSStringwithfont:cell.prilablenumber.text] + 10, cell.bounds.size.height-25, [self NSStringwithfont: cell.hotlable.text], 18);
    
    cell.hotlablenumber.text = beauty.LikeCount;
    cell.hotlablenumber.frame = CGRectMake([self NSStringwithfont:cell.hotlable.text] + cell.hotlable.frame.origin.x,cell.bounds.size.height-25, [self NSStringwithfont:cell.hotlablenumber.text], 18);
    
    
    cell.hotlablelater.text = @"";
    cell.hotlablelater.frame = CGRectMake(cell.hotlablenumber.frame.origin.x + [self NSStringwithfont:cell.hotlablenumber.text], cell.bounds.size.height-25, [self NSStringwithfont:cell.hotlablelater.text], 18);

    return cell;
}

//计算字符串的长度值
-(float)NSStringwithfont:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:17];
    
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat nameW = size.width;
    
    return nameW;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld %ld", indexPath.section, indexPath.row);
    
    
    Beautyitems *bty = [_itemsary objectAtIndex:indexPath.row];
    Detailsproject *details = [[Detailsproject alloc] init];
    details.sno = bty.Sno;
    details.EnumName = bty.Name;
    details.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:details animated:YES];
    
    
}

//创建每一个单元子视图
-(void)creatitemsubviewwitharray:(NSArray *)array
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0,114, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    image.image = [UIImage imageNamed:@"huisebeijing"];
    [self.view addSubview:image];
    
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
    flowLayout.minimumLineSpacing = 5.0;//行间距(最小值)
    flowLayout.minimumInteritemSpacing = 5.0;//item间距(最小值)
    flowLayout.itemSize = CGSizeMake((self.view.bounds.size.width - 15)/2, 210);//item的大小
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 10, 5);//设置section的边距
    //    flowLayout.headerReferenceSize = CGSizeMake(320, 20);
    //    flowLayout.footerReferenceSize = CGSizeMake(320, 20);
    
    //第二个参数是cell的布局
    if (self.collectionView) {
        
        self.collectionView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        //1 注册复用cell(cell的类型和标识符)(可以注册多个复用cell, 一定要保证重用标示符是不一样的)注册到了collectionView的复用池里
        [self.collectionView registerClass:[CLCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        [self.view addSubview:self.collectionView];
    }else{
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:flowLayout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        //1 注册复用cell(cell的类型和标识符)(可以注册多个复用cell, 一定要保证重用标示符是不一样的)注册到了collectionView的复用池里
        [self.collectionView registerClass:[CLCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        self.collectionView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:self.collectionView];
        
    }
    
    
}


#pragma mark 点击事件
-(void)fenleibackbuttonclick
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)xiangmufenleibtnclick{
//
//
//    if (self.isfenlei == NO) {
//        _viewbtn = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width,0)];
//        _viewbtn.backgroundColor = [UIColor grayColor];
//        _viewbtn.alpha = 0.95;
//        [self.view addSubview:_viewbtn];
//
//        float btnheigth = 25;
//        float jianxi = (self.view.bounds.size.width - 240)/4;
//        float x = jianxi;
//        NSInteger hangshu = 0;
//        NSInteger yh = 0 ;
//        for (int i = 0; i < _productTypeDataarray.count; i ++) {
//
//            Beautyitems *beauty = [_productTypeDataarray objectAtIndex:i];
//            NSString *title = beauty.EnumName;
//
//            if (x + 80 + 10 >= self.view.bounds.size.width) {
//                hangshu = hangshu + 1;
//                x = jianxi;
//            }
//            yh = (10 + btnheigth) * hangshu + 10;
//
//            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, yh, 80, btnheigth)];
//            button.backgroundColor = [UIColor whiteColor];
//            [button setTitle:title forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(fenleibtnclick:) forControlEvents:UIControlEventTouchUpInside];
//            button.tag = 10 + i;
//            button.layer.masksToBounds = YES;
//            button.layer.cornerRadius = 4;
//            [_viewbtn addSubview:button];
//
//            x = 80 + x + jianxi;
//        }
//        self.isfenlei = YES;
//        _viewbtn.frame = CGRectMake(0, 64, self.view.bounds.size.width,yh + btnheigth + 10);
//    }else{
//
//        [_viewbtn removeFromSuperview];
//        self.isfenlei = NO;
//    }
//
//
//}
//
//-(void)fenleibtnclick:(UIButton *)button
//{
//    self.isfenlei = NO;
//    Beautyitems *beauty = [_productTypeDataarray objectAtIndex:button.tag - 10];
//    NSLog(@"啥玩意--%@",beauty.EnumName);
//    [self soaprequstWithproductType:beauty.EnumNo isGetTypeInfo:@"1" strPageindex:@"1" strPagesize:@"40"];
//    [_viewbtn removeFromSuperview];
//}

-(void)xiangmufenleibtnclick:(UIButton *)button
{
    if (self.isfenlei == NO) {
        self.imahe = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width/2 - 40, self.view.bounds.size.height - 64)];
        self.imahe.image = [UIImage imageNamed:@"huisebeijing"];
        [self.view addSubview:self.imahe];
        
        self.fenleitableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width/2 - 40, self.view.bounds.size.height - 64)];
        self.fenleitableview.delegate = self;
        self.fenleitableview.dataSource = self;
        self.fenleitableview.tag = 211;
        self.fenleitableview.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.fenleitableview];
        
        self.Righttableview = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40, 64, self.view.bounds.size.width/2 + 40, self.view.bounds.size.height - 64)];
        self.Righttableview.delegate = self;
        self.Righttableview.dataSource = self;
        self.Righttableview.tag = 212;
        self.Righttableview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.Righttableview];
        
        self.isfenlei = YES;
    }else{
        [self removeshoosetableviewFromSuperview];
    }
    
    
    
}
-(void)removeshoosetableviewFromSuperview
{
    
    [self.imahe removeFromSuperview];
    self.imahe = nil;
    [self.fenleitableview removeFromSuperview];
    self.fenleitableview = nil;
    [self.Righttableview removeFromSuperview];
    self.Righttableview = nil;
    
    self.isfenlei = NO;
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

#pragma mark --SOAP请求

-(void)soaprequstWithproductType:(NSString *)productType isGetTypeInfo:(NSString *)isGetTypeInfo strPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize;
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetBeautifyProductByRule xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<productType>%@</productType>\n"
                             "<isGetTypeInfo>%@</isGetTypeInfo>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetBeautifyProductByRule>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,productType,isGetTypeInfo,strPageindex,strPagesize];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetBeautifyProductByRule" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    //NSHTTPURLResponse *urlresponse = (NSHTTPURLResponse *)response;
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
    //  NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    // NSLog(@"美容项目请求回来的数据--%@",theXML);
    
    
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
    
    
    
    
    if ([elementName isEqualToString:@"GetBeautifyProductByRuleResult"]) {
        
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
    
    if ([elementName isEqualToString:@"GetBeautifyProductByRuleResult"]) {
        //   NSLog(@"_soapResults-AAAAAAA------------------------:%@AAAAAAA------------------------:",_soapResults);
        
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
       // NSLog(@"项目列表详情资料：%@",dic);
        
        NSMutableArray *productData = [dic objectForKey:@"productData"];
        if (_itemsary) {
            [_itemsary removeAllObjects];
        }else{
            _itemsary = [[NSMutableArray alloc] initWithCapacity:0];
        }
        
        for (NSDictionary *dictionary in productData) {
            Beautyitems *items = [Beautyitems analysiswithdictionary:dictionary];
            [_itemsary addObject:items];
        }
        
        NSMutableArray *productTypeData = [dic objectForKey:@"productTypeData"];
        _productTypeDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        _itemsarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in productTypeData) {
            Beautyitems *type = [Beautyitems analysiswithdictionary:diction];
            [_productTypeDataarray addObject:type];
            
            NSMutableArray *smallitems = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *children = [diction objectForKey:@"children"];
            for (NSDictionary *small in children) {
                Beautyitems *smalltype = [Beautyitems analysiswithdictionary:small];
                [smallitems addObject:smalltype];
            }
            [_itemsarray addObject:smallitems];
        }
        
        [self.collectionView reloadData];
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
