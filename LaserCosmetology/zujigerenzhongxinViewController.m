//
//  zujigerenzhongxinViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/21.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "zujigerenzhongxinViewController.h"
#import "gerenzujiCollectionViewCell.h"
#import "gerenzujiViewLayout.h"
#import "TopBarView.h"
#import "customerBeautifyLogData.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "mybutton.h"
#import "discuse.h"
#import "YuYueShiJianBiaoShuJu.h"
#import "MakeAppointment.h"
#import "zhuanjialiebiao.h"
#import "Detailsproject2.h"
#import "PrefixHeader.pch"
static NSString * const identifier = @"cell";

@interface zujigerenzhongxinViewController ()

@end

@implementation zujigerenzhongxinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = self.customername;
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(zujibackbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    // 年月日获得
    comps =[calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay)
                       fromDate:date];
    self.year = [comps year];
    self.month = [comps month];
    self.day = [comps day];
    NSInteger days = [self getDaysOfMonthwithyear:self.year month:self.month];//计算当月的天数
    self.dayarray = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int a = 1; a < days + 1; a ++) {
        NSString *daystr = [NSString stringWithFormat:@"%d",a];
        [self.dayarray addObject:daystr];
    }
    
    NSUserDefaults *usedf = [NSUserDefaults standardUserDefaults];
    self.customerSno = [usedf objectForKey:@"customerSno"];
    
    _monaay = [[NSArray alloc] initWithObjects:@"01",@"02", @"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil];
    
    
    self.pinglunARRAYary = [[NSMutableArray alloc] initWithCapacity:0];//预存多条足迹的评论数组
        _logDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        _contentshightarray = [[NSMutableArray alloc] initWithCapacity:0];
   
  
    [self soaprequestwithcustomerSno:self.customersno strPageindex:@"1" strPagesize:@"50"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pingjiaa:) name:@"huoqusuoyin" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choosetimemethd:) name:@"mywillmark" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagebuttonclick:) name:@"imagebuttonclick" object:nil];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)zujibackbuttonclick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)pingjiaa:(NSNotification *)notification
{
    NSInteger str = [[notification object] integerValue];
    
    customerBeautifyLogData *log = [_logDataarray objectAtIndex:str];
    self.logSno = log.Sno;
    if (_backview == nil) {
        _backview = [[UIView alloc] initWithFrame:self.view.bounds];
        _backview.backgroundColor = [UIColor blackColor];
        _backview.alpha = 0.6;
        [self.view addSubview:_backview];
    }
    
    if (_tunningview == nil) {
        
        _tunningview = [[UIView alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, self.view.bounds.size.height/2 - 60 )];
        _tunningview.backgroundColor = [UIColor whiteColor];
        _tunningview.layer.masksToBounds = YES;
        _tunningview.layer.masksToBounds = YES;
        _tunningview.layer.cornerRadius = 4;
        [self.view addSubview:_tunningview];
    }
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    background.layer.masksToBounds = YES;
    background.layer.cornerRadius = 4;
    [_tunningview addSubview:background];
    
    UIButton *off = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 35, 35)];
    [off setBackgroundImage:[UIImage imageNamed:@"c"] forState:UIControlStateNormal];
    [off addTarget:self action:@selector(offbuttunclick) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:off];
    
    UIButton *send = [[UIButton alloc] initWithFrame:CGRectMake(_tunningview.bounds.size.width - 40, 5, 35, 35)];
    [send setBackgroundImage:[UIImage imageNamed:@"g"] forState:UIControlStateNormal];
    [send addTarget:self action:@selector(sendbuttunclick) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:send];
    
    _textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, _tunningview.bounds.size.width - 20, _tunningview.bounds.size.height - 60)];
    [background addSubview:_textview];
    
}
-(void)offbuttunclick{
    
    if (_backview != nil) {
        [_backview removeFromSuperview];
        _backview = nil;
    }
    
    if (_tunningview != nil) {
        [_tunningview removeFromSuperview];
        _tunningview = nil;
    }
    
}

-(void)sendbuttunclick
{
    if (_backview != nil) {
        [_backview removeFromSuperview];
        _backview = nil;
    }
    
    if (_tunningview != nil) {
        [_tunningview removeFromSuperview];
        _tunningview = nil;
    }
    
    if (_textview.text.length < 2) {
        
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示！" message:@"内容不能为空！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定！", nil];
        [alter show];
        return;
    }
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
    NSString *myselfsno = [userdf objectForKey:@"customerSno"];
    
    [self soaprequestwithcustomerSno:myselfsno logSno:self.logSno contents:_textview.text];

}

