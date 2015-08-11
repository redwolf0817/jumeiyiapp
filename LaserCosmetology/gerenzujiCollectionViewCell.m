//
//  gerenzujiCollectionViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/21.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "gerenzujiCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation gerenzujiCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.fengexian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.bounds.size.width, 5)];
        [self addSubview:self.fengexian];
        
        self.imageurl1 = [[UIImageView alloc] init];
        [self addSubview:self.imageurl1];
        
        self.imageurl2 = [[UIImageView alloc] init];
        [self addSubview:self.imageurl2];
        
        self.imageurl3 = [[UIImageView alloc] init];
        [self addSubview:self.imageurl3];
        
        self.imageurl4 = [[UIImageView alloc] init];
        [self addSubview:self.imageurl4];
        
        self.imageurl5 = [[UIImageView alloc] init];
        [self addSubview:self.imageurl5];
        
        self.imageurlpistr = [[UIImageView alloc] init];
        [self addSubview:self.imageurlpistr];
        
        self.imageurlpistr2 = [[UIImageView alloc] init];
        [self addSubview:self.imageurlpistr2];
        
        self.imagebtn1 = [[UIButton alloc] init];
        [self.imagebtn1 addTarget:self action:@selector(imagebuttonclick:) forControlEvents:UIControlEventTouchUpInside];
        self.imagebtn1.tag = 10;
        self.imagebtn1.userInteractionEnabled = NO;
        [self addSubview:self.imagebtn1];
        
        self.imagebtn2 = [[UIButton alloc] init];
        [self.imagebtn2 addTarget:self action:@selector(imagebuttonclick:) forControlEvents:UIControlEventTouchUpInside];
        self.imagebtn2.tag = 11;
        self.imagebtn2.userInteractionEnabled = NO;
        [self addSubview:self.imagebtn2];
        
        self.imagebtn3 = [[UIButton alloc] init];
        [self.imagebtn3 addTarget:self action:@selector(imagebuttonclick:) forControlEvents:UIControlEventTouchUpInside];
        self.imagebtn3.tag = 12;
        self.imagebtn3.userInteractionEnabled = NO;
        [self addSubview:self.imagebtn3];
        
        self.imagebtn4 = [[UIButton alloc] init];
        [self.imagebtn4 addTarget:self action:@selector(imagebuttonclick:) forControlEvents:UIControlEventTouchUpInside];
        self.imagebtn4.tag = 13;
        self.imagebtn4.userInteractionEnabled = NO;
        [self addSubview:self.imagebtn4];
        
        self.imagebtn5 = [[UIButton alloc] init];
        [self.imagebtn5 addTarget:self action:@selector(imagebuttonclick:) forControlEvents:UIControlEventTouchUpInside];
        self.imagebtn5.tag = 14;
        self.imagebtn5.userInteractionEnabled = NO;
        [self addSubview:self.imagebtn5];
        
        self.imagebtn6 = [[UIButton alloc] init];
        [self.imagebtn6 addTarget:self action:@selector(imagebuttonclick:) forControlEvents:UIControlEventTouchUpInside];
        self.imagebtn6.tag = 14;
        self.imagebtn6.userInteractionEnabled = NO;
        [self addSubview:self.imagebtn6];
        
        self.pinglunbuttonimage = [[UIImageView alloc] init];
        self.pinglunbuttonimage.image = [UIImage imageNamed:@"足迹详情_07"];
        [self addSubview:self.pinglunbuttonimage];
        
        self.button = [[UIButton alloc] init];
        [self.button setTitle:@"评论" forState:UIControlStateNormal];
        self.button.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.button setTitleColor:[self colorWithRGB:0x00c5bb alpha:1] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(pinglunbtnclicko:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        self.projectimage = [[UIImageView alloc] init];
        [self addSubview:self.projectimage];
        
        self.projecttype = [[UILabel alloc] init];
        self.projecttype.textColor = [self colorWithRGB:0x00c5bb alpha:1];
        [self addSubview:self.projecttype];
        
        self.doctorname = [[UILabel alloc] init];
        self.doctorname.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.doctorname];
        
        self.hospitol = [[UILabel alloc] init];
        [self addSubview:self.hospitol];
        
        self.myweillmake = [[UIImageView alloc] init];
        self.myweillmake.image = [UIImage imageNamed:@"足迹详情_03"];
        [self addSubview:self.myweillmake];
        
        self.mywillmake = [[UIButton alloc] init];
        [self.mywillmake setTitle:@"我要做" forState:UIControlStateNormal];
        [self.mywillmake setTitleColor:[self colorWithRGB:0x00c5bb alpha:1] forState:UIControlStateNormal];
        self.mywillmake.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.mywillmake addTarget:self action:@selector(mywillmakeclick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.mywillmake];
        
        self.CreateDt = [[UILabel alloc] init];
        self.CreateDt.font = [UIFont systemFontOfSize:14];
        self.CreateDt.textColor = [self colorWithRGB:0x00c5bb alpha:1];
        [self addSubview:self.CreateDt];
        
        self.Contents = [[UILabel alloc] init];
        self.Contents.numberOfLines = 2000;
        [self addSubview:self.Contents];
        
        self.pinglun = [[UIImageView alloc] init];
        self.pinglun.image = [UIImage imageNamed:@"pinglun"];
        [self addSubview:self.pinglun];
        
        self.DiscussCount = [[UILabel alloc] init];
        self.DiscussCount.text = @"0";
        self.DiscussCount.font = [UIFont systemFontOfSize:14];
        self.DiscussCount.textColor = [self colorWithRGB:0xec6941 alpha:1];
        [self addSubview:self.DiscussCount];
        
        self.liulan = [[UIImageView alloc] init];
        self.liulan.image = [UIImage imageNamed:@"liulan"];
        [self addSubview:self.liulan];
        
        self.ClickCount = [[UILabel alloc] init];
        self.ClickCount.font = [UIFont systemFontOfSize:14];
        self.ClickCount.text = @"0";
        self.ClickCount.textColor = [self colorWithRGB:0xec6941 alpha:1];
        [self addSubview:self.ClickCount];
        

        
    }
    return self;
}
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(self.bounds.size.width - 20,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    
    return gaodu;
}

-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}

-(void)pinglunbtnclicko:(UIButton *)btn
{

    UICollectionViewCell *cell = (UICollectionViewCell*) self;
    UICollectionView *table = (UICollectionView*)[self superview];
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"huoqusuoyin" object:str];
    
}
-(void)mywillmakeclick:(UIButton *)btn
{

    UICollectionViewCell *cell = (UICollectionViewCell*) self;
    UICollectionView *table = (UICollectionView*)[self  superview];
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mywillmark" object:str];
}

-(void)imagebuttonclick:(UIButton *)btn
{
    UICollectionViewCell *cell = (UICollectionViewCell*) self;
    UICollectionView *table = (UICollectionView*)[self  superview];
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    
    NSString *str = [NSString stringWithFormat:@"%ld/%ld",indexPath.row,btn.tag];
  
[[NSNotificationCenter defaultCenter] postNotificationName:@"imagebuttonclick" object:str];
}

@end
