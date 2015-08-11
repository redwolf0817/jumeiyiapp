//
//  MainViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/9.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TopBarView.h"
#import "RefreshControl.h"
@interface MainViewController : UIViewController<UIScrollViewDelegate,NSXMLParserDelegate,CLLocationManagerDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,RefreshControlDelegate>

{   
    UIScrollView *_scrollview;
    UIPageControl *_pagecontrol;
    NSTimer *_timer;
    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_itemimage;
    NSMutableArray *_discountary;
    NSMutableArray *_starary;
    NSMutableArray *_zujiarray;//足迹
    NSMutableArray *_cellhightarray;//瀑布流单元格的高度
    NSMutableArray *_proTopDataary;
    
    CLLocationManager *_locationManager;//定位
    CLGeocoder *_geocoder;
    UIButton *_locationbtn;
    
    NSMutableArray *_citidate;//城市数据
    NSArray *_locationcityN;
    
    UITableView *_citytableview;
    NSMutableArray *_DireUrlarray;
    
    RefreshControl *_refreshControl;
    
}
@property(nonatomic,retain)UITableView *maintableview;
@property(nonatomic,copy)NSString *CiTy;
@property(nonatomic,copy)NSString *cityNo;
@property(nonatomic,assign)BOOL islocation;
@property(nonatomic,assign)BOOL isjudge;
@property(nonatomic,assign)CGFloat kuangaobi;
@property(nonatomic,assign)CGFloat meirong0;
@property(nonatomic,retain)NSString *projectSno;
@property(nonatomic,retain)NSString *StartSno;
@property(nonatomic,retain)NSArray *FourSnoarray;
@property(nonatomic,retain)NSArray *EightSnoarray;
@property(nonatomic,retain)UIButton *redbutton;
@property (nonatomic,strong)RefreshControl * refreshControl;
@end
