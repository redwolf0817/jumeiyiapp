//
//  CustomerCareCell.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/10.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerCareCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *productorname;
@property (weak, nonatomic) IBOutlet UILabel *timers;
@property (weak, nonatomic) IBOutlet UIImageView *guanhuai;
@property (weak, nonatomic) IBOutlet UIView *VIEWS;
- (IBAction)button:(id)sender;

@end