#pragma mark--计算每个月的天数
-(NSInteger)getDaysOfMonthwithyear:(NSInteger)year month:(NSInteger)month
{
    int days = 0;
    
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 9 || month == 10 || month == 12)
    {
        days = 31;
    }
    else if (month == 4 || month == 6 || month == 8 || month == 11)
    {
        days = 30;
    }
    else
    { // 2月份，闰年29天、平年28天
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
        {
            days = 29;
        }
        else
        {
            days = 28;
        }
    }
    
    return days;
}
-(void)selectpikerviewgetdata:(NSInteger)month
{
    
    NSInteger days = [self getDaysOfMonthwithyear:self.year month:month];//计算当月的天数
    if (self.dayarray) {
        [self.dayarray removeAllObjects];
    }
    self.dayarray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int a = 1; a < days + 1; a ++) {
        NSString *daystr = [NSString stringWithFormat:@"%d",a];
        [self.dayarray addObject:daystr];
    }
    
}
#pragma mark-----pickerView 代理方法
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 40;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.monaay objectAtIndex:row];
    }else if (component == 1){
        return @"月";
    }else if (component == 2){
        return [self.dayarray objectAtIndex:row];
    }else{
        return @"日";
    }
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 12;
    }else if (component == 1){
        return 1;
    }else if (component == 2){
        return self.dayarray.count;
    }else{
        return 1;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //月份
    if (component == 0) {
        self.month = row + 1;
    }
    
    //日期
    if (component == 2) {
        self.day = row + 1;
    }
    
   [self selectpikerviewgetdata:self.month];
    
  
    
 //   [self soaprequstWithcityCustomerSno:self.customerSno DoctorSno:self.doctorSno YearCount:[NSString stringWithFormat:@"%ld",self.year] MonthCount:[NSString stringWithFormat:@"%ld",self.month] DayCount:[NSString stringWithFormat:@"%ld",self.day]];
    
}

-(void)creatpickerviewandbackgruond
{
    
    if (_timebackview) {
        
    }else{
        _timebackview = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    _timebackview = [[UIView alloc] initWithFrame:self.view.bounds];
    _timebackview.backgroundColor = [UIColor blackColor];
    _timebackview.alpha = 0.6;
    _timebackview.layer.masksToBounds = YES;
    _timebackview.layer.cornerRadius = 4;
    [self.view addSubview:_timebackview];
    
    if (_timetunningview) {
    }else{
        _timetunningview = [[UIView alloc] initWithFrame:CGRectMake(30, 100, self.view.bounds.size.width - 60, self.view.bounds.size.height * 0.75)];
    }
    _timetunningview.backgroundColor = [UIColor whiteColor];
    _timetunningview.layer.masksToBounds = YES;
    _timetunningview.layer.masksToBounds = YES;
    _timetunningview.layer.cornerRadius = 4;
    [self.view addSubview:_timetunningview];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _timetunningview.bounds.size.width, _timetunningview.bounds.size.height)];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [_timetunningview addSubview:background];
    
    UIImageView *backgroundtop = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, _timetunningview.bounds.size.width - 20, 124)];
    backgroundtop.image = [UIImage imageNamed:@"zhuanjialiebiaorili_03"];
    backgroundtop.userInteractionEnabled = YES;
    [_timetunningview addSubview:backgroundtop];
    

    
}
//选择CELL上的button
-(void)choosetimemethd:(NSNotification *)notifier
{
    
    customerBeautifyLogData *zhaunjia = [_logDataarray objectAtIndex:[[notifier object] integerValue]];
    self.doctorSno = zhaunjia.DoctorSno;
    self.doctorname = zhaunjia.DoctorName;
    self.hostitalname = zhaunjia.HospitalName;
    self.hosptSno = zhaunjia.HospitalSno;
    self.beautifySno = zhaunjia.ProductSno;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *CommomUser = [user objectForKey:@"CommomUserORCommomDoctor"];
    
    if ([CommomUser isEqualToString:@"CommomUser"]) {
//        [self soaprequstWithcityCustomerSno:self.customerSno DoctorSno:self.doctorSno YearCount:[NSString stringWithFormat:@"%ld",self.year] MonthCount:[NSString stringWithFormat:@"%ld",self.month] DayCount:[NSString stringWithFormat:@"%ld",self.day]];
       // [self creatpickerviewandbackgruond];
        
        Detailsproject2 *proj = [[Detailsproject2 alloc] init];
        proj.sno = zhaunjia.ProductSno;
        proj.EnumName = zhaunjia.ProName;
        proj.doctorSno = self.doctorSno;
        proj.customerSno = self.customersno;
        proj.hostitalname = self.hostitalname;
        proj.doctorname = self.doctorname;
        [self.navigationController pushViewController:proj animated:YES];
        
    }else{
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请登录会员账号！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertview show];
    }

}
-(void)imagebuttonclick:(NSNotification *)notifier
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
        _imagetunningview = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width , self.view.bounds.size.width)];
        _imagetunningview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_imagetunningview];
    }
    
    UIScrollView *imagescrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 100)];
    imagescrollview.contentSize = CGSizeMake((picstrarray.count + 1) * self.view.bounds.size.width, 0);
    imagescrollview.contentOffset = CGPointMake(self.view.bounds.size.width * ([indexpathpistr integerValue] - 10), 0);
    imagescrollview.pagingEnabled = YES;
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
            
            NSLog(@"scrollimagev2.image.size.height{%f",scrollimagev2.image.size.height);
            
            scrollimagev2.frame = CGRectMake(self.view.bounds.size.width * i + self.view.bounds.size.width, 0, self.view.bounds.size.width, scrollimagev2.image.size.height/(scrollimagev2.image.size.width/self.view.bounds.size.width));
            
        }];
        scrollimagev2.userInteractionEnabled = YES;
        [imagescrollview addSubview:scrollimagev2];
        
        UIButton *scrollimagev = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i + self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
       // [scrollimagev sd_setBackgroundImageWithURL:[NSURL URLWithString:[picstrarray objectAtIndex:i]] forState:UIControlStateNormal];
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

