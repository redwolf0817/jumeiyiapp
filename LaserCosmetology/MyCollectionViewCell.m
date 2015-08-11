//
//  MyCollectionViewCell.m
//  PinkLife
//
//  Created by zy on 14-12-30.
//  Copyright (c) 2014年 段亚飞. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        
        _labelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiage.png"]];
        _labelImageView.layer.cornerRadius = 3;
        _labelImageView.clipsToBounds = YES;
        [self.contentView addSubview:_labelImageView];
        
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:10];
        [_labelImageView addSubview:_label];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    _labelImageView.frame = CGRectMake(self.contentView.bounds.size.width-50, self.contentView.bounds.size.height-20, 45, 15);
    _label.frame = CGRectMake(0, 0, _labelImageView.frame.size.width, _labelImageView.frame.size.height);
}

@end
