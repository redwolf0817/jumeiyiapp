//
//  StarBeauticianViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/11.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarBeauticianViewController : UIViewController<NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource,UITableViewDelegate>

{
    UIScrollView *_scrollerView;
    UIScrollView *_littlescrollerView;
    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;

    NSMutableArray *_DoctorDataArray;
    NSMutableArray *_beautifyProDataArray;
    NSMutableArray *_doctorPicDataArray;
    NSMutableArray *_doctorSuccessCaseArray;
    
    UIButton *_anniubutton1;
    UIButton *_anniubutton2;
    UIButton *_anniubutton3;
    
    UIImageView *_images;
}
@property(nonatomic,retain)NSString *sno;//专家索引
@property(nonatomic,retain)NSString *musicData;
@property(nonatomic,retain)NSString *projectSno;
@property(nonatomic,retain)NSString *doctorname;
@property(nonatomic,retain)NSString *isFocus;
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *hospitolname;

@property(nonatomic,assign)int AA;
@property(nonatomic,retain)NSNotificationCenter *notifi;


@end
