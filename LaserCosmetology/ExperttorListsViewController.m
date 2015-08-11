//
//  ExperttorListsViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "ExperttorListsViewController.h"
#import "TopBarView.h"
#import "mybutton.h"
#import "MakeAppointment.h"
#import "experlistCell.h"
#import "zhuanjialiebiao.h"
#import "discount.h"
#import "UIImageView+WebCache.h"
#import "YuYueShiJianBiaoShuJu.h"
#import "yuyuexiandeqingqiu.h"
#import "PrefixHeader.pch"
#import "mybutton.h"

@interface ExperttorListsViewController ()

@end

@implementation ExperttorListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
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
   
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSDictionary *citydic = [userDefaultes objectForKey:@"citydiction"];
    self.city = [citydic objectForKey:@"cityname"];
    self.cityno = [citydic objectForKey:@"cityno"];

    if (self.cityno == nil) {
        self.city =@"";
        
    }
    if (self.cityno == nil) {
        self.cityno = @"";
    }
    
    [self soaprequstWithcityName:self.city CityNo:self.cityno BeautifyProSno:self.beautifySno SortFile:self.SortFile OrderType:@"desc" IsGetRuleData:@"1"];
    
    NSLog(@"AAA---%@;%@;%@;%@;%@;%@",self.city,self.cityno,self.beautifySno,@"",@"desc",@"1");
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"专家列表";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    

    NSArray *btntitle = [[NSArray alloc] initWithObjects:@"城市",@"服务人数",@"评价",nil];
    float btnwidth = (self.view.bounds.size.width - 25)/3;
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((5 + btnwidth) * i + 5, 75, btnwidth, 30)];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:[btntitle objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
//        [btn setBackgroundImage:[UIImage imageNamed:@"meirongzhuanjia_0303"] forState:UIControlStateNormal];
//        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn addTarget:self action:@selector(shoosetypeclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 20 + i;
        [self.view addSubview:btn];
    }
    
    UIImageView *bar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, 3)];
    bar.image = [UIImage imageNamed:@"hengxian"];
    [self.view addSubview:bar];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 115 - 65, self.view.bounds.size.width, self.view.bounds.size.height - 64 + 115 - 65 - 80)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.tag = 30;
    [self.view addSubview:_tableview];
    
    
    NSUserDefaults *usedf = [NSUserDefaults standardUserDefaults];
    self.customerSno = [usedf objectForKey:@"customerSno"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choosetimemeth:) name:@"choosetime" object:nil];
    
    _monaay = [[NSArray alloc] initWithObjects:@"01",@"02", @"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil];
    
   
    
    [self creatcitytableview];
}

-(void)creatcitytableview
{
     float btnwidth = (self.view.bounds.size.width - 25)/3;

    _citytaarraybackimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 105, btnwidth, 0)];
    _citytaarraybackimage.image = [UIImage imageNamed:@"xiaoliebiaohuisedi"];
    [self.view addSubview:_citytaarraybackimage];
    
    _citytaarraybleview = [[UITableView alloc] initWithFrame:CGRectMake(5, 105, btnwidth, 0)];
    _citytaarraybleview.delegate = self;
    _citytaarraybleview.dataSource = self;
    _citytaarraybleview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _citytaarraybleview.backgroundColor = [UIColor clearColor];
    _citytaarraybleview.tag = 31;
    [self.view addSubview:_citytaarraybleview];
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
        return [_monaay objectAtIndex:row];
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
  
        [self soaprequstWithcityCustomerSno:self.customerSno DoctorSno:self.doctorSno YearCount:[NSString stringWithFormat:@"%ld",self.year] MonthCount:[NSString stringWithFormat:@"%ld",self.month] DayCount:[NSString stringWithFormat:@"%ld",self.day]];

}

