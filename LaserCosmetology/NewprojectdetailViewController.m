//
//  NewprojectdetailViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"
#import "persens.h"
#import "Beautyitems.h"
#import "NewprojectdetailViewController.h"
#import "TopBarView.h"
#import "Detailsproject.h"
#import "ProjectpersentTableViewCell.h"
#import "ProjectbeautyTableViewCell.h"
#import "PrefixHeader.pch"
@interface NewprojectdetailViewController ()

@end

@implementation NewprojectdetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"项目目录_02"];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = self.titiles;
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(xiangmumumingcheng) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    

    
    self.fenleitableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width/2 - 40, self.view.bounds.size.height - 64)];
    self.fenleitableview.delegate = self;
    self.fenleitableview.dataSource = self;
    self.fenleitableview.tag = 211;
    self.fenleitableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.fenleitableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.fenleitableview];
    
    self.Righttableview = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40, 64, self.view.bounds.size.width/2 + 40, self.view.bounds.size.height - 64)];
    self.Righttableview.delegate = self;
    self.Righttableview.dataSource = self;
    self.Righttableview.tag = 212;
    self.Righttableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.Righttableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.Righttableview];
    
    
    [self soaprequstWithproTypeNo:self.proTypeNo];
}

-(void)DoingGrouping
{
    self.allfenlei = [[NSMutableArray alloc] initWithCapacity:0];
    self.allfenlei = _proDataary;
    
    self.fenei = [[NSMutableArray alloc] initWithCapacity:0];
     for (Beautyitems *beauty in _proTypeDataary) {
    
         NSMutableArray *prosno = [[NSMutableArray alloc] initWithCapacity:0];
    for (persens *per in _proDataary) {
        if ([beauty.EnumNo isEqualToString:per.ProTypeNo]) {
            [prosno addObject:per];
        }
        }
         
         [self.fenei addObject:prosno];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 211) {
        return _proTypeDataary.count + 1;

    }else{
        return _proDataary.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 211) {
        
        static NSString *identifier1 = @"cell1";
        ProjectpersentTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell1) {
            cell1 = [[ProjectpersentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];

        }

        if (selector == indexPath.row) {
            cell1.proname.textColor = [self colorWithRGB:0x00c5bb alpha:1];
        }else{
            cell1.proname.textColor = [UIColor blackColor];
        }
        
         cell1.backgroundColor = [UIColor clearColor];
        cell1.backimage.frame = CGRectMake(0,0, self.fenleitableview.frame.size.width, 50);
        if (indexPath.row == 0) {
             cell1.proname.text =@"全部";
        }else{
            
        Beautyitems *beauty = [_proTypeDataary objectAtIndex:indexPath.row - 1];
            cell1.proname.text = beauty.EnumName;
            
        }
        
        cell1.proname.frame = CGRectMake(5, 15, self.fenleitableview.frame.size.width - 10, 20);
        return cell1;
       
    }else{
    
        static NSString *identifier = @"cell";
        ProjectbeautyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ProjectbeautyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
         persens *per = [_proDataary objectAtIndex:indexPath.row];
        cell.backimage.frame = CGRectMake(0, 0,self.Righttableview.frame.size.width , 40);
        cell.proname.text = per.ProName;
        cell.proname.frame = CGRectMake(5, 10, self.Righttableview.frame.size.width - 10, 20);
        
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 211) {
        return 50;
    }else{
        return 40;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView.tag == 211) {
        
        selector = indexPath.row;
        if (indexPath.row == 0) {
            _proDataary = self.allfenlei;
            
        }else{
         NSMutableArray *smalary = [self.fenei objectAtIndex:indexPath.row - 1];
            _proDataary = smalary;
        }
        [self.fenleitableview reloadData];
         [self.Righttableview reloadData];
        
    }else{
    
        persens *per = [_proDataary objectAtIndex:indexPath.row];
        Detailsproject *details = [[Detailsproject alloc] init];
        details.sno = per.ProSno;
        details.EnumName = per.ProName;
        details.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:details animated:YES];
    
    }
    
}
-(void)xiangmumumingcheng
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark --SOAP 请求!
//获取美容项目一级类别界面数据
-(void)soaprequstWithproTypeNo:(NSString *)proTypeNo
{
    
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetProPageData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<proTypeNo>%@</proTypeNo>\n"
                             "</GetProPageData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,proTypeNo];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetProPageData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    
    // NSLog(@"ERROR with theConenction");[error description]//链接超时的错误报告！
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
    //NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    // NSLog(@"美容项目详情请求回来的数据--%@",theXML);
    
    
    NSString *str = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"请求回来的数据-2--%@",str);
    
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
    
    
    
    
    if ([elementName isEqualToString:@"GetProPageDataResult"]) {
        
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
    
    
    
    
    if ([elementName isEqualToString:@"GetProPageDataResult"]) {
        // NSLog(@"-_soapResults-%@",_soapResults);
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"获取美容项目二级数据:%@",dic);
        _proDataary = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *proData = [dic objectForKey:@"proData"];
        for (NSDictionary *beautydic in proData) {
            persens *per = [persens persensWithdictionary:beautydic];
            [_proDataary addObject:per];
        }

        
        _proTypeDataary = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *proTypeData = [dic objectForKey:@"proTypeData"];
        for (NSDictionary *prodic in proTypeData) {
            Beautyitems *beauty = [Beautyitems analysiswithdictionary:prodic];
            [_proTypeDataary addObject:beauty];
        }
        
        [self.fenleitableview reloadData];
        [self.Righttableview reloadData];
        [self DoingGrouping];

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
