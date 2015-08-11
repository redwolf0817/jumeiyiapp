//
//  MaiTabieTableViewCell.h
//  聚美医
//
//  Created by fenghuang on 15/7/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaiTabieTableViewCell : UITableViewCell
//{
//    NSTimer *timer;
//}
//scrollview图片
@property(nonatomic,retain)UIImageView *hengimage;
@property(nonatomic,retain)UIView *Cellview;

//项目类别图片
@property(nonatomic,retain)UIButton *btItemerimageurl1;
@property(nonatomic,retain)UIButton *btItemerimageurl2;
@property(nonatomic,retain)UIButton *btItemerimageurl3;
@property(nonatomic,retain)UIButton *btItemerimageurl4;
@property(nonatomic,retain)UIButton *btItemerimageurl5;
@property(nonatomic,retain)UIButton *btItemerimageurl6;
@property(nonatomic,retain)UIButton *btItemerimageurl7;
@property(nonatomic,retain)UIButton *btItemerimageurl8;
//足迹
@property(nonatomic,retain)UIImageView *PersonerheadimageUrl;
@property(nonatomic,retain)UILabel *PersonernameStr;
@property(nonatomic,retain)UILabel *LocationStr;
@property(nonatomic,retain)UIImageView *Locationimage;
@property(nonatomic,retain)UIImageView *PersonerimageStr1;
@property(nonatomic,retain)UIImageView *PersonerimageStr2;
@property(nonatomic,retain)UIImageView *projectimage;
@property(nonatomic,retain)UILabel *projecttype;
@property(nonatomic,retain)UILabel *doctorname;
@property(nonatomic,retain)UILabel *hostadress;
@property(nonatomic,retain)UILabel *contentexts;
@property(nonatomic,retain)UILabel *Pingluncuonts;
@property(nonatomic,retain)UIImageView *Pinglunimage;
@property(nonatomic,retain)UILabel *Liulancuonts;
@property(nonatomic,retain)UIImageView *Liulanimage;

@property(nonatomic,retain)UIImageView *cheke;
@property(nonatomic,retain)UILabel *chemore;
@end