#pragma mark --UItaBleview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 30) {
        
        return _retaray.count;
    }else{
        return _cityTypeDataarray.count;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 30) {
      
        static NSString *identifier = @"cell";
        experlistCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[experlistCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        zhuanjialiebiao *zhuanjia = [_retaray objectAtIndex:indexPath.row];
        [cell.headimage sd_setImageWithURL:[NSURL URLWithString:zhuanjia.PicSrc]];
        cell.shanchang.text = zhuanjia.BestInfo;
        cell.name.text = zhuanjia.TrueName;
        cell.fuwurenshu.text = zhuanjia.BookCount;
        cell.fuwurenshu.frame = CGRectMake(cell.fuwu.frame.origin.x + [self NSStringwithsize:15 str:cell.fuwu.text], cell.fuwu.frame.origin.y, [self NSStringwithsize:15 str:cell.fuwurenshu.text], 20);
        cell.feiyong.text = zhuanjia.CostFrom;
        cell.fuwuren.frame = CGRectMake(cell.fuwurenshu.frame.origin.x + [self NSStringwithsize:15 str:cell.fuwurenshu.text], cell.fuwurenshu.frame.origin.y, [self NSStringwithsize:17 str:@"人"], 20);
        
        cell.yuan.frame = CGRectMake(cell.feiyong.frame.origin.x + [self NSStringwithsize:14 str:cell.feiyong.text], cell.feiyong.frame.origin.y, [self NSStringwithsize:13 str:cell.yuan.text], 20);
        
        return cell;
        
    }else{
        
        static NSString *identifier = @"cell1";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        discount *dis = [_cityTypeDataarray objectAtIndex:indexPath.row];
        
        cell1.textLabel.text =dis.EnumName;
        cell1.textLabel.font = [UIFont systemFontOfSize:12];
        cell1.textLabel.textColor = [UIColor blackColor];
        
        return cell1;
    }
    
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 30) {
        return 120;
    }else{
    return 30;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (tableView.tag == 31) {
        
        discount *dis = [_cityTypeDataarray objectAtIndex:indexPath.row];
        UIButton *button = (UIButton *)[self.view viewWithTag:20];
        [button setTitle:dis.EnumName forState:UIControlStateNormal];
        self.shoosecity = dis.EnumName;
        self.shoosecityno = dis.EnumNo;
        self.city = dis.EnumName;
        self.cityno = dis.EnumNo;
        
        _citytaarraybleview.frame = CGRectMake(_citytaarraybleview.frame.origin.x, _citytaarraybleview.frame.origin.y, _citytaarraybleview.frame.size.width,0);
        self.iscitytableview = NO;
        
        _citytaarraybackimage.frame = CGRectMake(_citytaarraybleview.frame.origin.x, _citytaarraybleview.frame.origin.y, _citytaarraybleview.frame.size.width,0);
        
        [self soaprequstWithcityName:self.shoosecity CityNo:self.shoosecityno BeautifyProSno:self.beautifySno SortFile:@"" OrderType:@"desc" IsGetRuleData:@"1"];
    }
    
}

#pragma mark 按钮点击事件

