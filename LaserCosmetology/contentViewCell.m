//
//  contentViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/23.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "contentViewCell.h"

@implementation contentViewCell

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
    
        self.backgroudimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 120)];
        //self.backgroudimage.image = [UIImage imageNamed:@"美容专家_0ss3.png"];
        self.backgroudimage.userInteractionEnabled = YES;
        self.backgroudimage.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroudimage];
        
        self.headimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        self.headimage.layer.cornerRadius = 55;
        self.headimage.layer.masksToBounds = YES;
        [self.backgroudimage addSubview:self.headimage];
        
        self.peoplename = [[UILabel alloc] initWithFrame:CGRectMake(125, 10, 80, 20)];
        self.peoplename.font = [UIFont systemFontOfSize:16];
         self.peoplename.textColor = [self colorWithRGB:0x666666 alpha:1];
        [self.backgroudimage addSubview:self.peoplename];
        
        self.postname = [[UILabel alloc] init];
        self.postname.font = [UIFont systemFontOfSize:14];
        self.postname.textColor = [self colorWithRGB:0x00c5bb alpha:1];
        [self.backgroudimage addSubview:self.postname];
        
        self.fuwu = [[UILabel alloc] init];
        self.fuwu.text = @"服务:";
        self.fuwu.font = [UIFont systemFontOfSize:13];
        self.fuwu.textColor = [self colorWithRGB:0x00c5bb alpha:1];
        [self.backgroudimage addSubview:self.fuwu];
        
        
        self.servernumber = [[UILabel alloc] init];
        self.servernumber.textColor = [self colorWithRGB:0x00c5bb alpha:1];
        self.servernumber.font = [UIFont systemFontOfSize:13];
        [self.backgroudimage addSubview:self.servernumber];
        
        
        self.people = [[UILabel alloc] init];
        self.people.text = @"人";
        self.people.textColor = [self colorWithRGB:0x00c5bb alpha:1];
        self.people.font = [UIFont systemFontOfSize:13];
        [self.backgroudimage addSubview:self.people];
        
        
        self.begoodat = [[UILabel alloc] initWithFrame:CGRectMake(125, 25, 60, 20)];
        self.begoodat.text = @"擅长:";
        self.begoodat.font = [UIFont systemFontOfSize:14];
        self.begoodat.textColor = [self colorWithRGB:0x666666 alpha:1];
        [self.backgroudimage addSubview:self.begoodat];

        
        self.begoodatto1 = [[UILabel alloc] init];
        self.begoodatto1.textColor = [self colorWithRGB:0x666666 alpha:1];
        self.begoodatto1.font = [UIFont systemFontOfSize:12];
        [self.backgroudimage addSubview:self.begoodatto1];
        //self.begoodatto1.backgroundColor = [self colorWithRGB:0x80e2dd alpha:1];
        
        self.begoodatto2 = [[UILabel alloc] init];
        self.begoodatto2.textColor = [self colorWithRGB:0xffffff alpha:1];
        self.begoodatto2.font = [UIFont systemFontOfSize:12];
        [self.backgroudimage addSubview:self.begoodatto2];
        self.begoodatto2.backgroundColor = [self colorWithRGB:0x80e2dd alpha:1];
        
        self.begoodatto3 = [[UILabel alloc] init];
        self.begoodatto3.textColor = [self colorWithRGB:0xffffff alpha:1];
        self.begoodatto3.font = [UIFont systemFontOfSize:12];
        [self.backgroudimage addSubview:self.begoodatto3];
        self.begoodatto3.backgroundColor = [self colorWithRGB:0x80e2dd alpha:1];
        
        
        self.judgeimage1 = [[UIImageView alloc] initWithFrame:CGRectMake(125 , 85, 12, 12)];
        [self.backgroudimage addSubview:self.judgeimage1];
        
        self.judgeimage2 = [[UIImageView alloc] initWithFrame:CGRectMake(125, 85, 12, 12)];
        [self.backgroudimage addSubview:self.judgeimage2];
        
        self.judgeimage3= [[UIImageView alloc] initWithFrame:CGRectMake(125 , 85, 12, 12)];
        [self.backgroudimage addSubview:self.judgeimage3];
        
        self.judgeimage4 = [[UIImageView alloc] initWithFrame:CGRectMake(125 , 85, 12, 12)];
        [self.backgroudimage addSubview:self.judgeimage4];
        
        self.judgeimage5 = [[UIImageView alloc] initWithFrame:CGRectMake(125 , 85, 12, 12)];
        [self.backgroudimage addSubview:self.judgeimage5];
        
        
        self.hospitalname = [[UILabel alloc] initWithFrame:CGRectMake(125 , 110, 150, 20)];
        self.hospitalname.text = @"武汉爱美美容医院";
        self.hospitalname.textColor = [self colorWithRGB:0x999999 alpha:1];
        self.hospitalname.font = [UIFont systemFontOfSize:14];
        [self.backgroudimage addSubview:self.hospitalname];

    }
    
    return self;
    
}

-(void)choosebuttonclick:(UIButton *)btn{
    
//    mybutton *button = (mybutton *)[self viewWithTag:10];
//    if (btn.isclick == YES) {
//        [button setBackgroundImage:[UIImage imageNamed:@"duigouh"] forState:UIControlStateNormal];
//        btn.isclick = NO;
//    }else{
//        [button setBackgroundImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
//        
//        btn.isclick = YES;
//    }
    
}

-(float)NSStringwithsize:(int )a str:(NSString *)string
{
    
    UIFont *font = [UIFont systemFontOfSize:a];
    
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat strwidth = size.width;
    
    return strwidth;
}

-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}
    
@end
