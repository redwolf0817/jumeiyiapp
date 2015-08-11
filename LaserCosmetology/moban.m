//
//  moban.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/7.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "moban.h"
#import "TopBarView.h"
#import "ModifyTheTemplate.h"
#import "yishengwanshanziliao.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
@interface moban ()

@end

@implementation moban

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
    titilelable.text = @"完善资料";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    

    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];

    UIImageView *shooseimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    shooseimage.image = [UIImage imageNamed:@"touming"];
    shooseimage.userInteractionEnabled = YES;
    [self.view addSubview:shooseimage];
    
    UIButton *lfbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 25, 20)];
    [lfbtn setBackgroundImage:[UIImage imageNamed:@"完善资料_03a"] forState:UIControlStateNormal];
    [lfbtn addTarget:self action:@selector(zuoyoushoose:) forControlEvents:UIControlEventTouchUpInside];
    lfbtn.tag = 5;
    [shooseimage addSubview:lfbtn];
    
    self.mobanlb = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 60, 20)];
    self.mobanlb.text = @"模板一";
    self.mobanlb.textAlignment = NSTextAlignmentCenter;
    [shooseimage addSubview:self.mobanlb];
    
    self.titleary = [[NSArray alloc] initWithObjects:@"模板一",@"模板二",@"模板三",@"模板四",@"模板五", nil];
    
    UIButton *RITbtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 10, 25, 20)];
    [RITbtn setBackgroundImage:[UIImage imageNamed:@"完善资料_05a"] forState:UIControlStateNormal];
    [RITbtn addTarget:self action:@selector(zuoyoushoose:) forControlEvents:UIControlEventTouchUpInside];
    RITbtn.tag  = 6;
    [shooseimage addSubview:RITbtn];
    
    
    UIButton *bianji = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 50, 5, 40, 30)];
    [bianji setTitle:@"编辑" forState:UIControlStateNormal];
    [bianji setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bianji addTarget:self action:@selector(addediting) forControlEvents:UIControlEventTouchUpInside];
    [shooseimage addSubview:bianji];
    

    
    
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"self.modelNoEnumNo.length=%ld",self.modelNoEnumNo.length);
    
    if (self.modelNoEnumNo.length < 1) {
        self.modelNoEnumNo = @"";
    }
    
    self.doctoersno = [[NSUserDefaults standardUserDefaults] objectForKey:@"customerSno"];
    
        
        [self soaprequstWithdoctorSno:self.doctoersno modelNo:self.modelNoEnumNo];
    
}
-(void)creatmodwith:(NSMutableArray *)modary
{
    //把模板编号存起来
    self.EnumNoarray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < modary.count;i ++) {
        yishengwanshanziliao *mod = [_modelListDataarray objectAtIndex:i];
        [self.EnumNoarray addObject:mod.EnumNo];
    }

    if (_imagescroler) {
        [_imagescroler removeFromSuperview];
    }
    _imagescroler = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, self.view.bounds.size.height - 104)];
    _imagescroler.contentSize = CGSizeMake(0, self.view.bounds.size.height - 104);
    _imagescroler.clipsToBounds = YES;
    _imagescroler.pagingEnabled = YES;
    _imagescroler.delegate = self;
    [self.view addSubview:_imagescroler];
  
}
//根据模板编号来调用模板
-(void)CreatTheModWithTheSeqno{

    _imagescroler.contentSize = CGSizeMake(0, (self.view.bounds.size.height- 104) * (_pictureDataarray.count + 1));
    
    for (int i = 0; i < _pictureDataarray.count; i++) {
        
        yishengwanshanziliao *yis = [_pictureDataarray objectAtIndex:i];
       UIImageView *slideimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.height- 104) * i, self.view.bounds.size.width, self.view.bounds.size.height- 104)];
        [slideimage sd_setImageWithURL:[NSURL URLWithString:yis.PicSrc]];
        slideimage.tag = 50 + i;
        [_imagescroler addSubview:slideimage];
        
        
        
        //最后一个空也页编辑
        if (i == _pictureDataarray.count - 1) {
            UIButton *butn = [[UIButton alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.height- 104) * (i + 1), self.view.bounds.size.width, self.view.bounds.size.height- 104)];
            [butn setTitle:@"点击添加图文" forState:UIControlStateNormal];
            [butn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [butn addTarget:self action:@selector(addediting) forControlEvents:UIControlEventTouchUpInside];
            [_imagescroler addSubview:butn];
        }
        
        //根据EnumNo来确定是第几个模板
        if ([[self.EnumNoarray objectAtIndex:0] isEqualToString:self.modelNo]) {
            self.mobanlb.text = [self.titleary objectAtIndex:0];
            [self CreatTheOneTemplateWithintege:i and:yis.PicDesc];  //模板一的数据
        }else{
            
            self.mobanlb.text = [self.titleary objectAtIndex:1];
            [self CreatTheTwoTemplateWithintege:i nsstring:yis.PicDesc];   //模板二的数据
            
        }
        
    }

}

