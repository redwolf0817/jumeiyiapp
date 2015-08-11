//
//  GuestbookViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"
@interface GuestbookViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,RefreshControlDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITableView *_tableview;
    NSMutableArray *_custommesarray;
    
    RefreshControl *_refreshControl;
    BOOL _isLoading;
    NSTimer *_timer1;
}

@property(nonatomic,retain)NSString *doctorsno;
@property(nonatomic,retain)NSString *customersno;
@property(nonatomic,retain)NSString *typeInfo;
@property(nonatomic,retain)NSString *firstWord;
@property(nonatomic,retain)NSString *strPageindex;
@property(nonatomic,retain)NSString *strPagesize;
@property (nonatomic,strong)RefreshControl * refreshControl;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,assign)BOOL istop;
@end
