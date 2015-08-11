//
//  SuccesViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView *mytableview;
@property(nonatomic,retain)NSMutableArray *succesary;
@property(nonatomic,retain)NSString *doctorsno;
@end
