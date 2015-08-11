//
//  UPMedicalRecord.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "UPMedicalRecord.h"
#import "TopBarView.h"
#import "detailsTableViewCell.h"
#import "persens.h"
#import "UIButton+WebCache.h"
#import "PrefixHeader.pch"
@interface UPMedicalRecord ()

@end

@implementation UPMedicalRecord

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _bigscrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _bigscrollview.contentSize = CGSizeMake(0, self.view.bounds.size.height);
    [self.view addSubview:_bigscrollview];
    
    _background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _background.image = [UIImage imageNamed:@"huidi"];
    _background.userInteractionEnabled = YES;
    [_bigscrollview addSubview:_background];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(willgobacke) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"上传病历";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    
    UILabel *xingm = [[UILabel alloc] initWithFrame:CGRectMake(10, 54, 40, 20)];
    xingm.text = @"姓名:";
    xingm.font = [UIFont systemFontOfSize:15];
    [_bigscrollview addSubview:xingm];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(50, 54, 80, 20)];
    name.text = self.name;
    name.font = [UIFont systemFontOfSize:15];
    [_bigscrollview addSubview:name];
    
    UILabel *dianhua = [[UILabel alloc] initWithFrame:CGRectMake(150, 54, 40, 20)];
    dianhua.text = @"电话:";
    dianhua.font = [UIFont systemFontOfSize:15];
    [_bigscrollview addSubview:dianhua];
    
    UILabel *phonenumber = [[UILabel alloc] initWithFrame:CGRectMake(190, 54, self.view.bounds.size.width - 200, 20)];
    phonenumber.text = self.phonenumber;
    phonenumber.font = [UIFont systemFontOfSize:15];
    [_bigscrollview addSubview:phonenumber];
    
    
    UILabel *xiangmu = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 40, 20)];
    xiangmu.text = @"项目:";
    xiangmu.font = [UIFont systemFontOfSize:15];
    [_bigscrollview addSubview:xiangmu];
    
    UILabel *xiangmuname = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, self.view.bounds.size.width - 60, 20)];
    xiangmuname.text = self.project;
    xiangmuname.font = [UIFont systemFontOfSize:15];
    [_bigscrollview addSubview:xiangmuname];
    
    UILabel *yuyueshij = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 80, 20)];
    yuyueshij.text = @"预约时间:";
    yuyueshij.font = [UIFont systemFontOfSize:15];
    [_bigscrollview addSubview:yuyueshij];
    
    UILabel *shijian = [[UILabel alloc] initWithFrame:CGRectMake(85, 110, self.view.bounds.size.width - 100, 20)];
    shijian.text = self.date;
    shijian.font = [UIFont systemFontOfSize:15];
    [_bigscrollview addSubview:shijian];
    
    UILabel *ewai = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 80, 20)];
    ewai.text = @"额外项目:";
    ewai.font = [UIFont systemFontOfSize:15];
    [_bigscrollview addSubview:ewai];
    
    UIButton *tianjiaxiangmu = [[UIButton alloc] initWithFrame:CGRectMake(85, 140, 80, 20)];
    [tianjiaxiangmu setTitle:@"选择项目" forState:UIControlStateNormal];
    [tianjiaxiangmu setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    [tianjiaxiangmu addTarget:self action:@selector(xiangmufenleibtnclicks:) forControlEvents:UIControlEventTouchUpInside];
    [_bigscrollview addSubview:tianjiaxiangmu];
    
    
    _imagelins = [[UIImageView alloc] initWithFrame:CGRectMake(5, 180, self.view.bounds.size.width - 10, 2)];
    _imagelins.image = [UIImage imageNamed:@"hengxian"];
    [_bigscrollview addSubview:_imagelins];
    
    
    _binglitu = [[UILabel alloc] initWithFrame:CGRectMake(10, 195, 80, 20)];
    _binglitu.text = @"病历图片:";
    _binglitu.font = [UIFont systemFontOfSize:15];
    [_bigscrollview addSubview:_binglitu];
    
    _upimage = [[UIButton alloc] initWithFrame:CGRectMake(0, 30 + _binglitu.frame.origin.y , self.view.bounds.size.width, self.view.bounds.size.height - 195 - 110)];
    [_upimage setTitle:@"上传病历（可选）" forState:UIControlStateNormal];
    _upimage.backgroundColor = [UIColor whiteColor];
    [_upimage setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_upimage addTarget:self action:@selector(upimage) forControlEvents:UIControlEventTouchUpInside];
    [_bigscrollview addSubview:_upimage];
    
    
    _queding = [[UIButton alloc] initWithFrame:CGRectMake(20, _bigscrollview.bounds.size.height - 70, self.view.bounds.size.width - 40, 40)];
    [_queding setTitle:@"提交" forState:UIControlStateNormal];
    _queding.backgroundColor = [UIColor whiteColor];
    [_queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [_queding setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    [_bigscrollview addSubview:_queding];

    
    self.numberary = [[NSMutableArray alloc] initWithCapacity:0];
    self.proSnosaryindex = [[NSMutableArray alloc] initWithCapacity:0];
    self.selectorary = [[NSMutableArray alloc] initWithCapacity:0];
    self.resut = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self soaprequst2WithdoctorSno:self.doctorsno orderDetailSno:self.orderDetailSno];
    
}
-(void)relodimage
{
    [_upimage sd_setBackgroundImageWithURL:[NSURL URLWithString:self.historyPic] forState:UIControlStateNormal placeholderImage:nil];
}
-(void)willgobacke{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)creatproject
{
    
        float btnhigth = 25;
    
        float jianxi = 10;
        float x = 10;
        NSInteger hangshu = 0;
    
    if (self.a > 0) {
        for (int j = 0; j < self.a; j++) {
            UIButton *buttn = (UIButton *)[self.view viewWithTag:j + 10];
            [buttn removeFromSuperview];
        }
    }

    
    self.a = self.resut.count;
        for (int i = 0; i < self.resut.count; i ++) {
            if (x + [self NSStringwithsize:17 str:[self.resut objectAtIndex:i]] + 5 >= self.view.bounds.size.width) {
                hangshu = hangshu + 1;
                x = 10;
            }
            NSInteger yh = (5 + btnhigth) * hangshu + jianxi + 160;
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, yh,10 + [self NSStringwithsize:17 str:[self.resut objectAtIndex:i]], btnhigth)];
            button.titleLabel.font = [UIFont systemFontOfSize:17];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setTitle:[self.resut objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(titleforclick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 10 + i;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 2;
            button.backgroundColor = [UIColor whiteColor];
            [_bigscrollview addSubview:button];
            
            self.btnyhigth = yh + btnhigth;
            x = [self NSStringwithsize:17 str:[self.resut objectAtIndex:i]] + 10 + x + jianxi;
        }
    
    if (self.btnyhigth == 0) {
        self.btnyhigth = 160;
    }
    
    _background.frame = CGRectMake(0, 24, self.view.bounds.size.width, self.view.bounds.size.height + self.btnyhigth);
    _bigscrollview.contentSize = CGSizeMake(0, _bigscrollview.frame.size.height + self.btnyhigth - 170);
    _imagelins.frame = CGRectMake(5, self.btnyhigth + 10, self.view.bounds.size.width - 10, 2);
    _binglitu.frame = CGRectMake(10, self.btnyhigth + 10 + 15, 80, 20);

     _upimage.frame = CGRectMake(0, _binglitu.frame.origin.y + 30, self.view.bounds.size.width, self.view.bounds.size.height - 195 - 110);
    _queding.frame = CGRectMake(20, _bigscrollview.contentSize.height - 70, self.view.bounds.size.width - 40, 40);
    

}
-(void)reloadnewdata
{
    
    for (persens *per in self.orderproject) {
        
        for (int i = 0; i < self.numberary.count; i++) {
            persens *per1 = [self.numberary objectAtIndex:i];
            if ([per1.Sno isEqualToString:per.ProSno]) {
                
                [self.selectorary replaceObjectAtIndex:i withObject:@"n"];
                [self.proSnosaryindex addObject:[NSString stringWithFormat:@"%d",i]];
                [self.resut addObject:per.ProName];
            }
        }
            
        }
    
    self.proSnos = @"";
    
    for (NSString * snostr in self.proSnosaryindex) {
        persens *pers = [self.numberary objectAtIndex:[snostr integerValue]];
        self.proSnos = [NSString stringWithFormat:@"%@,%@",self.proSnos,pers.Sno];
    }

    [self creatproject];
        
}

//计算字体长度
-(float)NSStringwithsize:(int)a str:(NSString *)string
{
    
    UIFont *font = [UIFont systemFontOfSize:a];
    
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat strwidth = size.width;
    
    return strwidth;
}
-(void)titleforclick:(UIButton *)btn
{
    self.cancelbtnindex = btn.tag;
    NSString *str =[NSString stringWithFormat:@"你确定要删除“%@”项目吗？",[btn currentTitle]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 71;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 71) {
        
        if (buttonIndex == 0) {
            return;
        }else{
            UIButton *btn = (UIButton *)[_bigscrollview viewWithTag:self.cancelbtnindex];
            NSString *string = [btn currentTitle];
            [btn removeFromSuperview];
            
            for (int i = 0; i < self.selectorary.count; i++) {
                persens *per = [self.numberary objectAtIndex:i];
                
                if ([per.Name isEqualToString:string]) {
                    [self.selectorary replaceObjectAtIndex:i withObject:@"y"];
                    for (NSString *strindex in self.proSnosaryindex) {
                        if ([strindex isEqualToString:[NSString stringWithFormat:@"%d",i]]) {
                            [self.proSnosaryindex removeObject:[NSString stringWithFormat:@"%d",i]];
                            break;//一定要有break，不然会崩。
                        }
                        
                    }
                    
                }}
            
            [self removeshoosetableviewFromSuperviews1];
        }

    }else{
        [self fanhui];
    }
    
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)xiangmufenleibtnclicks:(UIButton *)button
{
    if (self.isfenlei == NO) {
        
        self.Righttableview = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40, 64, self.view.bounds.size.width/2 + 40, self.view.bounds.size.height - 64)];
        self.Righttableview.delegate = self;
        self.Righttableview.dataSource = self;
        self.Righttableview.tag = 212;
        self.Righttableview.showsVerticalScrollIndicator = NO;
        self.Righttableview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.Righttableview];
        
        self.isfenlei = YES;
        
        self.shoosebackimage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40, self.view.bounds.size.height - 40, self.view.bounds.size.width/2 + 40, 40)];
        self.shoosebackimage.image = [UIImage imageNamed:@"医生主页1_022"];
        [self.view addSubview:self.shoosebackimage];
        
        self.shoosebtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40 + (self.view.bounds.size.width/2 + 40)/2 - 40, self.view.bounds.size.height - 35, 80, 30)];
        [self.shoosebtn setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
        [self.shoosebtn setTitle:@"选择完毕" forState:UIControlStateNormal];
        [self.shoosebtn addTarget:self action:@selector(removeshoosetableviewFromSuperviews1) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.shoosebtn];
        
    }else{
        
        [self removeshoosetableviewFromSuperviews1];
    }
    
}
-(void)removeshoosetableviewFromSuperviews1
{
    
    if (self.Righttableview) {
        
        [self.Righttableview removeFromSuperview];
        self.Righttableview = nil;
        
        [self.shoosebackimage removeFromSuperview];
        self.shoosebackimage = nil;
        
        [self.shoosebtn removeFromSuperview];
        self.shoosebtn = nil;
        
        self.isfenlei = NO;
    }

    
    [self.resut removeAllObjects];//清空后重新加载
    [self.proSnosaryindex removeAllObjects];
    self.proSnos = @"";
    
    for (NSInteger i = self.selectorary.count - 1; i >= 0; i --) {
        NSString *str = [self.selectorary objectAtIndex:i];
        if ([str isEqualToString:@"n"]) {
            persens *per = [self.numberary objectAtIndex:i];
            [self.resut addObject:per.Name];
            [self.proSnosaryindex addObject:[NSString stringWithFormat:@"%ld",i]];
        }
    }
    
    for (NSString * snostr in self.proSnosaryindex) {
        persens *per = [self.numberary objectAtIndex:[snostr integerValue]];
        self.proSnos = [NSString stringWithFormat:@"%@,%@",self.proSnos,per.Sno];
    }

    [self creatproject];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numberary.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        
        static NSString *identifier = @"cell1";
        detailsTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell1) {
            cell1 = [[detailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    
    persens *per = [self.numberary objectAtIndex:indexPath.row];
    
    cell1.contents.frame = CGRectMake(10, 10, cell1.bounds.size.width, 20);
    cell1.contents.text = per.Name;
    
    NSString *str = [self.selectorary objectAtIndex:indexPath.row];
    if ([str isEqualToString:@"n"]) {
        cell1.contents.textColor = [UIColor redColor];
    }else{
        cell1.contents.textColor = [UIColor blackColor];
    }
    

    
        return cell1;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [self.selectorary objectAtIndex:indexPath.row];
    
    if ([str isEqualToString:@"y"]) {
        [self.selectorary replaceObjectAtIndex:indexPath.row withObject:@"n"];
        
    }else{
        [self.selectorary replaceObjectAtIndex:indexPath.row withObject:@"y"];
        
        
        for (NSString *strindex in self.proSnosaryindex) {
            if ([strindex isEqualToString:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                break;//一定要有break，不然会崩。
            }
        }
    }
    
        NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
        NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
        [self.Righttableview reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
        
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

#pragma mark -- 按钮区

-(void)fanhui
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)queding
{
   NSString *fileTypeName = @"png";
    if (self.data == nil) {
        self.data = @"";
        fileTypeName = @"";
    }
    
    self.productorsno = self.proSnos;
    NSLog(@"self.doctorsno :%@----self.orderDetailSno-%@---self.productorsno--%@-----self.date-%@---self.productorsno: %@",self.doctorsno,self.orderDetailSno,self.productorsno,self.data,self.productorsno);
    
       [self soaprequst2WithdoctorSno:self.doctorsno orderDetailSno:self.orderDetailSno data:self.data fileTypeName:fileTypeName proSnos:self.productorsno];
}
-(void)quxiao{
    
NSLog(@"取消发送照片");
}
-(void)upimage
{
    NSLog(@"要上传照片");
    
    [self.view endEditing:YES];
    
    pickerimageViewController *picker = [[pickerimageViewController alloc] init];
    picker.delegate1 = self;
    [self.navigationController pushViewController:picker animated:YES];
}
-(void)sendimage:(UIImage *)imagess{
    
    [_upimage setBackgroundImage:imagess forState:UIControlStateNormal];
    [_upimage setTitle:@"" forState:UIControlStateNormal];
    
    NSData *_datas = UIImageJPEGRepresentation(imagess, 0.4f);
    NSString *_encodedImageStr = [_datas base64Encoding];
    self.data = _encodedImageStr;
    

 
}

#pragma mark -- soap请求
//病历上传界面数据
-(void)soaprequst2WithdoctorSno:(NSString *)doctorSno orderDetailSno:(NSString *)orderDetailSno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetSetMedicalHistoryData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<orderDetailSno>%@</orderDetailSno>\n"
                             "</GetSetMedicalHistoryData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,orderDetailSno];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetSetMedicalHistoryData" forHTTPHeaderField:@"SOAPAction"];
    
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

//提交订单详情病历资料数据
-(void)soaprequst2WithdoctorSno:(NSString *)doctorSno orderDetailSno:(NSString *)orderDetailSno data:(NSString *)data fileTypeName:(NSString *)fileTypeName proSnos:(NSString *)proSnos
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SetMedicalHistory xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<orderDetailSno>%@</orderDetailSno>\n"
                             "<data>%@</data>\n"
                             "<fileTypeName>%@</fileTypeName>\n"
                             "<proSnos>%@</proSnos>\n"
                             "</SetMedicalHistory>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,orderDetailSno,data,fileTypeName,proSnos];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SetMedicalHistory" forHTTPHeaderField:@"SOAPAction"];
    
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
    NSLog(@"我的客户的数据--%@",theXML);
    
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
    
    if ([elementName isEqualToString:@"GetSetMedicalHistoryDataResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"SetMedicalHistoryResult"]) {
        
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
    
    if ([elementName isEqualToString:@"GetSetMedicalHistoryDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"获取上传病历页面资料的数据的数据：dic%@",dic);

        NSMutableArray *allProData = [dic objectForKey:@"allProData"];
        for (NSDictionary *alldata in allProData) {
            persens *per = [persens persensWithdictionary:alldata];
            [self.numberary addObject:per];
        }

        self.selectorary = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < self.numberary.count; i++) {
            [self.selectorary addObject:@"y"];
        }

        NSMutableArray *basicData = [dic objectForKey:@"basicData"];
        NSDictionary *basicDatadic = [basicData objectAtIndex:0];
        self.BookDt = [basicDatadic objectForKey:@"BookDt"];
        self.CellPhone = [basicDatadic objectForKey:@"CellPhone"];
        self.CusName = [basicDatadic objectForKey:@"CusName"];
        self.ProName = [basicDatadic objectForKey:@"ProName"];
        
        self.historyPic = [dic objectForKey:@"historyPic"];

        [self relodimage];
        
        NSMutableArray *extraProData = [dic objectForKey:@"extraProData"];
        self.orderproject = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in extraProData) {
            persens *per = [persens persensWithdictionary:diction];
            [self.orderproject addObject:per];
        }
        [self reloadnewdata];
    }
    
    
    if ([elementName isEqualToString:@"SetMedicalHistoryResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"上传病历页面资料的数据的数据：dic%@",dic);
        NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.tag = 70;
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
