//
//  Beautyitems.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beautyitems : NSObject

@property(nonatomic,copy)NSString *Sno;
@property(nonatomic,copy)NSString *InfoId;
@property(nonatomic,copy)NSString *Name;
@property(nonatomic,copy)NSString *TypeSno;
@property(nonatomic,copy)NSString *Description;
@property(nonatomic,copy)NSString *Contents;
@property(nonatomic,copy)NSString *PicSrc;
@property(nonatomic,copy)NSString *ReferencePrice;

@property(nonatomic,copy)NSString *LikeCount;
@property(nonatomic,copy)NSString *ReferencePriceMax;
@property(nonatomic,copy)NSString *EnumName;
@property(nonatomic,copy)NSString *EnumNo;

@property(nonatomic,copy)NSString *ParentId;
@property(nonatomic,copy)NSString *Sort;
@property(nonatomic,copy)NSString *itmesid;
@property(nonatomic,copy)NSString *text;

@property(nonatomic,copy)NSString *ProName;
@property(nonatomic,copy)NSString *ProSno;
@property(nonatomic,copy)NSString *ProTypeNo;

+(Beautyitems *)analysiswithdictionary:(NSDictionary *)diction;

@end

