//
//  customerViewCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/10.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "customerViewCell.h"

@implementation customerViewCell

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
    
        self.phonenumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.bounds.size.width, 20)];
        [self addSubview:self.phonenumber];
        
        self.xing1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35, 18, 18)];
        [self addSubview:self.xing1];
        
        self.xing2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 35, 18, 18)];
        [self addSubview:self.xing2];
        
        self.xing3 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 35, 18, 18)];
        [self addSubview:self.xing3];
        
        self.xing4 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 35, 18, 18)];
        [self addSubview:self.xing4];
        
        self.xing5 = [[UIImageView alloc] initWithFrame:CGRectMake(90, 35, 18, 18)];
        [self addSubview:self.xing5];
        
        self.contents = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, self.bounds.size.width, 20)];
        self.contents.numberOfLines = 0;
        self.contents.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.contents];
        
        self.retunstring = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, self.bounds.size.width, 20)];
        self.retunstring.numberOfLines = 0;
        self.retunstring.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.retunstring];
        
        self.dates = [[UILabel alloc] initWithFrame:CGRectMake(10, 85, self.bounds.size.width, 20)];
        [self addSubview:self.dates];
        
        self.huifu = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 60, 85, 60, 50)];
        self.huifu.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.huifu setTintColor:[UIColor redColor]];
        [self.huifu addTarget:self action:@selector(huifu:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.huifu];
    }
    
    return self;
}

- (void)huifu:(UIButton *)sender {
    
    UITableViewCell *cell = (UITableViewCell*) [sender superview];
    UITableView *table = (UITableView*)[[[sender superview] superview] superview];
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"qupingjia" object:[NSString stringWithFormat:@"%ld",indexPath.row]];
    
    NSLog(@"回复：---- 7%ld ",indexPath.row);


}
@end
