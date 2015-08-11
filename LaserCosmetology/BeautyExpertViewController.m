//
//  BeautyExpertViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "BeautyExpertViewController.h"
#import "TopBarView.h"
#import "BottomBarView.h"
#import "BeautyExpert.h"
#import "StarBeauticianViewController.h"
#import "contentViewCell.h"
#import "discount.h"
#import "HuQiJingsharManage.h"
#import "meirongzhuanjia.h"
#import "UIImageView+WebCache.h"
#import "MainViewController.h"
#import "NewExpertViewController.h"
#import "PrefixHeader.pch"
@interface BeautyExpertViewController ()


@end

@implementation BeautyExpertViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *ishaver = [def objectForKey:@"ishaver"];

     float botomerhight = 0.130667 * self.view.bounds.size.width;
    NSLog(@"---个人中心ishaver-%@",ishaver);
    
    float x = self.view.bounds.size.width/5;//推送红点
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
    titilelable.text = @"美容专家";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    

    
    
    //------------------------------
    
    
    NSArray *btntitle = [[NSArray alloc] initWithObjects:@"      城市",@"  全部项目",@"      排序", nil];
    float btnwidth = (self.view.bounds.size.width - 20)/3;
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((5 + btnwidth) * i + 5, 75, btnwidth, 30)];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:[btntitle objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[self colorWithRGB:0x999999 alpha:1] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"meirongzhuanjia_0303"] forState:UIControlStateNormal];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn addTarget:self action:@selector(btnclickcreattableAMG:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 20 + i;
        [self.view addSubview:btn];
    }
    
    float botomerhight = 0.130667 * self.view.bounds.size.width;
    
    _contenttable = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height - 110 - botomerhight)];
    _contenttable.delegate = self;
    _contenttable.dataSource = self;
    _contenttable.showsVerticalScrollIndicator = NO;
    _contenttable.tag = 28;
    _contenttable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contenttable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contenttable];
    
    _citytaarraybackimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 105, btnwidth, 0)];
    _citytaarraybackimage.image = [UIImage imageNamed:@"xiaoliebiaohuisedi"];
    [self.view addSubview:_citytaarraybackimage];
    
    citytablevi = [[UITableView alloc] initWithFrame:CGRectMake( 5, 105, btnwidth, 0)];
    citytablevi.delegate = self;
    citytablevi.dataSource = self;
    citytablevi.showsVerticalScrollIndicator = NO;
    citytablevi.tag = 24;
    citytablevi.backgroundColor = [UIColor clearColor];
    citytablevi.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:citytablevi];
    
    
    beautifyProductType = [[UITableView alloc] initWithFrame:CGRectMake( (5 + btnwidth) * 1 + 5, 105, btnwidth, 0)];
    beautifyProductType.delegate = self;
    beautifyProductType.dataSource = self;
    beautifyProductType.showsVerticalScrollIndicator = NO;
    beautifyProductType.tag = 25;
    beautifyProductType.backgroundColor = [UIColor clearColor];
    [self.view addSubview:beautifyProductType];
    

    
    self.sequence = [[NSArray alloc] initWithObjects:@"好评度",@"服务人数",@"不限", nil];
    tablevi4 = [[UITableView alloc] initWithFrame:CGRectMake( (5 + btnwidth) * 2 + 5, 105, btnwidth, 0)];
    tablevi4.delegate = self;
    tablevi4.dataSource = self;
    tablevi4.showsVerticalScrollIndicator = NO;
    tablevi4.tag = 26;
    tablevi4.backgroundColor = [UIColor clearColor];
    tablevi4.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tablevi4];
    
    
    //------------------------------
    
    [[HuQiJingsharManage shareManage] addObserver:self forKeyPath:@"changecity" options:NSKeyValueObservingOptionNew context:nil];
    
    self.cityname = @"";
    self.cityno = @"";
    self.hotno = @"";
    self.beautyno = @"";
    self.SortFile = @"";
    
    [self soaprequstWithCiTyName:@"" AndcityTypeNo:@"" HospiTalLevel:@"" BeautifyProType:@"" SortFile:@"" OrderType:@"" IsGetRuleData:@"1"];
    
    _refreshControl=[[RefreshControl alloc] initWithScrollView:_contenttable delegate:self];
    _refreshControl.topEnabled=YES;
    //_refreshControl.bottomEnabled=YES;//会崩
    
    
    UIImageView *tabBarimage = [[UIImageView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - botomerhight, self.view.bounds.size.width, botomerhight)];
    tabBarimage.image = [UIImage imageNamed:@"首页1_03ss"];
    [self.view addSubview:tabBarimage];
    
    BottomBarView *botom = [[BottomBarView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - botomerhight, self.view.bounds.size.width, botomerhight)];
    [self.view addSubview:botom];


}


- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    
    if (direction==RefreshDirectionTop)
    {
        NSLog(@"下拉刷新");
        [self soaprequstWithCiTyName:@"" AndcityTypeNo:@"" HospiTalLevel:@"" BeautifyProType:@"" SortFile:@"" OrderType:@"" IsGetRuleData:@"1"];
        
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


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
     discount *discciti = [change objectForKey:@"new"];
    NSLog(@"------城市改变了，变成：%@,编号：%@",discciti.EnumName,discciti.EnumNo);

}
#pragma mark-  按钮的点击事件
//选择的按钮键
-(void)btnclickcreattableAMG:(UIButton *)button
{
    

    
    if (self.isbtnclick != button.tag) {
        
        if (button.tag == 20) {
            _citytaarraybackimage.frame = CGRectMake(citytablevi.frame.origin.x, citytablevi.frame.origin.y, citytablevi.frame.size.width,40 * 3);
            citytablevi.frame = CGRectMake(citytablevi.frame.origin.x, citytablevi.frame.origin.y, citytablevi.frame.size.width,40 * 3);
            beautifyProductType.frame = CGRectMake(beautifyProductType.frame.origin.x, beautifyProductType.frame.origin.y, beautifyProductType.frame.size.width,0);
            tablevi4.frame = CGRectMake(tablevi4.frame.origin.x, tablevi4.frame.origin.y, tablevi4.frame.size.width,0);
            
        }else if (button.tag == 21){
            _citytaarraybackimage.frame = CGRectMake(0, beautifyProductType.frame.origin.y, self.view.bounds.size.width,self.view.bounds.size.height - beautifyProductType.frame.origin.y - 49);
            citytablevi.frame = CGRectMake(citytablevi.frame.origin.x, citytablevi.frame.origin.y, citytablevi.frame.size.width,0);
            beautifyProductType.frame = CGRectMake(0, beautifyProductType.frame.origin.y, self.view.bounds.size.width,self.view.bounds.size.height - beautifyProductType.frame.origin.y - 49);
            tablevi4.frame = CGRectMake(tablevi4.frame.origin.x, tablevi4.frame.origin.y, tablevi4.frame.size.width,0);
        }
        else{
            _citytaarraybackimage.frame = CGRectMake(tablevi4.frame.origin.x, tablevi4.frame.origin.y, tablevi4.frame.size.width,40 * 3);
            citytablevi.frame = CGRectMake(citytablevi.frame.origin.x, citytablevi.frame.origin.y, citytablevi.frame.size.width,0);
            beautifyProductType.frame = CGRectMake(beautifyProductType.frame.origin.x, beautifyProductType.frame.origin.y, beautifyProductType.frame.size.width,0);
            tablevi4.frame = CGRectMake(tablevi4.frame.origin.x, tablevi4.frame.origin.y, tablevi4.frame.size.width,40 * 3);
        }

         self.isbtnclick = button.tag;
    }else{
         _citytaarraybackimage.frame = CGRectMake(0, 0, 0, 0);
        
        UITableView *tablev = (UITableView *)[self.view viewWithTag:button.tag + 4];
        tablev.frame = CGRectMake(tablev.frame.origin.x, tablev.frame.origin.y, tablev.frame.size.width,0);
        self.isbtnclick = 0;
    }
    
 

    
    
}

