//
//  NewprojectdetailViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewprojectdetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_proDataary;
    NSMutableArray *_proTypeDataary;
    NSInteger selector;
}

@property(nonatomic,retain)UITableView *fenleitableview;
@property(nonatomic,retain)UITableView *Righttableview;
@property(nonatomic,retain)NSString *proTypeNo;
@property(nonatomic,retain)NSString *titiles;
@property(nonatomic,retain)NSMutableArray *fenei;
@property(nonatomic,retain)NSMutableArray *allfenlei;
@end