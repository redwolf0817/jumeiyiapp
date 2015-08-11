//
//  caremuban.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "caremuban.h"

@implementation caremuban

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame andcontents:(NSString *)contents {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat contentshigth = [self contentsWithnsstring:contents];
        
        self.myview = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.myview];
        
 
            
            self.lefetimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.bounds.size.width - 20, contentshigth + 40)];
            UIEdgeInsets ed = {50.0f, 40.0f, 40.0f, 40.0f};
            self.lefetimage.image = [[UIImage imageNamed:@"mubanbackimage"] resizableImageWithCapInsets:ed];
            [self.myview addSubview:self.lefetimage];

        
                self.lefetcontents = [[UILabel alloc] init];
                self.lefetcontents.numberOfLines = 0;
                self.lefetcontents.text = contents;             NSLog(@"客户发送的信息:%@",contents);
                self.lefetcontents.frame = CGRectMake(20, 5, self.lefetimage.bounds.size.width - 30, contentshigth);
                [self.lefetimage addSubview:self.lefetcontents];


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
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(250,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
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