//选择CELL上的button
-(void)choosetimemeth:(NSNotification *)notifier
{

    
    zhuanjialiebiao *zhaunjia = [_retaray objectAtIndex:[[notifier object] integerValue]];
    self.doctorSno = zhaunjia.Sno;
    self.doctorname = zhaunjia.TrueName;
    self.hostitalname = zhaunjia.HospitalName;


    
    NSLog(@"self.customerSno：%@---self.doctorSno:%@---",self.customerSno,self.doctorSno);
    
    [self soaprequstWithcityCustomerSno:self.customerSno DoctorSno:self.doctorSno YearCount:[NSString stringWithFormat:@"%ld",self.year] MonthCount:[NSString stringWithFormat:@"%ld",self.month] DayCount:[NSString stringWithFormat:@"%ld",self.day]];
    
    [self soaprequsetGetBeforeBookDataWithdoctorSno:self.doctorSno proSno:self.beautifySno customerSno:self.customerSno];
    
    [self creatpickerviewandbackgruond];
}
-(void)creatpickerviewandbackgruond
{

    if (_backview) {
        
    }else{
    _backview = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    _backview = [[UIView alloc] initWithFrame:self.view.bounds];
    _backview.backgroundColor = [UIColor blackColor];
    _backview.alpha = 0.6;
    _backview.layer.masksToBounds = YES;
    _backview.layer.cornerRadius = 4;
    [self.view addSubview:_backview];
    
    if (_tunningview) {
    }else{
        _tunningview = [[UIView alloc] initWithFrame:CGRectMake(30, 100, self.view.bounds.size.width - 60, self.view.bounds.size.height * 0.75)];
    }
    _tunningview.backgroundColor = [UIColor whiteColor];
    _tunningview.layer.masksToBounds = YES;
    _tunningview.layer.masksToBounds = YES;
    _tunningview.layer.cornerRadius = 4;
    [self.view addSubview:_tunningview];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _tunningview.bounds.size.width, _tunningview.bounds.size.height)];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [_tunningview addSubview:background];
    
    UIImageView *backgroundtop = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, _tunningview.bounds.size.width - 20, 124)];
    backgroundtop.image = [UIImage imageNamed:@"zhuanjialiebiaorili_03"];
    backgroundtop.userInteractionEnabled = YES;
    [_tunningview addSubview:backgroundtop];
    
    if (self.pickerview) {
    }else{
    self.pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(48, -15, background.bounds.size.width-80, 20)];
    }
    
    self.pickerview.backgroundColor = [UIColor clearColor];
    self.pickerview.dataSource = self;
    self.pickerview.delegate = self;
    [_tunningview addSubview:self.pickerview];
    
    [self.pickerview selectRow:self.month-1 inComponent:0 animated:YES];
    [self.pickerview selectRow:self.day-1 inComponent:2 animated:YES];
    
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
    [off addTarget:self action:@selector(offbuttunclick) forControlEvents:UIControlEventTouchUpInside];
    [_tunningview addSubview:off];
    
    UIButton *go = [[UIButton alloc] initWithFrame:CGRectMake(_tunningview.bounds.size.width - 40, 5, 35, 35)];
    [go setBackgroundImage:[UIImage imageNamed:@"g"] forState:UIControlStateNormal];
    [go addTarget:self action:@selector(gogogog) forControlEvents:UIControlEventTouchUpInside];
    [_tunningview addSubview:go];
    
    wview = [[UIView alloc] initWithFrame:CGRectMake(5, 120, _tunningview.bounds.size.width - 10, _tunningview.bounds.size.height - 125)];
    wview.backgroundColor = [UIColor whiteColor];
    [_tunningview addSubview:wview];
    
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
     [self offbuttunclick];
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
-(void)offbuttunclick
{
    NSLog(@"关闭");
    [_backview removeFromSuperview];
    _backview = nil;
    [_tunningview removeFromSuperview];
    _tunningview = nil;
    
}

-(void)shoosetypeclick:(UIButton *)btn
{
    if (btn.tag == 20) {
        
        if (self.iscitytableview == NO) {
            _citytaarraybleview.frame = CGRectMake(_citytaarraybleview.frame.origin.x, _citytaarraybleview.frame.origin.y, _citytaarraybleview.frame.size.width, 100);
            
            _citytaarraybackimage.frame = CGRectMake(_citytaarraybleview.frame.origin.x, _citytaarraybleview.frame.origin.y, _citytaarraybleview.frame.size.width, 100);
            
            self.iscitytableview = YES;
        }else{
            
            _citytaarraybleview.frame = CGRectMake(_citytaarraybleview.frame.origin.x, _citytaarraybleview.frame.origin.y, _citytaarraybleview.frame.size.width,0);
            self.iscitytableview = NO;
            
            _citytaarraybackimage.frame = CGRectMake(_citytaarraybleview.frame.origin.x, _citytaarraybleview.frame.origin.y, _citytaarraybleview.frame.size.width,0);
        }
    }else if(btn.tag == 21){
        
    self.SortFile = @"BookCount";//服务人数
    
            [self soaprequstWithcityName:self.city CityNo:self.cityno BeautifyProSno:self.beautifySno SortFile:self.SortFile OrderType:@"desc" IsGetRuleData:@"1"];
    }else{
        
        self.SortFile = @"EvaluateCount";//评价
        
            [self soaprequstWithcityName:self.city CityNo:self.cityno BeautifyProSno:self.beautifySno SortFile:self.SortFile OrderType:@"desc" IsGetRuleData:@"1"];
    }
    

}

