//
//  MaiTabieTableViewCell.m
//  聚美医
//
//  Created by fenghuang on 15/7/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MaiTabieTableViewCell.h"

@implementation MaiTabieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //广告页
        self.Cellview = [[UIView alloc] init];
        [self addSubview:self.Cellview];

        self.hengimage = [[UIImageView alloc] init];
        [self addSubview:self.hengimage];
        
        //项目类别
        self.btItemerimageurl1 = [[UIButton alloc] init];
        [self addSubview:self.btItemerimageurl1];
        
        self.btItemerimageurl2 = [[UIButton alloc] init];
        [self addSubview:self.btItemerimageurl2];
        
        self.btItemerimageurl3 = [[UIButton alloc] init];
        [self addSubview:self.btItemerimageurl3];
        
        self.btItemerimageurl4 = [[UIButton alloc] init];
        [self addSubview:self.btItemerimageurl4];
        
        self.btItemerimageurl5 = [[UIButton alloc] init];
        [self addSubview:self.btItemerimageurl5];
        
        self.btItemerimageurl6 = [[UIButton alloc] init];
        [self addSubview:self.btItemerimageurl6];
        
        self.btItemerimageurl7 = [[UIButton alloc] init];
        [self addSubview:self.btItemerimageurl7];
        
        self.btItemerimageurl8 = [[UIButton alloc] init];
        [self addSubview:self.btItemerimageurl8];
        
        
        //足迹部分
        self.PersonerheadimageUrl = [[UIImageView alloc] init];
        [self addSubview:self.PersonerheadimageUrl];
        
        self.PersonernameStr = [[UILabel alloc] init];
        [self addSubview:self.PersonernameStr];
        
        self.LocationStr = [[UILabel alloc] init];
        [self addSubview:self.LocationStr];
        
        self.Locationimage = [[UIImageView alloc] init];
        [self addSubview:self.Locationimage];
        
        self.PersonerimageStr1 = [[UIImageView alloc] init];
        [self addSubview:self.PersonerimageStr1];
        
        self.PersonerimageStr2 = [[UIImageView alloc] init];
        [self addSubview:self.PersonerimageStr2];
        
        self.projectimage = [[UIImageView alloc] init];
        [self addSubview:self.projectimage];
        
        self.projecttype = [[UILabel alloc] init];
        self.projecttype.textColor = [self colorWithRGB:0x00c5bb alpha:1];
        [self addSubview:self.projecttype];
        
        self.doctorname = [[UILabel alloc] init];
        [self addSubview:self.doctorname];
        
        self.hostadress = [[UILabel alloc] init];
        [self addSubview:self.hostadress];
        
        self.contentexts = [[UILabel alloc] init];
        [self addSubview:self.contentexts];
        
        self.Pingluncuonts = [[UILabel alloc] init];
        [self addSubview:self.Pingluncuonts];
        
        self.Pinglunimage = [[UIImageView alloc] init];
        [self addSubview:self.Pinglunimage];
        
        self.Liulancuonts = [[UILabel alloc] init];
        [self addSubview:self.Liulancuonts];
        
        self.Liulanimage = [[UIImageView alloc] init];
        [self addSubview:self.Liulanimage];
        
        self.cheke = [[UIImageView alloc] init];
        [self addSubview:self.cheke];
        
        self.chemore = [[UILabel alloc] init];
        [self addSubview:self.chemore];
        self.chemore.alpha = 0.60;
    }
    
    return self;
}
-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}
//-(void)creatNSTimer
//{
//    if (timer == nil) {
//        timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timelinks) userInfo:nil repeats:YES];
//    }
//}

////定时器
//-(void)timelinks
//{
////    NSInteger a = [self.pagearray count];
////    static  int speed = 1;
////    
////    if (_pag.currentPage == (a - 1) || self.Pagect.currentPage == 0) {
////        speed = -speed;
////    }
////    
////    
////    self.Pagect.currentPage += speed;
////    self.Cellscrollview.contentOffset = CGPointMake((self.bounds.size.width) * self.Pagect.currentPage, 0);
////    NSLog(@"正在定时");
//}

@end