-(void)expertbtnclick
{
//    StarBeauticianViewController *StarBeautician = [[StarBeauticianViewController alloc] init];
//    StarBeautician.sno = self.zhuanjiaSno;
//    StarBeautician.doctorname = self.TrueName;
//    StarBeautician.hospitolname = self.hospitolname;
//    StarBeautician.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:StarBeautician animated:YES];

    NewExpertViewController *expert = [[NewExpertViewController alloc] init];
    expert.doctorsno = self.zhuanjiaSno;
    [self.navigationController pushViewController:expert animated:YES];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 28) {
        return _meirongzhuanjia.count;
    }else if(tableView.tag == 24){
        return self.cityTypeDataAry.count + 1;
    }else if(tableView.tag == 25){
        return _beautifyProductTypeDataary.count + 1;
    }else if(tableView.tag == 26){
        return _beautifyProductTypeDataary.count + 1;
    }else{
        return self.sequence.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 28) {
        static NSString *identifier = @"contentCell";
        contentViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!contentCell) {
            contentCell = [[contentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        meirongzhuanjia *meirong = [_meirongzhuanjia objectAtIndex:indexPath.row];
        
        contentCell.backgroudimage.frame = CGRectMake(0, 0, self.view.bounds.size.width, 133);
        
        [contentCell.headimage sd_setImageWithURL:[NSURL URLWithString:meirong.PicSrc]];
        contentCell.headimage.layer.masksToBounds = YES;
        contentCell.headimage.layer.cornerRadius = contentCell.headimage.frame.size.width/2;
        
        contentCell.peoplename.text = meirong.TrueName;
        
        contentCell.fuwu.frame = CGRectMake(self.view.bounds.size.width - 80, 10, 60, 20);
        contentCell.servernumber.text = meirong.BookCount;//服务人数
        contentCell.servernumber.frame = CGRectMake(self.view.bounds.size.width - 50, 10, [self NSStringwithsize:13 str:meirong.BookCount], 20);
        
        contentCell.people.frame = CGRectMake(contentCell.servernumber.frame.origin.x + [self NSStringwithsize:13 str:contentCell.servernumber.text], 10,[self NSStringwithsize:13 str:contentCell.people.text] , 20);

        contentCell.postname.frame = CGRectMake(125, 40, [self NSStringwithsize:14 str:meirong.PostName], 20);
        contentCell.postname.text = meirong.PostName;
        

        
        contentCell.begoodat.frame = CGRectMake(contentCell.headimage.frame.size.width + 25, 100, 40, 20);
        
        contentCell.begoodatto1.text = meirong.BestInfo;//擅长
        contentCell.begoodatto1.frame = CGRectMake(contentCell.headimage.frame.size.width + 25 + 35, 100, [self NSStringwithsize:12 str:meirong.BestInfo], 20);
        
         

        contentCell.judgeimage1.frame = CGRectMake(0,0, 0, 0);
        contentCell.judgeimage1.image = [UIImage imageNamed:@""];
        contentCell.judgeimage2.frame = CGRectMake(0,0, 0, 0);
        contentCell.judgeimage2.image = [UIImage imageNamed:@""];
        contentCell.judgeimage3.frame = CGRectMake(0,0, 0, 0);
        contentCell.judgeimage3.image = [UIImage imageNamed:@""];
        contentCell.judgeimage4.frame = CGRectMake(0,0, 0, 0);
        contentCell.judgeimage4.image = [UIImage imageNamed:@""];
        contentCell.judgeimage5.frame = CGRectMake(0,0, 0, 0);
        contentCell.judgeimage5.image = [UIImage imageNamed:@""];

        if ([meirong.EvaluateCount isEqualToString:@"1"]) {
           contentCell.judgeimage1.frame = CGRectMake(135 + [self NSStringwithsize:16 str:meirong.TrueName],10, 15, 15);
            contentCell.judgeimage1.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
        }else if ([meirong.EvaluateCount isEqualToString:@"2"]){
            contentCell.judgeimage1.frame = CGRectMake(135 + [self NSStringwithsize:16 str:meirong.TrueName],10, 15, 15);
            contentCell.judgeimage1.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
            contentCell.judgeimage2.frame = CGRectMake(contentCell.judgeimage1.frame.origin.x  + 20,10, 15, 15);
            contentCell.judgeimage2.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
        }else if ([meirong.EvaluateCount isEqualToString:@"3"]){
            contentCell.judgeimage1.frame = CGRectMake(135 + [self NSStringwithsize:16 str:meirong.TrueName],10, 15, 15);
            contentCell.judgeimage1.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
            contentCell.judgeimage2.frame = CGRectMake(contentCell.judgeimage1.frame.origin.x  + 20,10, 15, 15);
            contentCell.judgeimage2.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
            contentCell.judgeimage3.frame = CGRectMake(contentCell.judgeimage2.frame.origin.x  + 20,10, 15, 15);
            contentCell.judgeimage3.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
        }else if ([meirong.EvaluateCount isEqualToString:@"4"]){
            contentCell.judgeimage1.frame = CGRectMake(135 + [self NSStringwithsize:16 str:meirong.TrueName],10, 15, 15);
            contentCell.judgeimage1.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
            contentCell.judgeimage2.frame = CGRectMake(contentCell.judgeimage1.frame.origin.x  + 20,10, 15, 15);
            contentCell.judgeimage2.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
            contentCell.judgeimage3.frame = CGRectMake(contentCell.judgeimage2.frame.origin.x  + 20,10, 15, 15);
            contentCell.judgeimage3.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
            contentCell.judgeimage4.frame = CGRectMake(contentCell.judgeimage3.frame.origin.x  + 20,10, 15, 15);
            contentCell.judgeimage1.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
        }else{
            contentCell.judgeimage1.frame = CGRectMake(135 + [self NSStringwithsize:16 str:meirong.TrueName],10, 15, 15);
            contentCell.judgeimage1.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
            contentCell.judgeimage2.frame = CGRectMake(contentCell.judgeimage1.frame.origin.x  + 20,10, 15, 15);
            contentCell.judgeimage2.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
            contentCell.judgeimage3.frame = CGRectMake(contentCell.judgeimage2.frame.origin.x  + 20,10, 15, 15);
            contentCell.judgeimage3.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
            contentCell.judgeimage4.frame = CGRectMake(contentCell.judgeimage3.frame.origin.x  + 20,10, 15, 15);
            contentCell.judgeimage4.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
           contentCell.judgeimage5.frame = CGRectMake(contentCell.judgeimage4.frame.origin.x  + 20,10, 15, 15);
            contentCell.judgeimage5.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
        }
        
        contentCell.hospitalname.text = meirong.HospitalName;
        contentCell.hospitalname.frame = CGRectMake(contentCell.headimage.frame.size.width + 25, 70, [self NSStringwithsize:15 str:meirong.HospitalName], 20);
        
        contentCell.backgroundColor = [UIColor clearColor];
        
        return contentCell;
        
        
    }else if(tableView.tag == 24){
        
        static NSString *identifier = @"citycell";
        UITableViewCell *citycell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!citycell) {
            citycell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        citycell.backgroundColor = [UIColor clearColor];
        if (indexPath.row == 0) {
            citycell.textLabel.text = @"全部";
            citycell.textLabel.font = [UIFont systemFontOfSize:16];
            citycell.textLabel.textColor = [self colorWithRGB:0x999999 alpha:1];
            
        }else{
            discount *dis = [self.cityTypeDataAry objectAtIndex:indexPath.row-1];
            citycell.textLabel.text = dis.EnumName;
            citycell.textLabel.font = [UIFont systemFontOfSize:16];
            citycell.textLabel.textColor = [self colorWithRGB:0x999999 alpha:1];
        }
        return citycell;

    }else if(tableView.tag == 25){
    
        static NSString *identifier = @"hospitalLevelType";
        UITableViewCell *hospitalLevelType = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!hospitalLevelType) {
            hospitalLevelType = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        hospitalLevelType.backgroundColor = [UIColor clearColor];
        
        if (indexPath.row == 0) {
            hospitalLevelType.textLabel.text = @"全部";
            hospitalLevelType.textLabel.font = [UIFont systemFontOfSize:16];
             hospitalLevelType.textLabel.textColor = [self colorWithRGB:0x999999 alpha:1];
        }else{
            discount *diss = [_beautifyProductTypeDataary objectAtIndex:indexPath.row - 1];
            hospitalLevelType.textLabel.text = diss.EnumName;
            hospitalLevelType.textLabel.font = [UIFont systemFontOfSize:16];
            hospitalLevelType.textLabel.textColor = [self colorWithRGB:0x999999 alpha:1];
            
        }
        
         NSLog(@"_beautifyProductTypeDataary--%ld----",_beautifyProductTypeDataary.count);
        
        return hospitalLevelType;
       
        
    }else{
        static NSString *identifier = @"beautiitemes";
        UITableViewCell *beautiitemes = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!beautiitemes) {
            beautiitemes = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        beautiitemes.backgroundColor = [UIColor clearColor];
        beautiitemes.textLabel.text = [self.sequence objectAtIndex:indexPath.row];;
        beautiitemes.textLabel.font = [UIFont systemFontOfSize:16];
        beautiitemes.textLabel.textColor = [self colorWithRGB:0x999999 alpha:1];
        
        return beautiitemes;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView.tag == 28) {
        return 135;
    }else{
        return 40;
        
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 28) {
        meirongzhuanjia *zhuanjia = [_meirongzhuanjia objectAtIndex:indexPath.row];
        
        self.zhuanjiaSno = zhuanjia.Sno;
        self.TrueName = zhuanjia.TrueName;
        self.hospitolname = zhuanjia.HospitalName;
        [self expertbtnclick];
    }

  
    self.isbtnclick = 0;
    if (tableView.tag == 24) {
          _citytaarraybackimage.frame = CGRectMake(0, 0, 0, 0);
        citytablevi.frame = CGRectMake(citytablevi.frame.origin.x, citytablevi.frame.origin.y, citytablevi.frame.size.width,0);
        NSLog(@"%ld",indexPath.row);
        if (indexPath.row == 0) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:20];
            [btn setTitle:@"    城市" forState:UIControlStateNormal];
            self.cityno = @"";
        }else{
            discount *btntitle = [self.cityTypeDataAry objectAtIndex:indexPath.row - 1];
            UIButton *btn = (UIButton *)[self.view viewWithTag:20];
            [btn setTitle:[NSString stringWithFormat:@"  %@",btntitle.EnumName] forState:UIControlStateNormal];
            self.cityno = btntitle.EnumNo;
        }
        [self requestwithsoap];
        
    }else if (tableView.tag == 25){
          _citytaarraybackimage.frame = CGRectMake(0, 0, 0, 0);
        beautifyProductType.frame = CGRectMake(beautifyProductType.frame.origin.x, beautifyProductType.frame.origin.y, beautifyProductType.frame.size.width,0);
        
        if (indexPath.row == 0) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:21];
            [btn setTitle:@"    项目类别" forState:UIControlStateNormal];
            self.hotno = @"";
            self.beautyno = @"";
        }else{
            discount *btntitle = [_beautifyProductTypeDataary objectAtIndex:indexPath.row - 1];
            UIButton *btn = (UIButton *)[self.view viewWithTag:21];
            [btn setTitle:[NSString stringWithFormat:@"  %@",btntitle.EnumName] forState:UIControlStateNormal];
            self.beautyno = btntitle.EnumNo;
            self.hotno = @"";
        }
        [self requestwithsoap];
        
    }else if (tableView.tag == 26){
         _citytaarraybackimage.frame = CGRectMake(0, 0, 0, 0);
        tablevi4.frame = CGRectMake(tablevi4.frame.origin.x, tablevi4.frame.origin.y, tablevi4.frame.size.width,0);
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:22];
        [btn setTitle:[NSString stringWithFormat:@"    %@",[self.sequence objectAtIndex:indexPath.row] ]forState:UIControlStateNormal];
        if (indexPath.row == 0) {
            self.SortFile = @"EvaluateCount";
        }
        if (indexPath.row == 1) {
            self.SortFile = @"BookCount";
        }
        
        if (indexPath.row == 2) {
            self.SortFile = @"";
            [self soaprequstWithCiTyName:@"" AndcityTypeNo:@"" HospiTalLevel:@"" BeautifyProType:@"" SortFile:@"" OrderType:@"" IsGetRuleData:@"1"];
        }else{
            
            [self requestwithsoap];
        }
        
    }else{
    
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
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(self.view.bounds.size.width/2 - 50,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    
    return gaodu;
}

-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}