-(void)creattimeButton
{
    
    NSMutableArray *hasmake = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (YuYueShiJianBiaoShuJu *yuyue in _yuyueRetary) {
        if (yuyue.MinuteCount.length <= 1) {
            yuyue.MinuteCount = @"00";
        }
        
        NSString *hasmakestr = [NSString stringWithFormat:@"%@:%@",yuyue.HourCount,yuyue.MinuteCount];
        [hasmake addObject:hasmakestr];
        NSLog(@"已经被预约的时间：%@",hasmakestr);
    }
    
    //请求过来的全部时间
    NSMutableArray *timeary = [[NSMutableArray alloc] initWithCapacity:0];
    for (YuYueShiJianBiaoShuJu *yuyue in _timeDataary) {
        if ([yuyue.MinuteCount isEqualToString:@"0"]) {
            yuyue.MinuteCount = @"00";
        }
        NSString *buttontitle = [NSString stringWithFormat:@"%@:%@",yuyue.HourCount,yuyue.MinuteCount];
        [timeary addObject:buttontitle];
        
    }
    
    //关闭按钮
    UIButton *off = [[UIButton alloc] initWithFrame:CGRectMake(5,5,35,35)];
    [off setBackgroundImage:[UIImage imageNamed:@"c"] forState:UIControlStateNormal];
    [off addTarget:self action:@selector(timeoffbuttunclick) forControlEvents:UIControlEventTouchUpInside];
    [_timetunningview addSubview:off];
    
    UIButton *go = [[UIButton alloc] initWithFrame:CGRectMake(_timetunningview.bounds.size.width - 40, 5, 35, 35)];
    [go setBackgroundImage:[UIImage imageNamed:@"g"] forState:UIControlStateNormal];
    [go addTarget:self action:@selector(gogogog) forControlEvents:UIControlEventTouchUpInside];
    [_timetunningview addSubview:go];
    
    wview = [[UIView alloc] initWithFrame:CGRectMake(5, 120, _timetunningview.bounds.size.width - 10, _timetunningview.bounds.size.height - 125)];
    wview.backgroundColor = [UIColor whiteColor];
    [_timetunningview addSubview:wview];
    
    for (int a = 0; a < timeary.count; a++) {
        
        int xn = a % 5;
        int yn = a / 5;
        float width = (wview.bounds.size.width - (5 * 6))/5;
        float heiht = width;
        int x = (5 + width) * xn + 5;
        int y = (5 + heiht) * yn + 5;
        
        mybutton *button = [[mybutton alloc] initWithFrame:CGRectMake(x, y, width, heiht)];
        button.titleEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
        [button addTarget:self action:@selector(timeButtonClicks:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitle:[timeary objectAtIndex:a] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"专家列表_03"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"专家列表_07"] forState:UIControlStateHighlighted];
        button.tag = 200 + a;
        [wview addSubview:button];
    }
    
    for (int a = 0; a < timeary.count; a++) {
        
        mybutton *btn = (mybutton *)[wview viewWithTag:a + 200];
        NSString *btntitle = [btn currentTitle];
        
        for (NSString *str in hasmake) {
            
            if ([str isEqualToString:btntitle]) {
                [btn setTitle:str forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"yiyuyue_03"] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            }
        }
    }
    
}
-(void)gogogog
{

    
    MakeAppointment *makeappoint = [[MakeAppointment alloc] init];
    makeappoint.proSno = self.beautifySno;
    makeappoint.date = self.dates;
    makeappoint.doctorSno = self.doctorSno;
    makeappoint.cusSno = self.customerSno;
    makeappoint.hospitalSno = self.hosptSno;
    makeappoint.PhoneNos = self.PhoneNo;
    makeappoint.doctornames = self.doctorname;
    makeappoint.TrueNames = self.TrueName;
    makeappoint.hostitalname = self.hostitalname;
    makeappoint.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:makeappoint animated:YES];
    [self timeoffbuttunclick];
    
}

