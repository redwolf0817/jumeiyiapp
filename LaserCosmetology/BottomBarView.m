//
//  BottomBarView.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/11.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "BottomBarView.h"
#import "HuQiJingsharManage.h"

@implementation BottomBarView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bottomview = [[UIView alloc] initWithFrame:self.bounds];
        _bottomview.backgroundColor = [UIColor clearColor];
        [self addSubview:_bottomview];

        
        float butnwidth = self.bounds.size.width/5;
        
        for (int i = 0 ; i < 5; i++) {
            UIButton *butn = [[UIButton alloc] initWithFrame:CGRectMake(butnwidth * i, 0, butnwidth, 49)];
            [butn addTarget:self action:@selector(butnclickssss:) forControlEvents:UIControlEventTouchUpInside];
            butn.tag = i + 10;
            butn.backgroundColor = [UIColor clearColor];
            [_bottomview addSubview:butn];
        }
    }
    

    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)butnclickssss:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
    

   NSString *btin = [NSString stringWithFormat:@"%ld",btn.tag - 10];
    
     [HuQiJingsharManage shareManage].sssss = btin;


}


@end