-(void)backbuttonclick
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
#pragma mark--soap请求
//预约之前获取的数据
-(void)soaprequsetGetBeforeBookDataWithdoctorSno:(NSString *)doctorSno proSno:(NSString *)proSno customerSno:(NSString *)customerSno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetBeforeBookData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<proSno>%@</proSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "</GetBeforeBookData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,proSno,customerSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetBeforeBookData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//获取专家列表信息
-(void)soaprequstWithcityName:(NSString *)city CityNo:(NSString *)cityNo BeautifyProSno:(NSString *)beautifyProSno SortFile:(NSString *)sortFile OrderType:(NSString *)orderType IsGetRuleData:(NSString *)isGetRuleData
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorByCityAndPro xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<cityName>%@</cityName>\n"
                             "<cityTypeNo>%@</cityTypeNo>\n"
                             "<beautifyProSno>%@</beautifyProSno>\n"
                             "<sortFile>%@</sortFile>\n"
                             "<orderType>%@</orderType>\n"
                             "<isGetRuleData>%@</isGetRuleData>\n"
                             "</GetDoctorByCityAndPro>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,city,cityNo,beautifyProSno,sortFile,orderType,isGetRuleData];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorByCityAndPro" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"专家列表时间数据theXML-%@",theXML);
    
    //NSString *str = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    
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
    
    
    
    
    if ([elementName isEqualToString:@"GetDoctorByCityAndProResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
        
    }
    
    if ([elementName isEqualToString:@"GetDoctorTimeSetBySnoResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
        
    }
    
    if ([elementName isEqualToString:@"GetBeforeBookDataResult"]) {//预约前的请求
        
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
    
    
    if ([elementName isEqualToString:@"GetDoctorByCityAndProResult"]) {
        // NSLog(@"-_soapResults-%@",_soapResults);
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"是否有城市的数据:%@",dic);
        
        NSMutableArray *retmutable = [dic objectForKey:@"ret"];
       _retaray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *retdic in retmutable) {
            zhuanjialiebiao *zhuanjia = [zhuanjialiebiao zhuanjialiebiaoWithdiction:retdic];
            [_retaray addObject:zhuanjia];
        }
        [_tableview reloadData];
        
        NSMutableArray *cityTypeData = [dic objectForKey:@"cityTypeData"];
        _cityTypeDataarray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *retdic in cityTypeData) {
            discount *disc = [discount PicSrcwithdictionary:retdic];
            [_cityTypeDataarray addObject:disc];
        }
        [_citytaarraybleview reloadData];
        
    }
    
    if ([elementName isEqualToString:@"GetDoctorTimeSetBySnoResult"]) {
        // NSLog(@"-_soapResults-%@",_soapResults);
        
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

    if ([elementName isEqualToString:@"GetBeforeBookDataResult"]) {
        // NSLog(@"-_soapResults-%@",_soapResults);
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"预约之前请求数据:%@",dic);
        NSMutableArray *DoctorProData = [dic objectForKey:@"DoctorProData"];
        _yuyuexianDoctorProData = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in DoctorProData) {
            yuyuexiandeqingqiu *yuyuexian = [yuyuexiandeqingqiu yuyuexiandeshujuWithdiction:diction];
            [_yuyuexianDoctorProData addObject:yuyuexian];
        }
        
        NSMutableArray *carData = [dic objectForKey:@"carData"];
        _yuyuexiancarData = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in carData) {
            yuyuexiandeqingqiu *yuyuexian = [yuyuexiandeqingqiu yuyuexiandeshujuWithdiction:diction];
            [_yuyuexiancarData addObject:yuyuexian];
        }

        NSMutableArray *hospitalDoctorRelateData = [dic objectForKey:@"hospitalDoctorRelateData"];
        _yuyuexianhospitalDoctorRelateData = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in hospitalDoctorRelateData) {
            yuyuexiandeqingqiu *yuyuexian = [yuyuexiandeqingqiu yuyuexiandeshujuWithdiction:diction];
            [_yuyuexianhospitalDoctorRelateData addObject:yuyuexian];
            
            self.hosptSno = yuyuexian.HospitalSno;
            self.hostitalname = yuyuexian.HospitalName;
            self.doctorname = yuyuexian.DoctorName;
        }
        
        NSMutableArray *customerData = [dic objectForKey:@"customerData"];
        _yuyuexiancustomerData = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in customerData) {
            yuyuexiandeqingqiu *yuyuexian = [yuyuexiandeqingqiu yuyuexiandeshujuWithdiction:diction];
            [_yuyuexiancustomerData addObject:yuyuexian];
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
