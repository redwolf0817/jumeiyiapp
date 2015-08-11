//
//  TableViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

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
        
        
        UIImageView *dise = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width + 100, 200)];
        dise.image = [UIImage imageNamed:@"huidi"];
        dise.userInteractionEnabled = YES;
        [self addSubview:dise];
        
        UIView *whiteColorview = [[UIView alloc] init];
        whiteColorview.backgroundColor = [UIColor whiteColor];
        whiteColorview.frame = CGRectMake(0, 5, 375 - 20, 190);
        whiteColorview.layer.masksToBounds = YES;
        [self addSubview:whiteColorview];
        
        
        self.headimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 115, 100)];
        self.headimage.image = [UIImage imageNamed:@"sy_03"];
        self.headimage.layer.masksToBounds = YES;
        self.headimage.layer.cornerRadius = 5;
        [whiteColorview addSubview:self.headimage];

        UILabel *productorname = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 100, 20)];
        productorname.text = @"";
        productorname.font = [UIFont systemFontOfSize:14];
        [whiteColorview addSubview:productorname];
        
        self.productornametext = [[UILabel alloc] init];
        self.productornametext.font = [UIFont systemFontOfSize:15];
        self.productornametext.frame = CGRectMake([self NSStringwithsize:14 str:productorname.text] + 140, 5, 320 - ([self NSStringwithsize:14 str:productorname.text] + 140), 20);
        [whiteColorview addSubview:self.productornametext];
        
       
        UILabel *fuwushijian = [[UILabel alloc] initWithFrame:CGRectMake(140, 30, 100, 20)];
        fuwushijian.text = @"";
        fuwushijian.font = [UIFont systemFontOfSize:15];
        [whiteColorview addSubview:fuwushijian];
        
        self.fuwushijiantext = [[UILabel alloc] init];
        self.fuwushijiantext.textColor = [UIColor redColor];
        self.fuwushijiantext.font = [UIFont systemFontOfSize:15];
        self.fuwushijiantext.frame = CGRectMake([self NSStringwithsize:17 str:fuwushijian.text] + 140, 30, self.bounds.size.width - [self NSStringwithsize:14 str:fuwushijian.text], 20);
        [whiteColorview addSubview:self.fuwushijiantext];
        
        UILabel *doctor = [[UILabel alloc] initWithFrame:CGRectMake(140, 55, 100, 20)];
        doctor.text = @"美容专家:";
        doctor.font = [UIFont systemFontOfSize:14];
        [whiteColorview addSubview:doctor];
        
        self.doctortext = [[UILabel alloc] init];
        self.doctortext.font = [UIFont systemFontOfSize:14];
        self.doctortext.frame = CGRectMake([self NSStringwithsize:17 str:doctor.text] + 140, 55, self.bounds.size.width - [self NSStringwithsize:14 str:doctor.text], 20);
        [whiteColorview addSubview:self.doctortext];
        
        UILabel *Hospital = [[UILabel alloc] initWithFrame:CGRectMake(140, 80, 100, 20)];
        Hospital.text = @"";
        Hospital.font = [UIFont systemFontOfSize:14];
        [whiteColorview addSubview:Hospital];
        
        self.Hospitaltext = [[UILabel alloc] init];
        self.Hospitaltext.font = [UIFont systemFontOfSize:14];
        self.Hospitaltext.frame = CGRectMake([self NSStringwithsize:17 str:Hospital.text] + 140, 80, self.bounds.size.width - self.Hospitaltext.frame.origin.x - 35, 20);
        [whiteColorview addSubview:self.Hospitaltext];
        
        UIImageView *huise = [[UIImageView alloc] initWithFrame:CGRectMake(0, 110, self.bounds.size.width + 100, 2)];
        huise.image = [UIImage imageNamed:@"huisebiaofebge"];
        [whiteColorview addSubview:huise];
        
        self.shichangjia = [[UILabel alloc] init];
        self.shichangjia.font = [UIFont systemFontOfSize:15];
        self.shichangjia.textColor = [UIColor grayColor];
        self.shichangjia.frame = CGRectMake(15, 125, self.bounds.size.width/2, 20);
        self.shichangjia.font = [UIFont systemFontOfSize:15];
        [whiteColorview addSubview:self.shichangjia];
        
        UIImageView *shichangjiahengxian = [[UIImageView alloc] initWithFrame:CGRectMake(65, 135, 30, 1)];
        shichangjiahengxian.image = [UIImage imageNamed:@"xiaohengxian"];
        [whiteColorview addSubview:shichangjiahengxian];
        
        self.youhuijia = [[UILabel alloc] init];
        self.youhuijia.font = [UIFont systemFontOfSize:15];
        self.youhuijia.textColor = [UIColor redColor];
        self.youhuijia.frame = CGRectMake(15, 150, self.bounds.size.width/2, 20);
        [whiteColorview addSubview:self.youhuijia];
        
        
        self.qianggou = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width/2 + 50, 145, 80, 25)];
        [self.qianggou addTarget:self action:@selector(qianggoubtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [whiteColorview addSubview:self.qianggou];
        
        self.jiaoyizhuangtai = [[UILabel alloc] init];
        self.jiaoyizhuangtai.font = [UIFont systemFontOfSize:14];
        self.jiaoyizhuangtai.textColor = [UIColor blueColor];
        self.jiaoyizhuangtai.frame = CGRectMake(150, 112, 70, 20);
        [whiteColorview addSubview:self.jiaoyizhuangtai];
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
