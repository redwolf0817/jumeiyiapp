//
//  ChatWithTheDoctor.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/13.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "ChatWithTheDoctor.h"

@implementation ChatWithTheDoctor

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
        if ([tyfrom isEqualToString:@"yisheng"]) {
            
            self.lefetimage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 280, contentshigth + 40)];
            UIEdgeInsets ed = {50.0f, 40.0f, 40.0f, 40.0f};
            self.lefetimage.image = [[UIImage imageNamed:@"客户留言_03(1)"] resizableImageWithCapInsets:ed];
            [self.myview addSubview:self.lefetimage];
            
            if ([filetype isEqualToString:@"20150213142921851"]) {
                self.lefetimage.frame = CGRectMake(10, 5, 280, 300);
            }
            
            if ([filetype isEqualToString:@"20150213142908837"]) {//文字
                self.lefetcontents = [[UILabel alloc] init];
                self.lefetcontents.numberOfLines = 0;
                self.lefetcontents.text = contents;             NSLog(@"客户发送的信息:%@",contents);
                self.lefetcontents.frame = CGRectMake(20, 5, self.lefetimage.bounds.size.width - 30, contentshigth);
                [self.lefetimage addSubview:self.lefetcontents];
            }else if([filetype isEqualToString:@"20150213142921851"]){//图片
                self.lefetPhoto = [[UIImageView alloc] init];
                self.lefetPhoto.image = [UIImage imageWithData:imagesData];
                self.lefetPhoto.frame = CGRectMake(22, 5, self.rigthimage.bounds.size.width - 30, self.rigthimage.bounds.size.width - 30);
                [self.lefetimage addSubview:self.lefetPhoto];
                self.lefetPhoto.layer.masksToBounds = YES;
                self.lefetPhoto.layer.cornerRadius = 5;
            }else if ([filetype isEqualToString:@"20150213142939496"]){//音频
                
            }else{
                
            }
            if ([filetype isEqualToString:@"20150213142921851"]) {
                UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(20, self.lefetimage.bounds.size.height + 5, self.bounds.size.width, 20)];
                date.text = creatdate;
                date.font = [UIFont systemFontOfSize:14];
                [self.lefetimage addSubview:date];
            }else{
                UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(20, self.lefetcontents.bounds.size.height + self.lefetcontents.frame.origin.y + 5, self.bounds.size.width, 20)];
                date.text = creatdate;
                date.font = [UIFont systemFontOfSize:14];
                [self.lefetimage addSubview:date];
            }
            
            
        }else{//fileType发送文件类型(文字 20150213142908837;图片20150213142921851;音频20150213142939496;视频 20150213142950810)
            
            self.rigthimage = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 300, 5, 280, contentshigth + 40)];
            UIEdgeInsets ed = {50.0f, 40.0f, 40.0f, 40.0f};
            self.rigthimage.image = [[UIImage imageNamed:@"客户留言_06"] resizableImageWithCapInsets:ed];
            [self.myview addSubview:self.rigthimage];
            
            if ([filetype isEqualToString:@"20150213142921851"]) {
                self.rigthimage.frame = CGRectMake(self.bounds.size.width - 300, 5, 280, 300);
            }
            
            if ([filetype isEqualToString:@"20150213142908837"]) {//文字
                self.rigthcontents = [[UILabel alloc] init];
                self.rigthcontents.numberOfLines = 0;
                self.rigthcontents.text = contents;         NSLog(@"赋值是否成功 (%@)",contents);
                self.rigthcontents.frame = CGRectMake(10, 5, self.rigthimage.bounds.size.width - 30, contentshigth);
                [self.rigthimage addSubview:self.rigthcontents];
            }else if([filetype isEqualToString:@"20150213142921851"]){//图片
                self.rigthPhoto = [[UIImageView alloc] init];
                self.rigthPhoto.frame = CGRectMake(12, 10, self.rigthimage.bounds.size.width - 35, self.rigthimage.bounds.size.width - 35);
                self.rigthPhoto.image = [UIImage imageWithData:imagesData];
                self.rigthPhoto.image = [UIImage imageNamed:@"sy_03"];
                self.rigthPhoto.layer.masksToBounds = YES;
                self.rigthPhoto.layer.cornerRadius = 5;
                [self.rigthimage addSubview:self.rigthPhoto];
                NSLog(@"imagesData === %@",imagesData);
            }else if ([filetype isEqualToString:@"20150213142939496"]){//音频
                
            }else{
                
            }
                                                    //图片
            if ([filetype isEqualToString:@"20150213142921851"]) {
                UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(self.rigthimage.bounds.size.width - [self NSStringwithsize:17 str:creatdate] - 10, self.rigthimage.bounds.size.height - 20, self.bounds.size.width, 20)];
                date.text = creatdate;
                date.font = [UIFont systemFontOfSize:14];
                [self.rigthimage addSubview:date];
            }else{
                UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(self.rigthimage.bounds.size.width - [self NSStringwithsize:17 str:creatdate] - 10, self.rigthcontents.bounds.size.height + self.rigthcontents.frame.origin.y + 5, self.bounds.size.width, 20)];
                date.text = creatdate;
                date.font = [UIFont systemFontOfSize:14];
                [self.rigthimage addSubview:date];
                
            }
            
            
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
