//
//  MeiRongZuJiCellVCperson.h
//  聚美医
//
//  Created by fenghuang on 15/7/17.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeiRongZuJiCellVCperson : UIViewController<NSXMLParserDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

{

    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UICollectionView *_clView;
    NSMutableArray *_contentshightarray;
    NSMutableArray *_logDataarray;
    UIView *_imagebackview;
    UIView *_imagetunningview;
    
}
@property(nonatomic,retain)NSMutableArray *pinglunARRAYary;
@property(nonatomic,retain)NSString *sno;

@end
