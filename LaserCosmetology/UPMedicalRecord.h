//
//  UPMedicalRecord.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/2.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pickerimageViewController.h"

@interface UPMedicalRecord : UIViewController<sendvaluedelegate,NSXMLParserDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UIScrollView *_bigscrollview;
    UIImageView *_background;
    
    UIButton *_upimage;
    UIImageView *_imagelins;
    UILabel *_binglitu;
    UIButton *_queding;
}
-(void)sendimage:(UIImage *)imagess;

@property(nonatomic,retain)NSString *productorsno;
@property(nonatomic,retain)NSString *data;
@property(nonatomic,retain)NSString *doctorsno;
@property(nonatomic,retain)NSString *customersno;
@property(nonatomic,retain)NSString *orderDetailSno;

@property(nonatomic,assign)BOOL isfenlei;
@property(nonatomic,retain)UITableView *Righttableview;
@property(nonatomic,retain)UIButton *shoosebtn;
@property(nonatomic,retain)UIImageView *shoosebackimage;

@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *phonenumber;
@property(nonatomic,retain)NSString *project;
@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)NSString *CusName;
@property(nonatomic,retain)NSString *CellPhone;
@property(nonatomic,retain)NSString *ProName;
@property(nonatomic,retain)NSString *BookDt;
@property(nonatomic,retain)NSString *historyPic;

@property(nonatomic,retain)NSMutableArray *numberary;
@property(nonatomic,retain)NSMutableArray *selectorary;
@property(nonatomic,retain)NSMutableArray *resut;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,assign)float btnyhigth;

@property(nonatomic,retain)NSString *proSnos;
@property(nonatomic,retain)NSMutableArray *proSnosaryindex;
@property(nonatomic,assign)NSInteger cancelbtnindex;
@property(nonatomic,retain)NSMutableArray *orderproject;

@end



