//
//  GetCustomerDetailByDoctorSno.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/15.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetCustomerDetailByDoctorSno : UIViewController<NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>

{

    UIView *_botomview;
    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_customerDataarray;
    NSMutableArray *_orderDataarray;
    NSMutableArray *_talkDataarray;
    
    UITableView *_tableview;
    UITableView *_Thechatrecord;
}
@property(nonatomic,assign)BOOL isup;

@property(nonatomic,retain)NSString *mydoctorsno;
@property(nonatomic,retain)NSString *mycustomersno;
@end
