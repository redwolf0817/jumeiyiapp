//
//  NewExpertViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "NewExpertViewController.h"
#import "TopBarView.h"
#import "NewExpertViewCell.h"
#import "UIImageView+WebCache.h"
#import "Doctorpersents.h"
#import "CommunicateWithDoctors.h"
#import "Detailsproject2.h"
#import "SuccesViewController.h"
#import "MoreGoodAtProjectVC.h"
#import "PrefixHeader.pch"
@interface NewExpertViewController ()

@end

@implementation NewExpertViewController

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
    titilelable.text = @"专家主页";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(zhuyefanhui) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableview];
    
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
    self.customersno = [userdf objectForKey:@"customerSno"];
    if (self.customersno == nil) {
        self.customersno = @"";
    }
    
    NSLog(@"-专家主页数据---------self.doctorsno-%@-----------self.customersno--%@",self.doctorsno,self.customersno);
    
    [self soaprequstWithdoctorSno:self.doctorsno customerSno:self.customersno];
    
    self.cellhigth = 150;
    self.isgrup = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payatentions) name:@"tongzhiguanzhu" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(communicationwithdoctot) name:@"Communicate" object:nil];
}
-(void)payatentions
{
    if ([self.isFocus isEqualToString:@"0"]) {
        [self soaprequstWithcustomerSno:self.customersno doctorSno:self.doctorsno];
    }else{
    [self soaprequstDeleteCustomerFocusOnDoctorWithcustomerSno:self.customersno doctorSno:self.doctorsno];
    }
    
}
-(void)communicationwithdoctot
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *iscustomer =[user objectForKey:@"CommomUserORCommomDoctor"];
    
    if ([iscustomer isEqualToString:@"CommomUser"]) {
        
        CommunicateWithDoctors *comi = [[CommunicateWithDoctors alloc] init];
        comi.doctorSno = self.doctorsno;
        [self.navigationController pushViewController:comi animated:YES];
        
    }else{
        
        
        UIAlertView *alerter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请去会员中心登录！如果您是医生用户，此功能不可用！谢谢！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alerter show];
    }
    
}
-(void)redingallcontents
{
   
    
    if (self.isgrup == NO) {
        self.isgrup = YES;
        
    }else{
        self.isgrup = NO;
    }
    
    [_tableview reloadData];
    
}
-(void)moerclick
{
    MoreGoodAtProjectVC *more = [[MoreGoodAtProjectVC alloc] init];
    more.moerarray = _proDataary;
    more.doctorsno = self.doctorsno;
    more.customersno = self.customersno;
    more.hospitalName = self.hospitalName;
    more.doctorname = self.doctorname;
    [self.navigationController pushViewController:more animated:YES];
}
#pragma  mark  Tableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (_basicDataary.count > 0) {
            return 1;
        }else{
            return 0;
        }

    }else if (section == 1){
        if (_basicDataary.count > 0) {
            return 1;
        }else{
            return 0;
        }
    }else if (section == 2){
        if (_successCaseDataary.count > 0) {
            return 1;
        }else{
            return 0;
        }
    } else if (section == 3){
     
        if (_proDataary.count > 5) {
            return 5;
        }else{
         return _proDataary.count;
        }
        
    }else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    NewExpertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NewExpertViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.backimage.frame = CGRectMake(0,0 ,0 ,0);
    cell.headimage.frame = CGRectMake(0, 0, 0, 0);
    cell.headimage.image = [UIImage imageNamed:@""];
    cell.chuxian.frame = CGRectMake(0,0,0,0);
    cell.chuxian.image = [UIImage imageNamed:@""];
    cell.name.frame = CGRectMake(0, 0,0, 0);
    cell.name.text = @"";
    cell.Post.frame = CGRectMake(0, 0, 0, 0);
    cell.Post.text = @"";
    cell.Area.frame = CGRectMake(0, 0, 0, 0);
    cell.Area.text = @"";
    cell.PayAttentionTo.frame = CGRectMake(0,0 , 0,0 );
    [cell.PayAttentionTo setTitle:@"" forState:UIControlStateNormal];
    cell.PayAttentionTo.backgroundColor = [UIColor clearColor];
    cell.diheng1.frame = CGRectMake(0, 0, 0, 0);
    cell.diheng1.image = [UIImage imageNamed:@""];
    
    cell.grecolorimage.frame = CGRectMake(0, 0,0, 0);
    cell.grecolorimage.image = [UIImage imageNamed:@""];
    cell.xiaohengxian.frame = CGRectMake(0, 0, 0,0);
    cell.xiaohengxian.image = [UIImage imageNamed:@""];
    cell.btnimage.frame = CGRectMake(0, 0,0, 0);
    cell.btnimage.image = [UIImage imageNamed:@""];
    cell.diheng2.frame = CGRectMake(0,0, 0, 0);
    cell.diheng2.image = [UIImage imageNamed:@""];
    
    cell.contents.frame = CGRectMake(0, 0, 00,00);
    cell.contents.numberOfLines = 0;
    cell.contents.font = [UIFont systemFontOfSize:15];
    cell.contents.text = @"";
    cell.redingall.frame = CGRectMake(0,0 , 0, 20);
    [cell.redingall setTitle:@"" forState:UIControlStateNormal];
    cell.redingall.titleLabel.font = [UIFont systemFontOfSize:15];
    
    cell.succesgrecolorimage.frame = CGRectMake(0, 0,0,0);
    cell.succesgrecolorimage.image = [UIImage imageNamed:@""];

    
    cell.succesimage1.frame = CGRectMake(0,0 ,0 , 0);
    [cell.succesimage1 sd_setImageWithURL:[NSURL URLWithString:@""]];
    cell.succesimage2.frame = CGRectMake(0, 0,0, 0);
    [cell.succesimage2 sd_setImageWithURL:[NSURL URLWithString:@""]];
    cell.succeprojectcontents.frame = CGRectMake(0, 0, 0, 0);
    cell.succeprojectcontents.numberOfLines = 0;
    cell.succeprojectcontents.text = @"";

    
    cell.BeGoodToprojectName.frame = CGRectMake(0, 0, 0, 0);
    cell.BeGoodToprojectName.text = @"";
    cell.morebtn.frame = CGRectMake(0, 0, 0, 0);
    [cell.morebtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    cell.yifuwu.frame = CGRectMake(0, 0, 0, 0);
    cell.persentsnumber.frame = CGRectMake(0,0, 0, 0);
    cell.persentsnumber.text = @"";
    cell.persents.frame = CGRectMake(0, 0, 0, 0);
    cell.begoodatcontents.frame = CGRectMake(0, 0, 0, 0);
    cell.begoodatcontents.text = @"";
    cell.BeGoodToBackImage.frame = CGRectMake(0, 0, 0,0);
    cell.BeGoodToBackImage.image = [UIImage imageNamed:@""];
    cell.chuxian2.frame = CGRectMake(0,0,0, 0);
    cell.chuxian2.image = [UIImage imageNamed:@""];

    cell.Communicatebtn.frame = CGRectMake(0, 0, 0, 0);
    [cell.Communicatebtn setTitle:@"" forState:UIControlStateNormal];
    [cell.Communicatebtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    cell.gerenjieshao.frame = CGRectMake(0, 0, 0, 0);
    cell.gerenjieshao.text = @"";
    
    cell.chenggonganli.frame = CGRectMake(0, 0, 0, 0);
    cell.chenggonganli.text = @"";
    
    cell.shanchang.frame = CGRectMake(0, 0, 0, 0);
    cell.shanchang.text = @"";
    
    cell.diheng3.frame = CGRectMake(0, 0, 0, 0);
    cell.diheng3.image = [UIImage imageNamed:@""];
    cell.diheng4.frame = CGRectMake(0, 0, 0, 0);
    cell.diheng4.image = [UIImage imageNamed:@""];
    
    if (indexPath.section == 0) {
        Doctorpersents *doct;
        if (_basicDataary.count > 0) {
            doct = [_basicDataary objectAtIndex:indexPath.row];
        }
        
        cell.backimage.frame = CGRectMake(0, 0, self.view.bounds.size.width, 170);
        cell.backimage.image = [UIImage imageNamed:@"医生主页3_02"];
        
        cell.headimage.frame = CGRectMake(self.view.bounds.size.width/2 - 40, 15, 80, 80);
        [cell.headimage sd_setImageWithURL:[NSURL URLWithString:doct.PicSrc]];
        cell.headimage.layer.masksToBounds = YES;
        cell.headimage.layer.cornerRadius = 40;
        
        cell.name.frame = CGRectMake(self.view.bounds.size.width/2 - [self NSStringwithsize:16 str:doct.DoctorName] - 5, 105, [self NSStringwithsize:16 str:doct.DoctorName], 20);
        cell.name.font = [UIFont systemFontOfSize:16];
        cell.name.textColor = [self colorWithRGB:0x666666 alpha:1];
        cell.name.text = doct.DoctorName;
        self.doctorname = doct.DoctorName;
        
        cell.chuxian.frame = CGRectMake(self.view.bounds.size.width/2 , 102,1.50, 25);
        cell.chuxian.image = [UIImage imageNamed:@"素材4"];
        
        cell.Post.frame = CGRectMake(self.view.bounds.size.width/2 + 5, 105, [self NSStringwithsize:16 str:doct.PostName], 20);
        cell.Post.text = doct.PostName;
        cell.Post.textColor = [self colorWithRGB:0x666666 alpha:1];
        cell.Post.font = [UIFont systemFontOfSize:16];
        
        cell.Area.frame = CGRectMake(self.view.bounds.size.width/2 - ([self NSStringwithsize:17 str:self.hospitalName]/2), 130, [self NSStringwithsize:14 str:self.hospitalName], 20);
        cell.Area.text = self.hospitalName;
        cell.Area.textColor = [self colorWithRGB:0x868686 alpha:1];
        cell.Area.font = [UIFont systemFontOfSize:14];

        
        if ([self.isFocus isEqualToString:@"0"]) {
            cell.PayAttentionTo.frame = CGRectMake(self.view.bounds.size.width - 60, 23, 45, 20);
            [cell.PayAttentionTo setBackgroundImage:[UIImage imageNamed:@"医生主页_03guanzhu"] forState:UIControlStateNormal];
            [cell.PayAttentionTo setTitle:@"关注" forState:UIControlStateNormal];
            cell.PayAttentionTo.titleLabel.font = [UIFont systemFontOfSize:11];
            [cell.PayAttentionTo setTitleColor:[self colorWithRGB:0x00c5bb alpha:1] forState:UIControlStateNormal];
        }else{
            cell.PayAttentionTo.frame = CGRectMake(self.view.bounds.size.width - 60, 23, 45, 20);
            [cell.PayAttentionTo setBackgroundImage:[UIImage imageNamed:@"医生主页3_03yigunzhu"] forState:UIControlStateNormal];
            [cell.PayAttentionTo setTitle:@"已关注" forState:UIControlStateNormal];
            cell.PayAttentionTo.titleLabel.font = [UIFont systemFontOfSize:11];
            [cell.PayAttentionTo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        cell.diheng1.frame = CGRectMake(0, 170, self.view.bounds.size.width, 15);
        cell.diheng1.image = [UIImage imageNamed:@"diheng"];
        
        
    }else if (indexPath.section == 1){

        Doctorpersents *doc;
        if (_basicDataary.count > 0) {
            doc = [_basicDataary objectAtIndex:indexPath.row];
        }
        
        cell.grecolorimage.frame = CGRectMake(3, 3, 30, 30);
        cell.grecolorimage.image = [UIImage imageNamed:@"素材6"];
        
        cell.gerenjieshao = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 100, 20)];
        cell.gerenjieshao.text = @"个人介绍";
        cell.gerenjieshao.textColor = [self colorWithRGB:0x666666 alpha:1];
        cell.gerenjieshao.font = [UIFont systemFontOfSize:15];
        [cell.grecolorimage addSubview:cell.gerenjieshao];
        
        cell.xiaohengxian.frame = CGRectMake(3, 36, self.view.bounds.size.width,1.6);
        cell.xiaohengxian.image = [UIImage imageNamed:@"diheng1"];
        
        if (self.isgrup == NO) {
            
            float HIGH;
            if (self.contentshigth < 150) {
                 HIGH = self.contentshigth ;
                  cell.btnview.frame = CGRectMake(0, self.contentshigth + 90 - 45, self.view.bounds.size.width, 30);
                cell.diheng2.frame = CGRectMake(0, self.contentshigth + 90 - 15, self.view.bounds.size.width, 15);
                cell.diheng2.image = [UIImage imageNamed:@"diheng"];
            }else{
                 HIGH = self.cellhigth - 70;
                  cell.btnview.frame = CGRectMake(0, self.cellhigth - 45, self.view.bounds.size.width, 30);
                cell.diheng2.frame = CGRectMake(0,self.cellhigth  - 15 , self.view.bounds.size.width, 15);
                cell.diheng2.image = [UIImage imageNamed:@"diheng"];
            }
            
            cell.contents.frame = CGRectMake(10, 35, self.view.bounds.size.width - 20, HIGH);
            cell.contents.numberOfLines = 0;
            cell.contents.font = [UIFont systemFontOfSize:13];
            cell.contents.textColor = [self colorWithRGB:0x666666 alpha:1];
            cell.contents.text = doc.Contents;
        
            cell.btnimage.frame = CGRectMake(self.view.bounds.size.width/2 - 20, 10, 30, 15);
            cell.btnimage.image = [UIImage imageNamed:@"素材8"];
            
            cell.redingall.frame = CGRectMake(0,0, self.view.bounds.size.width, 30);
            [cell.redingall addTarget:self action:@selector(redingallcontents) forControlEvents:UIControlEventTouchUpInside];
            cell.redingall.titleLabel.font = [UIFont systemFontOfSize:15];
            
        }else{
        
            cell.contents.frame = CGRectMake(10, 35, self.view.bounds.size.width - 20, self.contentshigth);
            cell.contents.numberOfLines = 0;
            cell.contents.font = [UIFont systemFontOfSize:13];
            cell.contents.textColor =  [self colorWithRGB:0x666666 alpha:1];
            cell.contents.text = doc.Contents;
            
            cell.btnview.frame = CGRectMake(0,  self.contentshigth + 80 - 45, self.view.bounds.size.width, 30);
            
            cell.btnimage.frame = CGRectMake(self.view.bounds.size.width/2 - 20, 10, 30, 15);
            cell.btnimage.image = [UIImage imageNamed:@"素材11"];
            
            cell.redingall.frame = CGRectMake(0,0, self.view.bounds.size.width, 30);
            [cell.redingall addTarget:self action:@selector(redingallcontents) forControlEvents:UIControlEventTouchUpInside];
            cell.redingall.titleLabel.font = [UIFont systemFontOfSize:15];
            
            cell.diheng2.frame = CGRectMake(0, self.contentshigth + 80 - 15, self.view.bounds.size.width, 15);
            cell.diheng2.image = [UIImage imageNamed:@"diheng"];
        }
        

        
        cell.backgroundColor = [UIColor whiteColor];
        
    }else if (indexPath.section == 2){
        
        cell.backgroundColor = [UIColor whiteColor];
        Doctorpersents *doct;
        if (_successCaseDataary.count > 0) {
           doct  = [_successCaseDataary objectAtIndex:indexPath.row];
        }
        
        cell.succesgrecolorimage.frame = CGRectMake(3, 3, 30, 30);
        cell.succesgrecolorimage.image = [UIImage imageNamed:@"素材10"];
        
        cell.xiaohengxian2.frame = CGRectMake(3, 36, self.view.bounds.size.width,1.5);
        cell.xiaohengxian2.image = [UIImage imageNamed:@"diheng1"];
        
        cell.chenggonganli = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 100, 20)];
        cell.chenggonganli.text = @"成功案例";
        cell.chenggonganli.textColor =  [self colorWithRGB:0x666666 alpha:1];
        cell.chenggonganli.font = [UIFont systemFontOfSize:15];
        [cell.succesgrecolorimage addSubview:cell.chenggonganli];
        
        cell.succesimage1.frame = CGRectMake(5, 45, (self.view.bounds.size.width - 15)/2, (self.view.bounds.size.width - 15)/2);
        [cell.succesimage1 sd_setImageWithURL:[NSURL URLWithString:doct.PicSrc]];
        
         cell.succesimage2.frame = CGRectMake(10 + (self.view.bounds.size.width - 15)/2, 45, (self.view.bounds.size.width - 15)/2, (self.view.bounds.size.width - 15)/2);
        [cell.succesimage2 sd_setImageWithURL:[NSURL URLWithString:doct.PicSrc2]];
        
        cell.xiangmu.frame = CGRectMake(10, 50 +(self.view.bounds.size.width - 15)/2, 40, 20);
        cell.xiangmu.textColor =  [self colorWithRGB:0x666666 alpha:1];
        cell.xiangmu.font = [UIFont systemFontOfSize:16];
        cell.xiangmu.text = @"项目:";
        
        cell.succeprojectcontents.frame = CGRectMake(55, 50 +(self.view.bounds.size.width - 15)/2, 5 + [self NSStringwithsize:17 str:doct.Title], 20);
        cell.succeprojectcontents.textColor = [UIColor whiteColor];
        cell.succeprojectcontents.backgroundColor = [self colorWithRGB:0x80e2dd alpha:1];
        cell.succeprojectcontents.text = doct.Title;
        cell.succeprojectcontents.layer.masksToBounds = YES;
        cell.succeprojectcontents.layer.cornerRadius = 3;
        cell.succeprojectcontents.font = [UIFont systemFontOfSize:16];
        
        cell.xiaohengxian3.frame = CGRectMake(3, 75 +(self.view.bounds.size.width - 15)/2, self.view.bounds.size.width,1.5);
        cell.xiaohengxian3.image = [UIImage imageNamed:@"diheng1"];
        
        cell.miaoshu.frame = CGRectMake(10, 75 +(self.view.bounds.size.width - 15)/2, self.view.bounds.size.width - 20, 40);
        cell.miaoshu.font = [UIFont systemFontOfSize:14];
        cell.miaoshu.numberOfLines = 2;
        
        cell.diheng3.frame = CGRectMake(0, 130 + (self.view.bounds.size.width - 15)/2 - 15, self.view.bounds.size.width, 15);
        cell.diheng3.image = [UIImage imageNamed:@"diheng"];
        
    }else if (indexPath.section == 3){

        cell.backgroundColor = [UIColor whiteColor];
        if (indexPath.row == 0) {
            
            cell.BeGoodToBackImage.frame = CGRectMake(3, 3, 30, 30);
            cell.BeGoodToBackImage.image = [UIImage imageNamed:@"素材7"];

            cell.shanchang = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 100, 20)];
            cell.shanchang.text = @"擅长项目";
            cell.shanchang.textColor =  [self colorWithRGB:0x666666 alpha:1];
            cell.shanchang.font = [UIFont systemFontOfSize:15];
            [cell.BeGoodToBackImage addSubview:cell.shanchang];
            
            cell.xiaohengxian4.frame = CGRectMake(3, 36, self.view.bounds.size.width,1.5);
            cell.xiaohengxian4.image = [UIImage imageNamed:@"diheng1"];
            
            cell.morebtn.frame = CGRectMake(self.view.bounds.size.width - 35, 10, 18, 20);
            [cell.morebtn addTarget:self action:@selector(moerclick) forControlEvents:UIControlEventTouchUpInside];
            [cell.morebtn setBackgroundImage:[UIImage imageNamed:@"素材12"] forState:UIControlStateNormal];
            
            Doctorpersents *doctor;
            if (_proDataary.count > 0) {
               doctor  = [_proDataary objectAtIndex:indexPath.row];
            }
            
            cell.BeGoodToprojectName.frame = CGRectMake(10, 50, 150, 20);
            cell.BeGoodToprojectName.text = doctor.BeautifyProName;
            cell.BeGoodToprojectName.textColor =  [self colorWithRGB:0x999999 alpha:1];
            cell.BeGoodToprojectName.font = [UIFont systemFontOfSize:15];
            
            cell.chuxian2.frame = CGRectMake(self.view.bounds.size.width/2  - 30, 50,1.50, 25);
            cell.chuxian2.image = [UIImage imageNamed:@"素材4"];
            
            cell.yifuwu.frame = CGRectMake(self.view.bounds.size.width/2 - 15, 55, [self NSStringwithsize:15 str:@"已服务"], 20);
            cell.yifuwu.textColor = [self colorWithRGB:0x00c5bb alpha:1];
            cell.yifuwu.font = [UIFont systemFontOfSize:15];
            
            cell.persentsnumber.frame = CGRectMake(self.view.bounds.size.width/2 - 15 + [self NSStringwithsize:15 str:@"已服务"],55, [self NSStringwithsize:15 str:doctor.ServiceCount], 20);
            cell.persentsnumber.text = doctor.ServiceCount;
            cell.persentsnumber.textColor = [self colorWithRGB:0x00c5bb alpha:1];
            cell.persentsnumber.font = [UIFont systemFontOfSize:15];
            
            cell.persents.frame = CGRectMake(self.view.bounds.size.width/2 - 15 + [self NSStringwithsize:15 str:@"已服务"] + [self NSStringwithsize:15 str:doctor.ServiceCount], 55, 40, 20);
            cell.persents.textColor = [self colorWithRGB:0x00c5bb alpha:1];
            cell.persents.font = [UIFont systemFontOfSize:15];
            
            cell.begoodatcontents.frame = CGRectMake(self.view.bounds.size.width - 60, 52, 45, 25);
            cell.begoodatcontents.text = @"  预约";
            cell.begoodatcontents.font = [UIFont systemFontOfSize:13];
            cell.begoodatcontents.textColor = [self colorWithRGB:0xffffff alpha:1];
            cell.begoodatcontents.backgroundColor = [self colorWithRGB:0x80e2dd alpha:1];
            cell.begoodatcontents.layer.masksToBounds = YES;
            cell.begoodatcontents.layer.cornerRadius = 5;
            
            
        }else{
            
            Doctorpersents *doctor;
            if (_proDataary.count > 0) {
                doctor  = [_proDataary objectAtIndex:indexPath.row];
            }
            
            cell.BeGoodToprojectName.frame = CGRectMake(10, 15, 150, 20);
            cell.BeGoodToprojectName.text = doctor.BeautifyProName;
            cell.BeGoodToprojectName.textColor =  [self colorWithRGB:0x999999 alpha:1];
            cell.BeGoodToprojectName.font = [UIFont systemFontOfSize:15];
            
            cell.chuxian2.frame = CGRectMake(self.view.bounds.size.width/2 - 30 , 15,1.50, 25);
            cell.chuxian2.image = [UIImage imageNamed:@"素材4"];
            
            cell.yifuwu.frame = CGRectMake(self.view.bounds.size.width/2 - 15, 15,  [self NSStringwithsize:15 str:@"已服务"], 20);
             cell.yifuwu.font = [UIFont systemFontOfSize:15];
            cell.yifuwu.textColor = [self colorWithRGB:0x00c5bb alpha:1];
            cell.persentsnumber.frame = CGRectMake(self.view.bounds.size.width/2 - 15 + [self NSStringwithsize:15 str:@"已服务"],15, [self NSStringwithsize:17 str:doctor.ServiceCount], 20);
            cell.persentsnumber.textColor = [self colorWithRGB:0x00c5bb alpha:1];
            cell.persentsnumber.text = doctor.ServiceCount;
             cell.persentsnumber.font = [UIFont systemFontOfSize:15];
            
            cell.persents.frame = CGRectMake(self.view.bounds.size.width/2 - 15 + [self NSStringwithsize:15 str:@"已服务"] + [self NSStringwithsize:15 str:doctor.ServiceCount], 15, 40, 20);
            cell.persents.textColor = [self colorWithRGB:0x00c5bb alpha:1];
             cell.persents.font = [UIFont systemFontOfSize:15];
            
            cell.begoodatcontents.frame = CGRectMake(self.view.bounds.size.width - 60, 12, 45, 25);
            cell.begoodatcontents.text = @"  预约";
            cell.begoodatcontents.textColor = [UIColor whiteColor];
            cell.begoodatcontents.font = [UIFont systemFontOfSize:13];
            cell.begoodatcontents.backgroundColor = [self colorWithRGB:0x80e2dd alpha:1];
            cell.begoodatcontents.layer.masksToBounds = YES;
            cell.begoodatcontents.layer.cornerRadius = 5;

        }
       
    }else{
        
        cell.diheng4.frame = CGRectMake(0, 0, self.view.bounds.size.width, 15);
        cell.diheng4.image = [UIImage imageNamed:@"diheng"];
    
        cell.Communicatebtn.frame = CGRectMake(self.view.bounds.size.width/2 - 60, 30, 120, 30);
        [cell.Communicatebtn setTitle:@"与专家沟通" forState:UIControlStateNormal];
        [cell.Communicatebtn setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 185;
    }else if (indexPath.section == 1){
        
        if (self.isgrup == NO) {
            if (self.contentshigth < 150) {
                return self.contentshigth + 90;
            }else{
             return self.cellhigth ;
            }
           
        }else{
            return self.contentshigth + 80;
        }
        
    }else if (indexPath.section == 2){
        return 130 + (self.view.bounds.size.width - 15)/2;
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            return 84;
        }else{
            return 50;
        }
    }else{
        return 100;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        return ;
    }else if (indexPath.section == 1){

        return;
    }else if (indexPath.section == 2){
        Doctorpersents *per = [_successCaseDataary objectAtIndex:indexPath.row];
        
        SuccesViewController *succes = [[SuccesViewController alloc] init];
        succes.succesary = _successCaseDataary;
        succes.doctorsno = per.DoctorSno;
        [self.navigationController pushViewController:succes animated:YES];
    }else if (indexPath.section == 3){
        
        Doctorpersents *per = [_proDataary objectAtIndex:indexPath.row];
        
        Detailsproject2 *proj = [[Detailsproject2 alloc] init];
        proj.sno = per.ProductSno;
        proj.EnumName = per.BeautifyProName;
        proj.doctorSno = self.doctorsno;
        proj.customerSno = self.customersno;
        proj.hostitalname = self.hospitalName;
        proj.doctorname = self.doctorname;
        proj.hosptSno = self.hospitalSno;
        [self.navigationController pushViewController:proj animated:YES];
        
        
    }else{
        return ;
    }
}

