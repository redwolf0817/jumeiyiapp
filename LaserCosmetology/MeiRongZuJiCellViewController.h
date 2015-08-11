//
//  MeiRongZuJiCellViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/1.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"
@interface MeiRongZuJiCellViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,NSXMLParserDelegate,UIAlertViewDelegate,RefreshControlDelegate>

{
    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITableView *_rijitableview;
    UICollectionView *_clView;
    
    NSMutableArray *_logDataarray;
    NSMutableArray *_contentshightarray;
    
    RefreshControl *_refreshControl;
    NSTimer *_timer1;
}
@property(nonatomic,retain)NSString *logSno;
@property(nonatomic,retain)NSMutableArray *pinglunARRAYary;
@property(nonatomic,retain)NSString *customersno;
@property(nonatomic,retain)NSMutableArray *dataarray;
@property(nonatomic,assign)BOOL isloding;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,assign)BOOL isshuaxin;
@property (nonatomic,strong)RefreshControl * refreshControl;
@end
