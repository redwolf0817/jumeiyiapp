//
//  NewExpertViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewExpertViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_basicDataary;
    NSMutableArray *_proDataary;
    NSMutableArray *_successCaseDataary;
    
    UITableView *_tableview;
}
@property(nonatomic,retain)NSString *doctorsno;
@property(nonatomic,retain)NSString *customersno;
@property(nonatomic,retain)NSString *hospitalName;
@property(nonatomic,retain)NSString *hospitalSno;
@property(nonatomic,retain)NSString *isFocus;
@property(nonatomic,retain)NSString *doctorname;

@property(nonatomic,assign)float contentshigth;
@property(nonatomic,assign)float cellhigth;
@property(nonatomic,assign)BOOL isgrup;

@end
