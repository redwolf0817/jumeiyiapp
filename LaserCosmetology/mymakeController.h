//
//  mymakeController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"
@interface mymakeController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,RefreshControlDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITableView *_table;
    NSMutableArray *_customerOrderDataarray;
    
    RefreshControl *_refreshControl;
    BOOL _isLoading;
    NSTimer *_timer1;
}
@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *orderState;
@property(nonatomic,retain)NSString *strPageindex;
@property(nonatomic,retain)NSString *strPagesize;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,assign)BOOL istop;
@property (nonatomic,strong)RefreshControl * refreshControl;

@end
