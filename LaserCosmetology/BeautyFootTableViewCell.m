//
//  BeautyFootTableViewCell.m
//  聚美医
//
//  Created by fenghuang on 15/7/13.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "BeautyFootTableViewCell.h"

@implementation BeautyFootTableViewCell

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

        //足迹部分
        
        self.hengimage = [[UIImageView alloc] init];
        [self addSubview:self.hengimage];
        
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

    }
    
    return self;
}

-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}

@end
