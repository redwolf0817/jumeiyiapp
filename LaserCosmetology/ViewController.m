//
//  ViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//


#import "ViewController.h"

#import "MainViewController.h"
#import "BeautyExpertViewController.h"
#import "PersonDoctShooseViewController.h"
#import "AboutViewController.h"
#import "HuQiJingsharManage.h"
#import "AppDelegate.h"
#import "BottomBarView.h"
#import "beautymennutViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
    NSString *isyindaoye = [userdf objectForKey:@"yindaoye"];
    
    if (![isyindaoye isEqualToString:@"yindaoye"]) {
        
        NSArray *imageary = [[NSArray alloc] initWithObjects:@"引导页01.jpg",@"引导页02.jpg",@"引导页03.jpg",@"引导页04.jpg", nil];
        _scv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scv.contentSize = CGSizeMake(self.view.bounds.size.width * 4, 0);
        _scv.pagingEnabled = YES;
        _scv.delegate = self;
        [self.view addSubview:_scv];
        
        for (int i = 0; i < 4; i++) {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            image.image = [UIImage imageNamed:[imageary objectAtIndex:i]];
            [_scv addSubview:image];
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 3, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            [button addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
            [_scv addSubview:button];
            
            [userdf setObject:@"yindaoye" forKey:@"yindaoye"];
        }
    }else{
     [self gotomain];
    }
  
}

-(void)buttonclick{
    [self gotomain];
}

#pragma mark  跳到主页
-(void)gotomain
{
    NSMutableArray *viewcontrollarray = [[NSMutableArray alloc] initWithCapacity:0];
    
    MainViewController *mainview = [[MainViewController alloc] init];
    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:mainview];
    vc.tabBarItem.title = @"首页";
   // vc.tabBarItem.image = [UIImage imageNamed:@"shouyel"];
    vc.navigationBarHidden = YES;
    mainview.hidesBottomBarWhenPushed = YES;
    [viewcontrollarray addObject:vc];
    
    
    //BeautyItemsViewController *beautyitem = [[BeautyItemsViewController alloc] init];
    beautymennutViewController *beautyitem = [[beautymennutViewController alloc] init];
    vc = [[UINavigationController alloc] initWithRootViewController:beautyitem];
    vc.tabBarItem.title = @"美容项目";
    //vc.tabBarItem.image = [UIImage imageNamed:@"meirongn"];
    vc.navigationBarHidden = YES;
    beautyitem.hidesBottomBarWhenPushed = YES;
    [viewcontrollarray addObject:vc];
    
    
    BeautyExpertViewController *beautyexpert = [[BeautyExpertViewController alloc] init];
    vc = [[UINavigationController alloc] initWithRootViewController:beautyexpert];
    vc.tabBarItem.title = @"美容专家";
    //vc.tabBarItem.image = [UIImage imageNamed:@"zhuanjian"];
    vc.navigationBarHidden = YES;
    beautyexpert.hidesBottomBarWhenPushed = YES;
    [viewcontrollarray addObject:vc];
    
    
    PersonDoctShooseViewController *personal = [[PersonDoctShooseViewController alloc] init];
    vc = [[UINavigationController alloc] initWithRootViewController:personal];
    vc.tabBarItem.title = @"个人中心";
    //vc.tabBarItem.image = [UIImage imageNamed:@"zhongxinn"];
    vc.navigationBarHidden = YES;
    personal.hidesBottomBarWhenPushed = YES;
    [viewcontrollarray addObject:vc];
    
    AboutViewController *about = [[AboutViewController alloc] init];
    vc = [[UINavigationController alloc] initWithRootViewController:about];
    vc.tabBarItem.title = @"更多页面";
    //vc.tabBarItem.image = [UIImage imageNamed:@"hhn"];
    vc.navigationBarHidden = YES;
    about.hidesBottomBarWhenPushed = YES;
    [viewcontrollarray addObject:vc];
    
    UITabBarController *tabBarcontroll = [[UITabBarController alloc] init];
    tabBarcontroll.viewControllers = viewcontrollarray;
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = tabBarcontroll;

    tabBarcontroll.tabBar.frame= CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 40);
   
//    BottomBarView *botom = [[BottomBarView alloc] initWithFrame:CGRectMake(0,self.view.bounds.size.height - 40, self.view.bounds.size.width, 40)];
//    [app.window addSubview:botom];

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
