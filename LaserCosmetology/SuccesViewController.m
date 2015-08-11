//
//  SuccesViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "SuccesViewController.h"
#import "TopBarView.h"
#import "NewExpertViewCell.h"
#import "Doctorpersents.h"
#import "UIImageView+WebCache.h"
#import "doctorSuccessdetaile.h"
@interface SuccesViewController ()

@end

@implementation SuccesViewController

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
    titilelable.text = @"成功案例";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(zhuyefanhuiaa) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    self.mytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    self.mytableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mytableview];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.succesary.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    NewExpertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NewExpertViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    Doctorpersents *doct;
    if (self.succesary.count > 0) {
        doct  = [self.succesary objectAtIndex:indexPath.row];
    }

    
    cell.succesgrecolorimage.frame = CGRectMake(3, 3, 30, 30);
    cell.succesgrecolorimage.image = [UIImage imageNamed:@"素材10"];
    
    cell.xiaohengxian2.frame = CGRectMake(3, 36, self.view.bounds.size.width,1.5);
    cell.xiaohengxian2.image = [UIImage imageNamed:@"diheng1"];
    
    cell.chenggonganli = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 100, 20)];
    cell.chenggonganli.text = @"成功案例";
    [cell.succesgrecolorimage addSubview:cell.chenggonganli];
    
    cell.succesimage1.frame = CGRectMake(5, 45, (self.view.bounds.size.width - 15)/2, (self.view.bounds.size.width - 15)/2);
    [cell.succesimage1 sd_setImageWithURL:[NSURL URLWithString:doct.PicSrc]];
    
    cell.succesimage2.frame = CGRectMake(10 + (self.view.bounds.size.width - 15)/2, 45, (self.view.bounds.size.width - 15)/2, (self.view.bounds.size.width - 15)/2);
    [cell.succesimage2 sd_setImageWithURL:[NSURL URLWithString:doct.PicSrc2]];
    
    cell.xiangmu.frame = CGRectMake(10, 50 +(self.view.bounds.size.width - 15)/2, 40, 20);
    cell.xiangmu.text = @"项目:";
    
    cell.succeprojectcontents.frame = CGRectMake(55, 50 +(self.view.bounds.size.width - 15)/2, 5 + [self NSStringwithsize:17 str:doct.Title], 20);
    cell.succeprojectcontents.textColor = [UIColor whiteColor];
    cell.succeprojectcontents.backgroundColor = [self colorWithRGB:0x80e2dd alpha:1];
    cell.succeprojectcontents.text = doct.Title;
    cell.succeprojectcontents.layer.masksToBounds = YES;
    cell.succeprojectcontents.layer.cornerRadius = 3;
    
    cell.xiaohengxian3.frame = CGRectMake(3, 75 +(self.view.bounds.size.width - 15)/2, self.view.bounds.size.width,1.5);
    cell.xiaohengxian3.image = [UIImage imageNamed:@"diheng1"];
    
    cell.miaoshu.frame = CGRectMake(10, 75 +(self.view.bounds.size.width - 15)/2, self.view.bounds.size.width - 20, 40);
    cell.miaoshu.font = [UIFont systemFontOfSize:14];
    cell.miaoshu.numberOfLines = 2;
    
    cell.diheng3.frame = CGRectMake(0, 130 + (self.view.bounds.size.width - 15)/2 - 15, self.view.bounds.size.width, 15);
    cell.diheng3.image = [UIImage imageNamed:@"diheng"];

    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130 + (self.view.bounds.size.width - 15)/2;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Doctorpersents *zj = [self.succesary objectAtIndex:indexPath.row];
    
    doctorSuccessdetaile *doctor = [[doctorSuccessdetaile alloc] init];
    doctor.sno = zj.Sno;
    [self.navigationController pushViewController:doctor animated:YES];

}
-(void)zhuyefanhuiaa
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


@end
