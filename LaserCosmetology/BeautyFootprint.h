//
//  BeautyFootprint.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/6.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"
#import "BeautyFootclViewCell.h"

@interface BeautyFootprint : UIViewController<RefreshControlDelegate,NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_customerBeautifyLogDataarray;
    NSMutableArray *_contentshightarray;
    
    UITableView *_btftableview;
    BOOL _isLoading;
    NSTimer *_timer1;
}
@property(nonatomic,assign)CGImageRef image;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,assign)BOOL isdown;
@end
