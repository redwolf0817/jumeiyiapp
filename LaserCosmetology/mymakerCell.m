//
//  mymakerCell.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "mymakerCell.h"

@implementation mymakerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)upbingli:(id)sender {
    
    UITableViewCell *cell = (UITableViewCell*)[[sender superview] superview];
   
    UITableView *table = (UITableView*)[[[[sender superview] superview] superview] superview];
    
    NSIndexPath *indexPath = [table indexPathForCell:cell];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updata" object:[NSString stringWithFormat:@"%ld",indexPath.row]];
}
@end
