//
//  youhuiwebViewController.m
//  聚美医
//
//  Created by fenghuang on 15/7/17.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "youhuiwebViewController.h"
#import "TopBarView.h"
#import "MakeAppointment.h"
#import "youhuihuodong.h"
#import "PrefixHeader.pch"
@interface youhuiwebViewController ()

@end

@implementation youhuiwebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *_titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    _titilelable.text = @"优惠详情";
    _titilelable.textColor = [UIColor whiteColor];
    _titilelable.font = [UIFont systemFontOfSize:22];
    _titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    _titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:_titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(youhuiye) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    NSString *urlstr = [NSString stringWithFormat:HTTPREQUESTPDOMAIN@"/Front/TextPage/QiangGou.aspx?sno=%@",self.urlsno];
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width , self.view.bounds.size.height - 64 - 50)];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    NSURLRequest * req=[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [_webview loadRequest:req];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50)];
    view.backgroundColor = [self colorWithRGB:0xe5e5e5 alpha:1];
    [self.view addSubview:view];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40, 7, 80, 35)];
    [button setTitle:@"提交预约" forState:UIControlStateNormal];
    button.backgroundColor = [self colorWithRGB:0x00c5bb alpha:1];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(gotobuy) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
}
-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}
-(void)youhuiye
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)gotobuy
{
    youhuihuodong *youhui = [self.beautifyProductSaleDataarray objectAtIndex:self.selectorindex];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *iscustomer =[user objectForKey:@"CommomUserORCommomDoctor"];
    
    if ([iscustomer isEqualToString:@"CommomUser"]) {
        
        //客户中心
        if ([youhui.IsCanUse integerValue] == 1) {
            MakeAppointment *make = [[MakeAppointment alloc] init];
            make.saleSno = youhui.Sno;
            make.hostitalname = youhui.HospitalName;
            make.date = youhui.BookDt;
            make.doctornames = youhui.DoctorName;
            make.doctorSno = youhui.DoctorSno;
            make.proSno = youhui.ProductSno;
            [self.navigationController pushViewController:make animated:YES];
        }
        
    }else if([iscustomer isEqualToString:@"CommomDoctor"]){
       //医生个人中心
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"医生不能预约项目！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
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

@end
