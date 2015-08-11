//
//  ExperttorListsViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ExperttorListsViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>
{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UIView *_backview;
    UIView * _tunningview;
    UIView *wview;
    
    UIView *_viewbtn;
    UITableView *_tableview;
    UITableView *_citytaarraybleview;
    
    NSMutableArray *_retaray ;
    NSMutableArray *_cityTypeDataarray;
    NSMutableArray *_yuyueRetary;
    NSMutableArray *_timeDataary;
    
    NSMutableArray *_yuyuexianDoctorProData;
    NSMutableArray *_yuyuexiancarData;
    NSMutableArray *_yuyuexianhospitalDoctorRelateData;
    NSMutableArray *_yuyuexiancustomerData;
    
    UIImageView *_citytaarraybackimage;
    
    NSArray *_monaay ;
}
@property(nonatomic,assign)NSInteger buttonindex;
@property(nonatomic,retain)NSString *dates;
@property(nonatomic,retain)UIPickerView *pickerview;
@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger day;
@property(nonatomic,retain)NSMutableArray *dayarray;//每个月的天数
@property(nonatomic,retain)NSString *city;
@property(nonatomic,retain)NSString *cityno;
@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *beautifySno;//项目索引
@property(nonatomic,retain)NSString *hosptSno;
@property(nonatomic,retain)NSString *doctorname;
@property(nonatomic,retain)NSString *hostitalname;
@property(nonatomic,retain)NSString *PhoneNo;//用户信息
@property(nonatomic,retain)NSString *TrueName;//用户信息

@property(nonatomic,assign)BOOL iscitytableview;
@property(nonatomic,retain)NSString *shoosecity;//选择的城市
@property(nonatomic,retain)NSString *shoosecityno;//选择的城市索引
@property(nonatomic,retain)NSString *SortFile;//"BookCount") //服务人数,"EvaluateCount") //评价
@property(nonatomic,retain)NSString *OrderType;//

@end
