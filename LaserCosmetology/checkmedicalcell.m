//
//  checkmedicalcell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "checkmedicalcell.h"

@implementation checkmedicalcell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
     {
         self.datestring = [[UILabel alloc] init];
         self.datestring.text = @"123456";
         [self addSubview:self.datestring];
         
         self.images = [[UIImageView alloc] init];
         [self addSubview:self.images];
         
         
     }
    
    return self;
}
@end
