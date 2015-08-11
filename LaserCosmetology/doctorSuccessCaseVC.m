//
//  doctorSuccessCaseVC.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "doctorSuccessCaseVC.h"
#import "TopBarView.h"
#import "StarBeautycell.h"
#import "zhuanjiashuju.h"
#import "doctorSuccessdetaile.h"
@interface doctorSuccessCaseVC ()

@end

@implementation doctorSuccessCaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"更多案例";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(doctorSuccessCaseVCgobackclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
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
#pragma mark---点击事件
-(void)doctorSuccessCaseVCgobackclick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReturnRefresh" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-- tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mydataarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    StarBeautycell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[StarBeautycell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    zhuanjiashuju *zj = [self.mydataarray objectAtIndex:indexPath.row];
    
    cell.projectname.text = zj.Title;
    cell.projectcontents.text = zj.Remark;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    zhuanjiashuju *zj = [self.mydataarray objectAtIndex:indexPath.row];
    doctorSuccessdetaile *doctor = [[doctorSuccessdetaile alloc] init];
    doctor.sno = zj.Sno;
    [self.navigationController pushViewController:doctor animated:YES];
}

@end
