//
//  SearchBarViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/18.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchBarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView *searchtablev;
@property(nonatomic,retain)NSMutableArray *searchrerustary;
@end
