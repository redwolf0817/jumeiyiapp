//
//  GuestbookCell.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/10.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuestbookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *customename;
@property (weak, nonatomic) IBOutlet UILabel *bookcontents;
@property (weak, nonatomic) IBOutlet UILabel *notrechis;
@property (weak, nonatomic) IBOutlet UILabel *thetiems;
@property (weak, nonatomic) IBOutlet UIView *views;

@end
