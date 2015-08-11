//
//  MyExpertCLViewCR.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/3.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"
@interface MyExpertCLViewCR : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,NSXMLParserDelegate,RefreshControlDelegate>

{
    UICollectionView *_clView;
    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_doctorDataary;
    RefreshControl *_refreshControl;
}

@property(nonatomic,retain)NSString *customerSno;

@property(nonatomic,retain)NSString *DoctorSno;
@property(nonatomic,retain)NSString *DoctorName;

@property (nonatomic,strong)RefreshControl * refreshControl;
@end
