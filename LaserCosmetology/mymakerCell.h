//
//  mymakerCell.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mymakerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phonenumber;
@property (weak, nonatomic) IBOutlet UILabel *object;
@property (weak, nonatomic) IBOutlet UILabel *maketiem;
@property (weak, nonatomic) IBOutlet UILabel *tiemess;

@property (weak, nonatomic) IBOutlet UILabel *shijianzhou1;
@property (weak, nonatomic) IBOutlet UILabel *shijianzhou2;
@property (weak, nonatomic) IBOutlet UILabel *shijianzhou3;

@property (weak, nonatomic) IBOutlet UIImageView *shijianimage1;
@property (weak, nonatomic) IBOutlet UIImageView *shijianimage2;
@property (weak, nonatomic) IBOutlet UIImageView *shijianimage3;

@property (weak, nonatomic) IBOutlet UIButton *binglibtn;

- (IBAction)upbingli:(id)sender;

@end
