//
//  CustomerEvaluationViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"
@interface CustomerEvaluationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,RefreshControlDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_evaluateDoctorDataarray;
    UITableView *_tableview;
    
    UIView *_backview;
    UIView *_tunningview;
    UITextView *_textview;
    NSTimer *_timer1;
    BOOL _isLoading;
    RefreshControl *_refreshControl;
}
@property(nonatomic,retain)NSString *doctorsno;
@property(nonatomic,retain)NSString *orderDetailSno;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,assign)BOOL istop;
@property (nonatomic,strong)RefreshControl * refreshControl;
@end
