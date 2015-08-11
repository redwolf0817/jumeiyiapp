//
//  MyPoints.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/5.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPoints : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,NSXMLParserDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;

    UICollectionView *_clView;
    NSMutableArray *_pointDataary;
    NSMutableArray *_higthary;
    
    UILabel *_lable2;
    UILabel *_lable1;
}
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *totalPointCount;
@end
