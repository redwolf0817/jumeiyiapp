//
//  MeiRongZuJiCollectionviewcell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/1.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MeiRongZuJiCollectionviewcell.h"

@implementation MeiRongZuJiCollectionviewcell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.imageurlstr1 = [[UIImageView alloc] initWithFrame:CGRectMake(5 , 5,  (self.bounds.size.width - 30)/2, 160)];
        [self addSubview:self.imageurlstr1];
        
        self.imageurlstr2 = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (self.bounds.size.width - 30)/2, 5,  (self.bounds.size.width - 15)/2, 160)];
        [self addSubview:self.imageurlstr2];
        
        self.imagefenge = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,  0, 0)];
        [self addSubview:self.imagefenge];
        
        self.CreateDt = [[UILabel alloc] initWithFrame:CGRectMake(10,  self.imageurlstr1.frame.origin.y + 175, self.bounds.size.width/2, 20)];
        self.CreateDt.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.CreateDt];
        
        self.Contents = [[UILabel alloc] initWithFrame:CGRectMake(5, self.imageurlstr1.frame.origin.y + 170,self.bounds.size.width ,20)];
        self.Contents.numberOfLines = 2000;
        self.Contents.backgroundColor = [UIColor clearColor];
        [self addSubview:self.Contents];
        
        
        self.pinglun = [[UILabel alloc] initWithFrame:CGRectMake(10, self.Contents.frame.origin.y + 170, 50, 20)];
        self.pinglun.text = @"评论:";
        self.pinglun.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.pinglun];
        
        self.DiscussCount = [[UILabel alloc] initWithFrame:CGRectMake(10 + 40, self.Contents.frame.origin.y + 170, 50, 20)];
        self.DiscussCount.text = @"0";
        self.DiscussCount.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.DiscussCount];
        
        self.liulan = [[UILabel alloc] initWithFrame:CGRectMake(80, self.Contents.frame.origin.y + 170 , 50, 20)];
        self.liulan.font = [UIFont systemFontOfSize:15];
        self.liulan.text = @"浏览:";
        [self addSubview:self.liulan];
        
        self.ClickCount = [[UILabel alloc] initWithFrame:CGRectMake(80 + 40, self.Contents.frame.origin.y + 170 , 50, 20)];
        self.ClickCount.font = [UIFont systemFontOfSize:15];
        self.ClickCount.text = @"0";
        [self addSubview:self.ClickCount];
        
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 60, self.Contents.frame.origin.y + 170, 60, 25)];
        [self.button setTitle:@"删除" forState:UIControlStateNormal];
        self.button.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        
        
    }
    return self;
}
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = CGSizeMake(self.bounds.size.width - 20,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    
    return gaodu;
}

-(void)shanchu:(UIButton *)btn
{
    
    
    UICollectionViewCell *cell = (UICollectionViewCell*) self;
    UICollectionView *table = (UICollectionView*)[self superview];
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shanchu" object:str];
    
}

@end
