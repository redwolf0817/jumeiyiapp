//
//  MyAppointmentCollectionVC.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/30.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MyAppointmentCollectionVC.h"
#import "UIImageView+WebCache.h"

@implementation MyAppointmentCollectionVC

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        UIImageView *backgroudimage = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroudimage.image = [UIImage imageNamed:@"meirongzhuanjia_0304"];
        backgroudimage.userInteractionEnabled = YES;
        [self addSubview:backgroudimage];
        
        self.imageurlstr = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10,  self.bounds.size.width/3 , 110)];
        [self addSubview:self.imageurlstr];
        
        self.zhuanjia = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 15, 55, 50, 20)];
        self.zhuanjia.font = [UIFont systemFontOfSize:16];
        self.zhuanjia.text = @"专家:";
        [self addSubview:self.zhuanjia];
        
        self.xingming = [[UILabel alloc] initWithFrame:CGRectMake(5, 5,self.bounds.size.width ,20)];
        self.xingming.numberOfLines = 2000;
        self.xingming.backgroundColor = [UIColor clearColor];
        self.xingming.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.xingming];
        
        self.xiangmu = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 15,20, self.bounds.size.width/2, 20)];
        self.xiangmu.text = @"项目:";
        self.xiangmu.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.xiangmu];
        
        self.xiangmuming = [[UILabel alloc] initWithFrame:CGRectMake(10 + 40, 25, 50, 20)];
        self.xiangmuming.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.xiangmuming];
    
//        
//        self.shijian = [[UILabel alloc] initWithFrame:CGRectMake(5, 135, 50, 20)];
//        self.shijian.font = [UIFont systemFontOfSize:16];
//        [self addSubview:self.shijian];
        
        self.shijianshu = [[UILabel alloc] initWithFrame:CGRectMake(80, 65 , 50, 20)];
        self.shijianshu.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.shijianshu];
        
        self.didian = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 15, 90, 50, 20)];
        self.didian.text = @"地点:";
        self.didian.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.didian];
        
        self.didianstr = [[UILabel alloc] initWithFrame:CGRectMake(80, 170 , 50, 20)];
        self.didianstr.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.didianstr];
        

        self.pjbutton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 60, self.zhuanjia.frame.origin.y, 60, 25)];
        [self.pjbutton setTitle:@"评价" forState:UIControlStateNormal];
        self.pjbutton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.pjbutton addTarget:self action:@selector(pinglunbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        self.pjbutton.layer.masksToBounds = YES;
        self.pjbutton.layer.cornerRadius = 3;
        [self addSubview:self.pjbutton];

        
        self.cancelbutton = [[UIButton alloc] init];
        [self.cancelbutton addTarget:self action:@selector(cancelbuttonclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelbutton];
        
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

-(void)pinglunbtnclick:(UIButton *)btn
{
    
    UICollectionViewCell *cell = (UICollectionViewCell*) self;
    UICollectionView *table = (UICollectionView*)[self superview];
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tunruning" object:str];
    
}

-(void)cancelbuttonclick{
    
    NSLog(@"点击了预约的取消按钮");
    
    UICollectionViewCell *cell = (UICollectionViewCell*) self;
    UICollectionView *table = (UICollectionView*)[self superview];
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelclick" object:str];
}

@end