-(void)timeButtonClicks:(mybutton *)button
{
    if (self.buttonindex > 199) {
        mybutton *btn = (mybutton *)[wview viewWithTag:self.buttonindex];
        [btn setBackgroundImage:[UIImage imageNamed:@"专家列表_03"] forState:UIControlStateNormal];
    }
    
    NSString *title = [button currentTitle];
    if (button.isclick == YES) {
        [button setBackgroundImage:[UIImage imageNamed:@"专家列表_03"] forState:UIControlStateNormal];
        button.isclick = NO;
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"专家列表_07"] forState:UIControlStateNormal];
        button.isclick = YES;
    }
    
    self.dates = [NSString stringWithFormat:@"%ld-%ld-%ld %@",self.year,self.month,self.day,title];
    
    self.buttonindex = button.tag;
    
}

//关闭按钮
-(void)timeoffbuttunclick
{
    NSLog(@"关闭");
    [_timebackview removeFromSuperview];
    _timebackview = nil;
    [_timetunningview removeFromSuperview];
    _timetunningview = nil;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark-------UICOllerctionView
-(void)creatcollerctionview
{

    gerenzujiViewLayout *layout;
    if (!layout) {
        layout = [[gerenzujiViewLayout alloc]init];
        layout.hightarray = _contentshightarray;//给它一个高度数组
    }

    layout.hightarray = _contentshightarray;//给它一个高度数组
    
    

    if (!_clView) {
     _clView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64, self.view.bounds.size.width, self.view.bounds.size.height - 64)collectionViewLayout:layout];
        _clView.backgroundColor = [UIColor clearColor];
        [_clView registerClass:[gerenzujiCollectionViewCell class] forCellWithReuseIdentifier:identifier];
        _clView.dataSource = self;
        _clView.delegate   = self;
        _clView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_clView];
    }
    
   
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
    
    cell.myweillmake.frame = CGRectMake(self.view.bounds.size.width - 80,  hight + 45, 15, 15);
    cell.mywillmake.frame = CGRectMake(self.view.bounds.size.width - 80, hight + 38, 80, 30);
    
    cell.Contents.text = customer.Contents;
    cell.Contents.alpha = 0.75;
    cell.Contents.font = [UIFont systemFontOfSize:13];
    cell.Contents.frame = CGRectMake(10, hight + 38 + 30,cell.bounds.size.width - 20 ,[self contentsWithnsstringcell:customer.Contents]);
    [self jianjucontentLabel:cell.Contents];
    
    cell.pinglun.frame = CGRectMake(25, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 8, 20, 15);
    
    cell.DiscussCount.text = customer.DiscussCount;
    cell.DiscussCount.frame = CGRectMake(40 + 10, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 5, 100, 20);
    
    cell.liulan.frame = CGRectMake(135, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 8, 22, 20);
    
    cell.ClickCount.text = customer.ClickCount;
    cell.ClickCount.frame = CGRectMake(160, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 5, 100, 20);

    cell.pinglunbuttonimage.frame = CGRectMake(cell.bounds.size.width - 85, cell.Contents.frame.origin.y + cell.Contents.frame.size.height + 6, 18, 15);
    
    cell.button.frame = CGRectMake(cell.bounds.size.width - 80, cell.Contents.frame.origin.y + cell.Contents.frame.size.height, 60, 25);
    
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
    
    NSLog(@"self.pinglunARRAYary-1---%ld",self.pinglunARRAYary.count);
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}
-(void)reloaddata
{
   [self soaprequestwithcustomerSno:self.customersno strPageindex:@"1" strPagesize:@"50"];
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

//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 10,6000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstringcell:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 50,6000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}
//评论的字号
-(CGFloat)contentsWithPinglunnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 100,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}
#pragma mark---- SOAP请求
//获取指定客户的美容日志数据
-(void)soaprequestwithcustomerSno:(NSString *)customerSno  strPageindex:(NSString *)strPageindex  strPagesize:(NSString *)strPagesize
{
   
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetCustomerBeautifyLogData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetCustomerBeautifyLogData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,strPageindex,strPagesize];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetCustomerBeautifyLogData" forHTTPHeaderField:@"SOAPAction"];
    
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
//提交客户美容日志评论
-(void)soaprequestwithcustomerSno:(NSString *)customerSno  logSno:(NSString *)logSno  contents:(NSString *)contents
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<AddLogDiscussData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<logSno>%@</logSno>\n"
                             "<contents>%@</contents>\n"
                             "</AddLogDiscussData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,logSno,contents];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/AddLogDiscussData" forHTTPHeaderField:@"SOAPAction"];
    
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
//预约请求
-(void)soaprequstWithcityCustomerSno:(NSString *)customerSno DoctorSno:(NSString *)doctorSno YearCount:(NSString *)yearCount MonthCount:(NSString *)monthCount DayCount:(NSString *)dayCount
{
    NSLog(@"UID:%@--PSW:%@--customerSno:%@---doctorSno:%@---yearCount:%@---monthCount:%@---dayCount:%@",UID,PSW,customerSno,doctorSno,yearCount,monthCount,dayCount);
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorTimeSetBySno xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<yearCount>%@</yearCount>\n"
                             "<monthCount>%@</monthCount>\n"
                             "<dayCount>%@</dayCount>\n"
                             "</GetDoctorTimeSetBySno>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,doctorSno,yearCount,monthCount,dayCount];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorTimeSetBySno" forHTTPHeaderField:@"SOAPAction"];
    
    
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
        NSLog(@"美容足迹--%@",theXML);
    
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

    
    if ([elementName isEqualToString:@"GetCustomerBeautifyLogDataResult"]) {
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    
    if ([elementName isEqualToString:@"AddLogDiscussDataResult"]) {//开始评论
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"GetDoctorTimeSetBySnoResult"]) {
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

    if ([elementName isEqualToString:@"GetCustomerBeautifyLogDataResult"]) {//获取本页信息
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"美容足迹的个人中心的数据:%@",dic);

        NSMutableArray *logData = [dic objectForKey:@"customerBeautifyLogData"];
        
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

             [_contentshightarray addObject:[NSString stringWithFormat:@"%f",a + hight + b]];//内容的高度 + 评论的高度 + 图片的高度
            
        }

       [self creatcollerctionview];
       
         [_clView reloadData];
    }
    
    if ([elementName isEqualToString:@"AddLogDiscussDataResult"]) {//添加评论信息
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"评论的数据:%@",dic);
        NSString *state = [dic objectForKey:@"state"];
        
        NSLog(@"评论返回来的消息: %@",[dic objectForKey:@"msg"]);
        
        if ([state isEqualToString:@"1"]) {
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"操作成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [al show];
            
            [_logDataarray removeAllObjects];
            [self.pinglunARRAYary removeAllObjects];
            [_contentshightarray removeAllObjects];
            
             [self reloaddata];
        }
       
    }
    
    
    if ([elementName isEqualToString:@"GetDoctorTimeSetBySnoResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"预约的时间表数据:%@",dic);
        
        NSMutableArray *ret = [dic objectForKey:@"ret"];
        _yuyueRetary = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[dic objectForKey:@"state"] isEqualToString:@"1"]) {
            
            for (NSDictionary *diction in ret) {
                YuYueShiJianBiaoShuJu *yuyue = [YuYueShiJianBiaoShuJu yuyuewithNsdictionary:diction];
                [_yuyueRetary addObject:yuyue];
            }
        }
        
        NSMutableArray *timeData = [dic objectForKey:@"timeData"];
        _timeDataary = [[NSMutableArray alloc] initWithCapacity:0];
        if ([[dic objectForKey:@"state"] isEqualToString:@"1"]) {
            
            for (NSDictionary *diction in timeData) {
                YuYueShiJianBiaoShuJu *yuyue = [YuYueShiJianBiaoShuJu yuyuewithNsdictionary:diction];
                [_timeDataary addObject:yuyue];
            }
            [self creattimeButton];
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
