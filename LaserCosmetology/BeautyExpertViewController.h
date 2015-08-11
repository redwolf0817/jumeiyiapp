//
//  BeautyExpertViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControl.h"

@interface BeautyExpertViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,RefreshControlDelegate>
{
    UIView *_viewbtn;
    UITableView *_contenttable;

    UIImageView *_citytaarraybackimage;
    UITableView *citytablevi;
    UITableView *beautifyProductType;
    UITableView *tablevi4;
    
    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_beautifyProductTypeDataary;
    NSMutableArray *_hospitalLevelTypeDataary;
    NSMutableArray *_meirongzhuanjia;
    
    RefreshControl *_refreshControl;
}
@property(nonatomic,copy)NSString *cityname;
@property(nonatomic,copy)NSString *cityno;
@property(nonatomic,copy)NSString *hotno;
@property(nonatomic,copy)NSString *beautyno;
@property(nonatomic,copy)NSString *SortFile;
@property(nonatomic,retain)NSMutableArray *cityTypeDataAry;
@property(nonatomic,retain)NSArray *sequence;
@property(nonatomic,retain)NSString *zhuanjiaSno;
@property(nonatomic,retain)NSString *hospitolname;
@property(nonatomic,copy)NSString *TrueName;
@property(nonatomic,retain)UIButton *redbutton;
@property(nonatomic,assign)NSInteger isbtnclick;
@property (nonatomic,strong)RefreshControl * refreshControl;

@end
