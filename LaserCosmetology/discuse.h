//
//  discuse.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface discuse : UIView

@property(nonatomic,retain)UILabel *oneame;
@property(nonatomic,retain)UILabel *Replys;
@property(nonatomic,retain)UILabel *contents;

-(id)initWithFrame:(CGRect)frame and:(NSArray *)discuseary;

@end
