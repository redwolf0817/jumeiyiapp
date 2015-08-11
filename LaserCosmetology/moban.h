//
//  moban.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/7.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface moban : UIViewController<UIScrollViewDelegate,NSXMLParserDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    

    UIScrollView *_imagescroler;
    
    NSMutableArray *_modelListDataarray;
    NSMutableArray *_pictureDataarray;
}
@property(nonatomic,retain)NSString *modelNo;
@property(nonatomic,retain)NSString *modelNoEnumNo;
@property(nonatomic,retain)NSString *SeqNo;

@property(nonatomic,retain)NSString *doctoersno;
@property(nonatomic,retain)NSString *Sno;//图片的索引
@property(nonatomic,retain)NSString *picDesc;
@property(nonatomic,retain)NSString *data;
@property(nonatomic,retain)NSString *doType;

@property(nonatomic,retain)NSMutableArray *EnumNoarray;

@property(nonatomic,retain)UILabel *mobanlb;
@property(nonatomic,retain)UILabel *savemodlabletext;
@property(nonatomic,retain)NSArray *titleary;

@property(nonatomic,retain)UIImageView *image1;
@property(nonatomic,retain)UIImageView *image2;
@property(nonatomic,retain)UIImageView *image3;
@property(nonatomic,retain)UIImageView *image4;
@property(nonatomic,retain)UIImageView *image5;

@property(nonatomic,retain)UIImage *images;
@end
