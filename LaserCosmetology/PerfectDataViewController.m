//
//  PerfectDataViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/6.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "PerfectDataViewController.h"
#import "TopBarView.h"
#import "moban.h"
#import "GongNengSheZhi.h"
#import "DetailsPersonalData.h"
@interface PerfectDataViewController ()

@end

@implementation PerfectDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    [backbtn addTarget:self action:@selector(PerfectDatacomeback) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    float higth = self.view.bounds.size.width * 0.1407;
    NSArray *imagearray = [[NSArray alloc] initWithObjects:@"完善资料_02",@"完善资料_06", nil];
    NSArray *titlearray = [[NSArray alloc] initWithObjects:@"详细资料",@"功能设置", nil];
    for (int i = 0; i < 2; i++) {
        UIImageView *xiangxizl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 84 + (higth + 20) * i, self.view.bounds.size.width, higth)];
        xiangxizl.image = [UIImage imageNamed:[imagearray objectAtIndex:i]];
        xiangxizl.userInteractionEnabled = YES;
        [self.view addSubview:xiangxizl];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 150, 20)];
        lable.text = [titlearray objectAtIndex:i];
        lable.userInteractionEnabled = YES;
        [xiangxizl addSubview:lable];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, xiangxizl.bounds.size.width, xiangxizl.bounds.size.height)];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 10;
        [xiangxizl addSubview:button];
        
    }
    
    
}
-(void)PerfectDatacomeback
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
-(void)btnclick:(UIButton *)button
{
    if (button.tag == 10) {
        DetailsPersonalData *details = [[DetailsPersonalData alloc] init];
        details.doctorSno = self.doctorSno;
        [self.navigationController pushViewController:details animated:YES];
    }else{
    
        GongNengSheZhi *shezhi = [[GongNengSheZhi alloc] init];
        [self.navigationController pushViewController:shezhi animated:YES];
    }

}

@end
