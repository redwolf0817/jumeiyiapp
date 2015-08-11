//
//  ChatWithTheDoctor.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/13.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatWithTheDoctor : UIView

@property(nonatomic,retain)UIView *myview;

@property(nonatomic,retain)UIImageView *lefetimage;
@property(nonatomic,retain)UIImageView *rigthimage;

@property(nonatomic,retain)UILabel *lefetcontents;
@property(nonatomic,retain)UILabel *rigthcontents;

@property(nonatomic,retain)UIImageView *lefetPhoto;
@property(nonatomic,retain)UIImageView *rigthPhoto;

-(id)initWithFrame:(CGRect)frame andwidth:(CGFloat)width tyfrom:(NSString *)tyfrom andcontents:(NSString *)contents creatdate:(NSString *)creatdate andimages:(NSData *)imagesData filetype:(NSString *)filetype;

@end
