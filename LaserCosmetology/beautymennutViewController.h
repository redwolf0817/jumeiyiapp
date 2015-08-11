//
//  beautymennutViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"

@interface beautymennutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,UISearchBarDelegate,UISearchDisplayDelegate,RefreshControlDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_beautyary;
    RefreshControl *_refreshControl;
}
@property(nonatomic,retain)UITableView *tableview;

@property(nonatomic,retain)UISearchBar *searchBar;
@property(nonatomic,retain)UISearchDisplayController *searchDisplay;
@property(nonatomic,retain)NSMutableArray *searbarrerustary;

@property(nonatomic,retain)UIButton *redbutton;
@property (nonatomic,strong)RefreshControl * refreshControl;
@end
