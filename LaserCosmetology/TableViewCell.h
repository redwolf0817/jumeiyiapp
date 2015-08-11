//
//  TableViewCell.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property(nonatomic,retain)UIImageView *headimage;

@property(nonatomic,retain)UILabel *productornametext;
@property(nonatomic,retain)UILabel *fuwushijiantext;
@property(nonatomic,retain)UILabel *doctortext;
@property(nonatomic,retain)UILabel *Hospitaltext;

@property(nonatomic,retain)UILabel *shichangjia;
@property(nonatomic,retain)UILabel *youhuijia;

@property(nonatomic,retain)UILabel *jiaoyizhuangtai;
@property(nonatomic,retain)UIButton *qianggou;
@end
