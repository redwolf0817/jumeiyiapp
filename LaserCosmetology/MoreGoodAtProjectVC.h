//
//  MoreGoodAtProjectVC.h
//  聚美医
//
//  Created by fenghuang on 15/6/25.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreGoodAtProjectVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView *mytableview;
@property(nonatomic,retain)NSMutableArray *moerarray;

@property(nonatomic,retain)NSString *doctorsno;
@property(nonatomic,retain)NSString *customersno;
@property(nonatomic,retain)NSString *hospitalName;
@property(nonatomic,retain)NSString *doctorname;

@end
