//
//  MyPoIntWebViewController.m
//  聚美医
//
//  Created by fenghuang on 15/7/6.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MyPoIntWebViewController.h"
#import "TopBarView.h"
#import "PrefixHeader.pch"
@interface MyPoIntWebViewController ()

@end

@implementation MyPoIntWebViewController

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
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 300, 25)];
    titilelable.text = @"";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclickx) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    
    [self creatwebview];
}
-(void)backbuttonclickx
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatwebview
{
    NSString *urlstr = [NSString stringWithFormat:HTTPREQUESTPDOMAIN@"/Front/TextPage/OrderDetailInfo.aspx?Sno=%@",self.produtsno];
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width , self.view.bounds.size.height  - 64)];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    NSURLRequest * req=[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [_webview loadRequest:req];
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

@end
