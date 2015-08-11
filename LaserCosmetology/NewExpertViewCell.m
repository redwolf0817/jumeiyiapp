//
//  NewExpertViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "NewExpertViewCell.h"

@implementation NewExpertViewCell

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
        
        self.backimage = [[UIImageView alloc] init];
        self.backimage.userInteractionEnabled = YES;
        [self addSubview:self.backimage];
        
        self.headimage = [[UIImageView alloc] init];
        [self addSubview:self.headimage];

        self.chuxian = [[UIImageView alloc] init];
        [self addSubview:self.chuxian];

        self.diheng1 = [[UIImageView alloc] init];
        [self addSubview:self.diheng1];
        
        self.name = [[UILabel alloc] init];
        self.name.font = [UIFont systemFontOfSize:17];
        self.name.textColor = [self colorWithRGB:0x666666 alpha:1];
        [self addSubview:self.name];
        
        self.Post = [[UILabel alloc] init];
        self.Post.font = [UIFont systemFontOfSize:17];
        self.Post.textColor = [self colorWithRGB:0x00c5bb alpha:1];
        [self addSubview:self.Post];
        
        self.Area = [[UILabel alloc] init];
        self.Area.font = [UIFont systemFontOfSize:14];
        self.Area.textColor = [self colorWithRGB:0x999999 alpha:1];
        [self addSubview:self.Area];
        
        self.publicpost = [[UILabel alloc] init];
        self.publicpost.font = [UIFont systemFontOfSize:14];
        self.publicpost.textColor = [UIColor whiteColor];
        [self addSubview:self.publicpost];
        
        self.PayAttentionTo = [[UIButton alloc] init];
        [self.PayAttentionTo addTarget:self action:@selector(PayAttentionToclik) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.PayAttentionTo];
        
        
        
        self.contents = [[UILabel alloc] init];
        [self addSubview:self.contents];
        
        self.grecolorimage = [[UIImageView alloc] init];
        [self addSubview:self.grecolorimage];
        
        self.xiaohengxian = [[UIImageView alloc] init];
        [self addSubview:self.xiaohengxian];
        
        self.btnview = [[UIView alloc] init];
        [self addSubview:self.btnview];
        
        self.btnimage = [[UIImageView alloc] init];
        self.btnimage.userInteractionEnabled = YES;
        [self.btnview addSubview:self.btnimage];
                
        self.redingall = [[UIButton alloc] init];
        [self.btnview addSubview:self.redingall];
        
        self.gerenjieshao = [[UILabel alloc] init];
        [self addSubview:self.gerenjieshao];
        
        self.diheng2 = [[UIImageView alloc] init];
        [self addSubview:self.diheng2];
        
        
        
        self.succesgrecolorimage = [[UIImageView alloc] init];
        [self addSubview:self.succesgrecolorimage];
        
        self.xiaohengxian2 = [[UIImageView alloc] init];
        [self addSubview:self.xiaohengxian2];
        
        self.xiaohengxian3 = [[UIImageView alloc] init];
        [self addSubview:self.xiaohengxian3];
        
        self.succesimage1 = [[UIImageView alloc] init];
        [self addSubview:self.succesimage1];
        
        self.chenggonganli = [[UILabel alloc] init];
        [self addSubview:self.chenggonganli];
        
        self.succesimage2 = [[UIImageView alloc] init];
        [self addSubview:self.succesimage2];
        
        self.xiangmu = [[UILabel alloc] init];
        [self addSubview:self.xiangmu];
        
        self.succeprojectcontents = [[UILabel alloc] init];
        [self addSubview:self.succeprojectcontents];
        
        self.miaoshu = [[UILabel alloc] init];
        [self addSubview:self.miaoshu];
        
        self.diheng3 = [[UIImageView alloc] init];
        [self addSubview:self.diheng3];
        
        
        
        self.BeGoodToBackImage = [[UIImageView alloc] init];
        [self addSubview:self.BeGoodToBackImage];
        
        self.xiaohengxian4 = [[UIImageView alloc] init];
        [self addSubview:self.xiaohengxian4];
        
        self.BeGoodToprojectName = [[UILabel alloc] init];
        [self addSubview:self.BeGoodToprojectName];
        
        self.morebtn = [[UIButton alloc] init];
        [self addSubview:self.morebtn];
        
        self.yifuwu = [[UILabel alloc] init];
        self.yifuwu.text = @"已服务";
        [self addSubview:self.yifuwu];
        
        self.persentsnumber = [[UILabel alloc] init];
        [self addSubview:self.persentsnumber];
        
        self.persents = [[UILabel alloc] init];
        self.persents.text = @"人";
        [self addSubview:self.persents];
        
        self.begoodatcontents = [[UILabel alloc] init];
        [self addSubview:self.begoodatcontents];
        
        self.shanchang = [[UILabel alloc] init];
        [self addSubview:self.shanchang];

        self.chuxian2 = [[UIImageView alloc] init];
        [self addSubview:self.chuxian2];
        
        
        
        self.diheng4 = [[UIImageView alloc] init];
        [self addSubview:self.diheng4];
        
        self.Communicatebtn = [[UIButton alloc] init];
        [self.Communicatebtn addTarget:self action:@selector(Communicatebtnclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.Communicatebtn];
        
        
    }
    
    return self;
}

-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}

-(void)PayAttentionToclik{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhiguanzhu" object:nil];
}
-(void)Communicatebtnclick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Communicate" object:nil];
}

@end