//模板一
-(void)CreatTheOneTemplateWithintege:(int )a and:(NSString *)str
{
   

        self.image1 = [[UIImageView alloc] init]; [_imagescroler addSubview:self.image1];
        UILabel *lable1 = [[UILabel alloc] init]; [self.image1 addSubview:lable1];
        lable1.textColor = [UIColor whiteColor];
        
        self.image2 = [[UIImageView alloc] init]; [_imagescroler addSubview:self.image2];
        UILabel *lable2 = [[UILabel alloc] init]; [self.image2 addSubview:lable2];
        lable2.textColor = [UIColor whiteColor];
        
        self.image3 = [[UIImageView alloc] init]; [_imagescroler addSubview:self.image3];
        UILabel *lable3 = [[UILabel alloc] init]; [self.image3 addSubview:lable3];
        lable3.textColor = [UIColor whiteColor];
        
        self.image4 = [[UIImageView alloc] init]; [_imagescroler addSubview:self.image4];
        UILabel *lable4 = [[UILabel alloc] init]; [self.image4 addSubview:lable4];
        lable4.textColor = [UIColor whiteColor];
        
        self.image5 = [[UIImageView alloc] init]; [_imagescroler addSubview:self.image5];
        UILabel *lable5 = [[UILabel alloc] init]; [self.image5 addSubview:lable5];
        lable5.textColor = [UIColor whiteColor];
        
        
        
        switch (a % 5) {
            case 0:
            {
                self.image1.frame = CGRectMake(0, (self.view.bounds.size.height- 104) * (a+1) - 200, self.view.bounds.size.width, 120) ;
                self.image1.image = [UIImage imageNamed:@"zhuanjiabeijing"];
                
                lable1.frame = CGRectMake(10, 15,  self.view.bounds.size.width - 10, 90);
                lable1.numberOfLines = 0;
                lable1.text = str;
                
            }
                break;
            case 1:
            {
                self.image2.frame = CGRectMake(10, (self.view.bounds.size.height- 104) * a + 30, self.view.bounds.size.width - 120, self.view.bounds.size.width - 120);
                self.image2.image = [UIImage imageNamed:@"zhuanjiabeijing3"];
                
                lable2.frame = CGRectMake(35, 35, self.view.bounds.size.width - 120 - 50, self.view.bounds.size.width - 120 - 70);
                lable2.numberOfLines = 0;
                lable2.text = str;
                [self.image2 addSubview:lable2];
            }
                break;
            case 2:
            {
                self.image3.frame = CGRectMake(0, (self.view.bounds.size.height- 104) * (a+1) - 200, self.view.bounds.size.width, 120);
                self.image3.image = [UIImage imageNamed:@"zhuanjiabeijing2"];
                
                lable3.frame = CGRectMake(10, 10,  self.view.bounds.size.width - 10, 100);
                lable3.numberOfLines = 0;
                lable3.text = str;
                [self.image3 addSubview:lable3];
            }
                break;
            case 3:
            {
                self.image4.frame = CGRectMake(20, (self.view.bounds.size.height- 104) * a + 80, self.view.bounds.size.width/3, self.view.bounds.size.height/3 + 50);
                self.image4.image = [UIImage imageNamed:@"zhuanjiabeijing1"];
                
                lable4.frame = CGRectMake(15, 15, self.view.bounds.size.width/3 - 30, self.view.bounds.size.height/3 + 50 - 30);
                lable4.numberOfLines = 0;
                lable4.text = str;
                [self.image4 addSubview:lable4];
            }
                break;
            case 4:
            {
                self.image5.frame = CGRectMake(0, (self.view.bounds.size.height- 104) * a + self.view.bounds.size.height/2, self.view.bounds.size.width, 120);
                self.image5.image = [UIImage imageNamed:@"zhuanjiabeijing4"];
                
                lable5.frame = CGRectMake(10, 15,self.view.bounds.size.width - 10, 90);
                lable5.numberOfLines = 0;
                lable5.text = str;
                [self.image5 addSubview:lable5];
            }
                break;
            default:
                break;
        }
        

    
}
//模板二
-(void)CreatTheTwoTemplateWithintege:(int)a nsstring:(NSString *)str
{
    
    self.image1 = [[UIImageView alloc] init]; [_imagescroler addSubview:self.image1];
    UILabel *lable1 = [[UILabel alloc] init]; [self.image1 addSubview:lable1];
    lable1.textColor = [UIColor whiteColor];
    
    self.image2 = [[UIImageView alloc] init]; [_imagescroler addSubview:self.image2];
    UILabel *lable2 = [[UILabel alloc] init]; [self.image2 addSubview:lable2];
    lable2.textColor = [UIColor whiteColor];
    
    self.image3 = [[UIImageView alloc] init]; [_imagescroler addSubview:self.image3];
    UILabel *lable3 = [[UILabel alloc] init]; [self.image3 addSubview:lable3];
    lable3.textColor = [UIColor whiteColor];
    
    self.image4 = [[UIImageView alloc] init]; [_imagescroler addSubview:self.image4];
    UILabel *lable4 = [[UILabel alloc] init]; [self.image4 addSubview:lable4];
    lable4.textColor = [UIColor whiteColor];
    
    self.image5 = [[UIImageView alloc] init]; [_imagescroler addSubview:self.image5];
    UILabel *lable5 = [[UILabel alloc] init]; [self.image5 addSubview:lable5];
    lable5.textColor = [UIColor whiteColor];
    
    switch (a % 5) {
        case 0:
        {
            
            self.image1.frame = CGRectMake(0, (self.view.bounds.size.height- 104) * (a+1) - 200, self.view.bounds.size.width, 120);
            self.image1.image = [UIImage imageNamed:@"zhuanjiabeijing4"];
            
            lable1.frame = CGRectMake(10, 15,  self.view.bounds.size.width - 10, 90);
            lable1.numberOfLines = 0;
            lable1.text = str;
            [self.image1 addSubview:lable1];
        }
            break;
        case 1:
        {
            self.image2.frame = CGRectMake(10, (self.view.bounds.size.height- 104) * a + 30, self.view.bounds.size.width - 120, self.view.bounds.size.width - 120);
            self.image2.image = [UIImage imageNamed:@"zhuanjiabeijing1"];
            
            lable2.frame = CGRectMake(35, 35, self.view.bounds.size.width - 120 - 50, self.view.bounds.size.width - 120 - 70);
            lable2.numberOfLines = 0;
            lable2.text = str;
            [self.image2 addSubview:lable2];
        }
            break;
        case 2:
        {
            self.image3.frame = CGRectMake(0, (self.view.bounds.size.height- 104) * (a+1) - 200, self.view.bounds.size.width, 120);
            self.image3.image = [UIImage imageNamed:@"zhuanjiabeijing2"];
            
            lable3.frame = CGRectMake(10, 10,  self.view.bounds.size.width - 10, 100);
            lable3.numberOfLines = 0;
            lable3.text = str;
            [self.image3 addSubview:lable3];
        }
            break;
        case 3:
        {
            self.image4.frame = CGRectMake(20, (self.view.bounds.size.height- 104) * a + 80, self.view.bounds.size.width/3, self.view.bounds.size.height/3 + 50);
            self.image4.image = [UIImage imageNamed:@"zhuanjiabeijing3"];
            
            lable4.frame = CGRectMake(15, 15, self.view.bounds.size.width/3 - 30, self.view.bounds.size.height/3 + 50 - 30);
            lable4.numberOfLines = 0;
            lable4.text = str;
            [self.image4 addSubview:lable4];
        }
            break;
        case 4:
        {
            self.image5.frame = CGRectMake(0, (self.view.bounds.size.height- 104) * a + self.view.bounds.size.height/2, self.view.bounds.size.width, 120);
            self.image5.image = [UIImage imageNamed:@"zhuanjiabeijing"];
            
            lable5.frame = CGRectMake(10, 15,self.view.bounds.size.width - 10, 90);
            lable5.numberOfLines = 0;
            lable5.text = str;
            [self.image5 addSubview:lable5];
        }
            break;
        default:
            break;
    }

}

