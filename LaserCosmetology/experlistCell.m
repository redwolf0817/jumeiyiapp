//
//  experlistCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/27.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "experlistCell.h"

@implementation experlistCell

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
        
        UIImageView *backgroudimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 375, 119)];
        backgroudimage.image = [UIImage imageNamed:@"huidi.png"];
        backgroudimage.userInteractionEnabled = YES;
        [self addSubview:backgroudimage];
        
        self.headimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        self.headimage.layer.cornerRadius = 50;
        self.headimage.layer.masksToBounds = YES;
        [backgroudimage addSubview:self.headimage];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(125, 15, 80, 20)];
        self.name.font = [UIFont systemFontOfSize:15];
        [backgroudimage addSubview:self.name];
        
        self.fuwu = [[UILabel alloc] initWithFrame:CGRectMake(190, 15, 60, 20)];
        self.fuwu .text = @"已服务:";
        self.fuwu .font = [UIFont systemFontOfSize:15];
        [backgroudimage addSubview:self.fuwu ];
        
        self.fuwurenshu = [[UILabel alloc] initWithFrame:CGRectMake(205, 15, 60, 20)];
        self.fuwurenshu.font = [UIFont systemFontOfSize:15];
        [backgroudimage addSubview:self.fuwurenshu];
        
        
        self.fuwuren = [[UILabel alloc] initWithFrame:CGRectMake(255 , 15, 60, 20)];
        self.fuwuren.text = @"人";
        self.fuwuren.textColor = [UIColor blackColor];
        self.fuwuren.font = [UIFont systemFontOfSize:15];
        [backgroudimage addSubview:self.fuwuren];
        
        UILabel *sc = [[UILabel alloc] initWithFrame:CGRectMake(125, 50, 60, 20)];
        sc.text = @"擅长:";
        sc.font = [UIFont systemFontOfSize:14];
        [backgroudimage addSubview:sc];
        
        self.shanchang = [[UILabel alloc] initWithFrame:CGRectMake(165, 50, 60, 20)];
        self.shanchang.font = [UIFont systemFontOfSize:14];
        [backgroudimage addSubview:self.shanchang];
        

        
        UILabel *shoufei = [[UILabel alloc] initWithFrame:CGRectMake(125, 80, 60, 20)];
        shoufei.text = @"费用:";
        shoufei.font = [UIFont systemFontOfSize:14];
        [backgroudimage addSubview:shoufei];
        
        self.feiyong = [[UILabel alloc] initWithFrame:CGRectMake(160, 80, 90, 20)];
        self.feiyong.font = [UIFont systemFontOfSize:14];
        [backgroudimage addSubview:self.feiyong];
        
        self.yuan = [[UILabel alloc] initWithFrame:CGRectMake(215  + 3, 80, 90, 20)];
        self.yuan.textColor = [UIColor blackColor];
        self.yuan.text = @"元";
        self.yuan.font = [UIFont systemFontOfSize:13];
        [backgroudimage addSubview:self.yuan];
        
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 50, 80, 25, 25)];
        [button setBackgroundImage:[UIImage imageNamed:@"yuwenjiesao.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    
    return self;
    
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

- (void)btn:(UIButton *)sender {
    
    
    UITableViewCell *cell = (UITableViewCell*)[sender superview];
    NSLog(@"cell -->%@",cell);
    UITableView *table = (UITableView*)[[[sender superview] superview] superview];
    
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    
//    if (a % 2 == 0) {
//        [sender setBackgroundImage:[UIImage imageNamed:@"duigouh"] forState:UIControlStateNormal];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"choosetime" object:[NSString stringWithFormat:@"%ld",indexPath.row]];
        
//    }else{
//        
//         [sender setBackgroundImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
//    }
//    
//    NSLog(@"indexPath.section%ld -indexPath.row%ld",indexPath.section,indexPath.row);
//
//    a++;
}

@end


