//
//  SearchBarViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/18.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "SearchBarViewController.h"
#import "TopBarView.h"
#import "Beautyitems.h"
#import "Detailsproject.h"
@interface SearchBarViewController ()

@end

@implementation SearchBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 300, 25)];
    titilelable.text = @"搜索结果";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(searchback) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    
    self.searchtablev = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.searchtablev.delegate = self;
    self.searchtablev.dataSource = self;
    [self.view addSubview:self.searchtablev];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchrerustary.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Beautyitems *beauty = [self.searchrerustary objectAtIndex:indexPath.row];
    
    cell.textLabel.text = beauty.ProName;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Beautyitems *beauty = [self.searchrerustary objectAtIndex:indexPath.row];
    
    Detailsproject *details = [[Detailsproject alloc] init];
    details.sno = beauty.ProSno;
    details.EnumName = beauty.ProName;
    details.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:details animated:YES];
    
}
-(void)searchback
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