//滚动结束后响应
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}

#pragma mark - 按钮区


-(void)zuoyoushoose:(UIButton *)btn
{

    if (btn.tag == 5) {
        
            yishengwanshanziliao *yis = [_modelListDataarray objectAtIndex:0];
            self.modelNoEnumNo = yis.EnumNo;
            [self soaprequstWithdoctorSno:self.doctoersno modelNo:self.modelNoEnumNo];
        
    }else{
            yishengwanshanziliao *yis = [_modelListDataarray objectAtIndexedSubscript:1];
            self.modelNoEnumNo = yis.EnumNo;
            [self soaprequstWithdoctorSno:self.doctoersno modelNo:self.modelNoEnumNo];
    }
    
  
    
}

-(void)addediting
{

   self.Sno = @"";
    self.picDesc = @"";
    self.doType = @"add";
    self.data = @"";
    self.images = nil;
    float a = _imagescroler.contentOffset.y/_imagescroler.frame.size.height;
    
    if (a < _pictureDataarray.count) {
        yishengwanshanziliao *yis = [_pictureDataarray objectAtIndex:a];
        self.picDesc = yis.PicDesc;
        
        self.doType = @"edit";
        self.Sno = yis.Sno;
        
        UIImageView *imagev = (UIImageView *)[_imagescroler viewWithTag:50 + a];
        UIImage *image1 = imagev.image;
        NSData *_data = UIImageJPEGRepresentation(image1, 0.4f);
        NSString *_encodedImageStr = [_data base64Encoding];
        self.data = _encodedImageStr;
        
        self.images = image1;
    }


    NSLog(@"self.doType%@",self.doType);
    
    ModifyTheTemplate *xiugai = [[ModifyTheTemplate alloc] init];
    xiugai.doctorSno = self.doctoersno;
    xiugai.modelNo = self.modelNo;
    xiugai.picSno = self.Sno;
    xiugai.picDesc = self.picDesc;
    xiugai.data = self.data;
    xiugai.doType = self.doType;
    xiugai.myimage = self.images;
    xiugai.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:xiugai animated:YES];
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
-(void)fanhui
{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark -- soap请求

-(void)soaprequstWithdoctorSno:(NSString *)doctorSno modelNo:(NSString *)modelNo
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorPictureData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<modelNo>%@</modelNo>\n"
                             "</GetDoctorPictureData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,modelNo];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorPictureData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
     message:[error description]
     delegate:self
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil];
    [alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // NSLog(@"3 DONE. Received Bytes: %ld", [webData length]);
    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSLog(@"11完善资料的数据--%@",theXML);
    
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
    
    if ([elementName isEqualToString:@"GetDoctorPictureDataResult"]) {
        
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
    
    if ([elementName isEqualToString:@"GetDoctorPictureDataResult"]) {
        
        
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"22完善资料的数据：dic%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        
        NSString *msg = [dic objectForKey:@"msg"];
        
        NSString *modelNo = [dic objectForKey:@"modelNo"];
        self.modelNo = modelNo;
        
        
        NSMutableArray *modelListData = [dic objectForKey:@"modelListData"];
        _modelListDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in modelListData) {
            yishengwanshanziliao *yisheng = [yishengwanshanziliao yishengdatawithdiction:diction];
            [_modelListDataarray addObject:yisheng];
        }
        
        
        NSMutableArray *pictureData = [dic objectForKey:@"pictureData"];
        _pictureDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in pictureData) {
            yishengwanshanziliao *ys = [yishengwanshanziliao  yishengdatawithdiction:diction];
            [_pictureDataarray addObject:ys];
        }
        
        
        if ([state isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
        [self creatmodwith:_modelListDataarray];
        [self CreatTheModWithTheSeqno];
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
