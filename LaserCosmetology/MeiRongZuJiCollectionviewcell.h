//
//  MeiRongZuJiCollectionviewcell.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/1.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeiRongZuJiCollectionviewcell : UICollectionViewCell

@property(nonatomic,retain)UIImageView *imageurlstr1;
@property(nonatomic,retain)UIImageView *imageurlstr2;
@property(nonatomic,retain)UIImageView *imagefenge;

@property(nonatomic,retain)NSString *PicHeight;
@property(nonatomic,retain)UILabel *Contents;
@property(nonatomic,retain)UILabel *CreateDt;

@property(nonatomic,retain)UILabel *pinglun;
@property(nonatomic,retain)UILabel *DiscussCount;

@property(nonatomic,retain)UILabel *liulan;
@property(nonatomic,retain)UILabel *ClickCount;

@property(nonatomic,retain)UIButton *button;
@property(nonatomic,retain)NSMutableArray *picarray;

@end
