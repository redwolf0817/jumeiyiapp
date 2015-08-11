//
//  discuse.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "discuse.h"
#import "customerBeautifyLogData.h"
@implementation discuse

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame and:(NSArray *)discuseary
{
    
    self = [super initWithFrame:frame];
    if (self) {
    
       //  static
        float higth = 0;
        
        for (int i = 0; i < discuseary.count; i++) {
          
            customerBeautifyLogData *customer = [discuseary objectAtIndex:i];
            
            UIView *contentsview = [[UIView alloc] initWithFrame:CGRectMake(0, higth, self.bounds.size.width, [self contentsWithnsstring:customer.Contents])];
            [self addSubview:contentsview];
            
            self.oneame = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, [self NSStringwithsize:13 str:customer.TrueName], 15)];
            self.oneame.text =customer.TrueName;
            self.oneame.font = [UIFont systemFontOfSize:13];
            self.oneame.textColor = [UIColor blackColor];
            [contentsview addSubview:self.oneame];
            
            self.Replys = [[UILabel alloc] initWithFrame:CGRectMake(5 + [self NSStringwithsize:13 str:customer.TrueName], 5, [self NSStringwithsize:13 str:@":"], 15)];
            self.Replys.text = @":";
            self.Replys.font = [UIFont systemFontOfSize:13];
            self.Replys.textColor = [UIColor blackColor];
            [contentsview addSubview:self.Replys];
            
            self.contents = [[UILabel alloc] initWithFrame:CGRectMake( self.Replys.frame.origin.x + 4, 5, self.bounds.size.width - 90, [self contentsWithnsstring:customer.Contents])];
            self.contents.text = [NSString stringWithFormat:@" %@",customer.Contents];
            self.contents.numberOfLines = 100;
            self.contents.font = [UIFont systemFontOfSize:13];
            [contentsview addSubview:self.contents];
            
             higth = [self contentsWithnsstring:customer.Contents] + higth + 5;
            
        }
    
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

//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize size = CGSizeMake(self.bounds.size.width - 90,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}


@end
