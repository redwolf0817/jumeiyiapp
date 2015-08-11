//
//  caremuban.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface caremuban : UIView


@property(nonatomic,retain)UIView *myview;

@property(nonatomic,retain)UIImageView *lefetimage;

@property(nonatomic,retain)UILabel *lefetcontents;


-(id)initWithFrame:(CGRect)frame andcontents:(NSString *)contents;
@end
