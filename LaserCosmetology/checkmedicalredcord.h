//
//  checkmedicalredcord.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checkmedicalredcord : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,NSXMLParserDelegate>
{
    UICollectionView *_clView;

    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_caseHistoryDataarray;
}
@property(nonatomic,retain)NSString *customersno;

@end
