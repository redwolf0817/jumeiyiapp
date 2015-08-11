//
//  customerViewCell.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/10.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customerViewCell : UITableViewCell
@property (retain, nonatomic)  UILabel *phonenumber;
@property (retain, nonatomic)  UIImageView *xing1;
@property (retain, nonatomic)  UIImageView *xing2;
@property (retain, nonatomic)  UIImageView *xing3;
@property (retain, nonatomic)  UIImageView *xing4;
@property (retain, nonatomic)  UIImageView *xing5;
@property (retain, nonatomic)  UILabel *contents;
@property (retain, nonatomic)  UILabel *retunstring;
@property (retain, nonatomic)  UILabel *dates;
@property (retain, nonatomic)  UIButton *huifu;
- (void)huifu:(UIButton *)sender;

@end
