//
//  YouHuiViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/20.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"

@interface YouHuiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,RefreshControlDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITableView *_youhuihuodong;
    NSMutableArray *_beautifyProductSaleDataarray;
    
    RefreshControl *_refreshControl;
}

@property (nonatomic,strong)RefreshControl * refreshControl;

@end
