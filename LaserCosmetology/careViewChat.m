//
//  careViewChat.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "careViewChat.h"

@implementation careViewChat

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame andwidth:(CGFloat)width tyfrom:(NSString *)tyfrom andcontents:(NSString *)contents creatdate:(NSString *)creatdate andimages:(NSData *)imagesData filetype:(NSString *)filetype{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat contentshigth = [self contentsWithnsstring:contents];
        
        self.myview = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.myview];
        
        //fileType发送文件类型(文字 20150213142908837;图片20150213142921851;音频20150213142939496;视频 20150213142950810)
       

        UILabel *datelable = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.myview.bounds.size.width - 40, 20)];
        datelable.text = creatdate;
        datelable.font = [UIFont systemFontOfSize:14];
        [self.myview addSubview:datelable];
            
            if ([filetype isEqualToString:@"20150213142908837"]) {//文字
                self.lefetcontents = [[UILabel alloc] init];
                self.lefetcontents.numberOfLines = 0;
                self.lefetcontents.text = contents;
                self.lefetcontents.frame = CGRectMake(20, 25, self.myview.bounds.size.width - 40, contentshigth);
                self.lefetcontents.alpha = 0.75;
                [self.myview addSubview:self.lefetcontents];
            }else if([filetype isEqualToString:@"20150213142921851"]){//图片
                self.lefetPhoto = [[UIImageView alloc] init];
                self.lefetPhoto.image = [UIImage imageWithData:imagesData];
                self.lefetPhoto.frame = CGRectMake(22, 5, self.lefetimage.bounds.size.width - 30, self.lefetimage.bounds.size.width - 30);
                [self.lefetimage addSubview:self.lefetPhoto];
                self.lefetPhoto.layer.masksToBounds = YES;
                self.lefetPhoto.layer.cornerRadius = 5;
            }else if ([filetype isEqualToString:@"20150213142939496"]){//音频
                
            }else{
        
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
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(self.bounds.size.width - 40,2000);
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