-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}

-(void)zhuyefanhui
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:16];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 25,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark--soap请求
//获取医生主页数据
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno customerSno:(NSString *)customerSno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorPageData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "</GetDoctorPageData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,customerSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorPageData" forHTTPHeaderField:@"SOAPAction"];
    
    
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

//添加客户关注医生数据
-(void)soaprequstWithcustomerSno:(NSString *)customerSno doctorSno:(NSString *)doctorSno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<CustomerFocusOnDoctor xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "</CustomerFocusOnDoctor>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,doctorSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/CustomerFocusOnDoctor" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//取消客户关注医生数据
-(void)soaprequstDeleteCustomerFocusOnDoctorWithcustomerSno:(NSString *)customerSno doctorSno:(NSString *)doctorSno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<DeleteCustomerFocusOnDoctor xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "</DeleteCustomerFocusOnDoctor>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,doctorSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/DeleteCustomerFocusOnDoctor" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    
    
    
    
    if ([elementName isEqualToString:@"GetDoctorPageDataResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
        
    }
    
    if ([elementName isEqualToString:@"CustomerFocusOnDoctorResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
        
    }
    
    if ([elementName isEqualToString:@"DeleteCustomerFocusOnDoctorResult"]) {
        
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
    
    
    if ([elementName isEqualToString:@"GetDoctorPageDataResult"]) {
        // NSLog(@"-_soapResults-%@",_soapResults);
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"美容专家主页数据dic---内容 %@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@""]) {
            return;
        }
        
        NSString *contentss;
        _basicDataary = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *basicData = [dic objectForKey:@"basicData"];
        for (NSDictionary *basidic in basicData) {
            Doctorpersents *doctor = [Doctorpersents DoctorpersentsWithDictionnary:basidic];
            contentss = doctor.Contents;
            [_basicDataary addObject:doctor];
        }
        
        self.contentshigth = [self contentsWithnsstring:contentss];
        
        _proDataary = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *proData = [dic objectForKey:@"proData"];
        for (NSDictionary *prodic in proData) {
            Doctorpersents *doctor = [Doctorpersents DoctorpersentsWithDictionnary:prodic];
            [_proDataary addObject:doctor];
        }
        
        _successCaseDataary = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *successCaseData = [dic objectForKey:@"successCaseData"];
        for (NSDictionary *succesdic in successCaseData) {
            Doctorpersents *doctor = [Doctorpersents DoctorpersentsWithDictionnary:succesdic];
            [_successCaseDataary addObject:doctor];
        }
        
        self.hospitalName = [dic objectForKey:@"hospitalName"];
        self.isFocus = [dic objectForKey:@"isFocus"];
        self.hospitalSno = [dic objectForKey:@"hospitalSno"];
        
        [_tableview reloadData];
  }
    
    if ([elementName isEqualToString:@"CustomerFocusOnDoctorResult"]) {
        // NSLog(@"-_soapResults-%@",_soapResults);
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"关注的数据dic---内容 %@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            self.isFocus = @"1";
            
        }
        
        [_tableview reloadData];
    }
    
    if ([elementName isEqualToString:@"DeleteCustomerFocusOnDoctorResult"]) {
        // NSLog(@"-_soapResults-%@",_soapResults);
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"取消关注的数据dic---内容 %@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            self.isFocus = @"0";
        }
         [_tableview reloadData];
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
