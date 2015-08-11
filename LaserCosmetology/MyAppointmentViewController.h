//
//  MyAppointmentViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/1.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"
@interface MyAppointmentViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,NSXMLParserDelegate,RefreshControlDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UIView *_backview;
    UIView *_tunningview;
    UITextView *_textview;
    RefreshControl *_refreshControl;
}

@property(nonatomic,retain)NSMutableArray *mydataarray;
@property(nonatomic,retain)NSString  *evaluateContents;
@property(nonatomic,retain)NSString  *evaluateLevel;
@property(nonatomic,retain)NSString *customerOrderDetailSno;
@property(nonatomic,retain)NSMutableArray *higthary;
@property(nonatomic,retain)NSString *customerSno;
@property (nonatomic,strong)RefreshControl * refreshControl;
@property(nonatomic,retain)UICollectionView *clView;
@end
