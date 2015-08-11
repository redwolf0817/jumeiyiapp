//
//  CLCollectionViewCell.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/6.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLCollectionViewCell : UICollectionViewCell

@property(nonatomic,retain)UIImageView *immagg;
@property(nonatomic,retain)UILabel *namelable;
@property(nonatomic,retain)UILabel *prilable;
@property(nonatomic,retain)UILabel *prilablenumber;
@property(nonatomic,retain)UILabel *prilablelater;
@property(nonatomic,retain)UILabel *hotlable;
@property(nonatomic,retain)UILabel *hotlablenumber;
@property(nonatomic,retain)UILabel *hotlablelater;

@property(nonatomic,assign)int font;


@end
