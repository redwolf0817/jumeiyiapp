//
//  MoreGoodAtProjectVC.m
//  聚美医
//
//  Created by fenghuang on 15/6/25.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MoreGoodAtProjectVC.h"
#import "TopBarView.h"
#import "MoreGoodTableViewCell.h"
#import "Doctorpersents.h"
#import "Detailsproject2.h"
@interface MoreGoodAtProjectVC ()

@end

@implementation MoreGoodAtProjectVC

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
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 240, 25)];
    titilelable.text = @"更多擅长项目";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(moregood) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    self.mytableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    self.mytableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mytableview];
    
    
}
-(void)moregood
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.moerarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MoreGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MoreGoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    Doctorpersents *doct;
    if (self.moerarray.count > 0) {
        doct  = [self.moerarray objectAtIndex:indexPath.row];
    }

    
    cell.BeGoodToprojectName.frame = CGRectMake(10, 15, 150, 20);
    cell.BeGoodToprojectName.text = doct.BeautifyProName;
    cell.BeGoodToprojectName.textColor = [self colorWithRGB:0x666666 alpha:1];
    
    cell.chuxian2.frame = CGRectMake(self.view.bounds.size.width/2 - 30 , 15,1.50, 25);
    cell.chuxian2.image = [UIImage imageNamed:@"素材4"];
    
    cell.yifuwu.frame = CGRectMake(self.view.bounds.size.width/2 - 15, 15,  [self NSStringwithsize:17 str:@"已服务"], 20);
    cell.yifuwu.textColor = [self colorWithRGB:0x00c5bb alpha:1];
    cell.persentsnumber.frame = CGRectMake(self.view.bounds.size.width/2 - 15 + [self NSStringwithsize:17 str:@"已服务"],15, [self NSStringwithsize:17 str:doct.ServiceCount], 20);
    cell.persentsnumber.textColor = [self colorWithRGB:0x00c5bb alpha:1];
    cell.persentsnumber.text = doct.ServiceCount;
    
    cell.persents.frame = CGRectMake(self.view.bounds.size.width/2 - 15 + [self NSStringwithsize:17 str:@"已服务"] + [self NSStringwithsize:17 str:doct.ServiceCount], 15, 40, 20);
    cell.persents.textColor = [self colorWithRGB:0x00c5bb alpha:1];
    
    cell.begoodatcontents.frame = CGRectMake(self.view.bounds.size.width - 60, 12, 45, 25);
    cell.begoodatcontents.text = @" 预约";
    cell.begoodatcontents.textColor = [UIColor whiteColor];
    cell.begoodatcontents.backgroundColor = [self colorWithRGB:0x80e2dd alpha:1];
    cell.begoodatcontents.layer.masksToBounds = YES;
    cell.begoodatcontents.layer.cornerRadius = 3;
    

    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Doctorpersents *per = [self.moerarray objectAtIndex:indexPath.row];
    
    Detailsproject2 *proj = [[Detailsproject2 alloc] init];
    proj.sno = per.ProductSno;
    proj.EnumName = per.BeautifyProName;
    proj.doctorSno = self.doctorsno;
    proj.customerSno = self.customersno;
    proj.hostitalname = self.hospitalName;
    proj.doctorname = self.doctorname;
    [self.navigationController pushViewController:proj animated:YES];
    
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

-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}

@end
