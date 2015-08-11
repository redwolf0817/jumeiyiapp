//
//  CashCouponVCCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/21.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "CashCouponVCCell.h"

@implementation CashCouponVCCell

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
        
        UIImageView *dise = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width + 100, 130)];
        dise.image = [UIImage imageNamed:@"huidi"];
        dise.userInteractionEnabled = YES;
        [self addSubview:dise];
        
        UIView *whiteColorview = [[UIView alloc] init];
        whiteColorview.backgroundColor = [UIColor whiteColor];
        whiteColorview.frame = CGRectMake(10, 10, 375 - 20, 120);
        whiteColorview.layer.masksToBounds = YES;
        whiteColorview.layer.cornerRadius = 10;
        [self addSubview:whiteColorview];
        
        self.redimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 120)];
        self.redimage.image = [UIImage imageNamed:@"youhuiquanhongse"];
        [whiteColorview addSubview:self.redimage];
        
        self.xiangmuleibie = [[UILabel alloc] init];
        self.xiangmuleibie.font = [UIFont systemFontOfSize:18];
        self.xiangmuleibie.frame = CGRectMake(20, 10, 160, 20);
        //self.xiangmuleibie.text = @"(项目类别)";
        self.xiangmuleibie.textColor = [UIColor whiteColor];
        [whiteColorview addSubview:self.xiangmuleibie];
        
        self.jine = [[UILabel alloc] init];
        self.jine.textColor = [UIColor redColor];
        self.jine.font = [UIFont systemFontOfSize:27];
        self.jine.frame = CGRectMake(20, 30, 120 , 40);
        //self.jine.text = @"100元";
        self.jine.textColor = [UIColor whiteColor];
        [whiteColorview addSubview:self.jine];

        self.qixian = [[UILabel alloc] init];
        self.qixian.font = [UIFont systemFontOfSize:17];
        self.qixian.frame = CGRectMake(17 , 70, 120, 20);
       // self.qixian.text = @"使用期限:";
        self.qixian.textColor = [UIColor whiteColor];
        [whiteColorview addSubview:self.qixian];
        
        self.date = [[UILabel alloc] init];
        self.date.font = [UIFont systemFontOfSize:15];
        self.date.frame = CGRectMake(20, 90, 160 , 20);
       // self.date.text = @"2020.40.31";
        self.date.textColor = [UIColor whiteColor];
        [whiteColorview addSubview:self.date];
        
       self.erweima = [[UIImageView alloc] initWithFrame:CGRectMake(200, 30, 80, 80)];
        //self.erweima.image = [UIImage imageNamed:@"huisebiaofebge"];
        [whiteColorview addSubview:self.erweima];

        self.laokehu = [[UILabel alloc] init];
        self.laokehu.font = [UIFont systemFontOfSize:15];
        self.laokehu.textColor = [UIColor blackColor];
        self.laokehu.frame = CGRectMake(250, 10, 140, 20);
        self.laokehu.text = @"老客户回馈:";
        [whiteColorview addSubview:self.laokehu];
        
        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}
-(void)qianggoubtnclick:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell*) [[btn superview] superview];
    UITableView *table = (UITableView*)[[[[btn superview] superview] superview] superview];
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"qianggou" object:[NSString stringWithFormat:@"%ld",indexPath.row]];
}

//计算字体长度
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


@end
