//
//  MainWebViewController.m
//  聚美医
//
//  Created by fenghuang on 15/7/7.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MainWebViewController.h"
#import "TopBarView.h"
@interface MainWebViewController ()

@end

@implementation MainWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
   UILabel *_titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    _titilelable.text = @"详情页";
    _titilelable.textColor = [UIColor whiteColor];
    _titilelable.font = [UIFont systemFontOfSize:22];
    _titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    _titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:_titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(xiangqingye) forControlEvents:UIControlEventTouchUpInside];
   // backbtn.backgroundColor = [UIColor redColor];
    [topbar addSubview:backbtn];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@",self.url];
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width , self.view.bounds.size.height - 64)];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    NSURLRequest * req=[NSURLRequest requestWithURL:[NSURL URLWithString:urlstr]];
    [_webview loadRequest:req];
    
}
-(void)xiangqingye
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

@end