-(void)requestwithsoap
{
    NSMutableArray *titleary = nil;
    if (titleary == nil) {
        titleary = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:20 + i];
        NSString *str = [[btn currentTitle] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [titleary addObject:str];
    }

    NSLog(@"--------self.cityname--%@-----self.cityno--%@----self.hotno--%@----self.beautyno-%@------self.SortFile-%@------",self.cityname,self.cityno,self.hotno,self.beautyno,self.SortFile);
    
    [self soaprequstWithCiTyName:self.cityname AndcityTypeNo:self.cityno HospiTalLevel:self.hotno BeautifyProType:self.beautyno SortFile:self.SortFile OrderType:@"desc" IsGetRuleData:@"1"];
    
}
#pragma mark--soap请求
-(void)soaprequstWithCiTyName:(NSString *)City AndcityTypeNo:(NSString *)cityTypeNo HospiTalLevel:(NSString *)hospitalLevel BeautifyProType:(NSString *)beautifyProType SortFile:(NSString *)sortFile OrderType:(NSString *)orderType IsGetRuleData:(NSString *)isGetRuleData
{
   
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorByCity xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<cityName>%@</cityName>\n"
                             "<cityTypeNo>%@</cityTypeNo>\n"
                             "<hospitalLevel>%@</hospitalLevel>\n"
                             "<beautifyProType>%@</beautifyProType>\n"
                             "<sortFile>%@</sortFile>\n"
                             "<orderType>%@</orderType>\n"
                             "<isGetRuleData>%@</isGetRuleData>\n"
                             "</GetDoctorByCity>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,City,cityTypeNo,hospitalLevel,beautifyProType,sortFile,orderType
                             ,isGetRuleData];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorByCity" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    
    NSLog(@"theXML-%@",theXML);
    
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
    
    
    
    
    if ([elementName isEqualToString:@"GetDoctorByCityResult"]) {
        
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
    
    
    if ([elementName isEqualToString:@"GetDoctorByCityResult"]) {
       // NSLog(@"-_soapResults-%@",_soapResults);
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
  
        NSLog(@"美容专家数据dic---内容 %@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@"0"]) {
            return;
        }
        NSMutableArray *beautifyProductTypeData = [dic objectForKey:@"beautifyProductTypeData"];
        _beautifyProductTypeDataary = nil;
        if (_beautifyProductTypeDataary == nil) {
            _beautifyProductTypeDataary = [[NSMutableArray alloc] initWithCapacity:0];
        }
        for (NSDictionary *diction in beautifyProductTypeData) {
            discount *disc = [discount PicSrcwithdictionary:diction];
            [_beautifyProductTypeDataary addObject:disc];
        }

        
        NSMutableArray *cityTypeData = [dic objectForKey:@"cityTypeData"];
        self.cityTypeDataAry = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in cityTypeData) {
            discount *disc = [discount PicSrcwithdictionary:diction];
            [self.cityTypeDataAry addObject:disc];
        }
        

        NSMutableArray *hospitalLevelTypeData = [dic objectForKey:@"hospitalLevelTypeData"];
        _hospitalLevelTypeDataary = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in hospitalLevelTypeData) {
            discount *disc = [discount PicSrcwithdictionary:diction];
            [_hospitalLevelTypeDataary addObject:disc];
        }
        

        NSMutableArray *ret = [dic objectForKey:@"ret"];
        _meirongzhuanjia = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in ret) {
            meirongzhuanjia *disc = [meirongzhuanjia zhuanjiawithdictionaray:diction];
            [_meirongzhuanjia addObject:disc];
        }
        
//        NSString *a =[NSString stringWithFormat:@"%@",dic];
//        NSArray *array = [a componentsSeparatedByString:@"、"];
        
        [_contenttable reloadData];
        [citytablevi reloadData];
        [beautifyProductType reloadData];
        [tablevi4 reloadData];
        
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
