//
//  zujigerenzhongxinViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/21.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface zujigerenzhongxinViewController : UIViewController<NSXMLParserDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
     NSMutableArray *_contentshightarray;
    UICollectionView *_clView;
    
    NSMutableArray *_logDataarray;
    
    UIView *_backview;
    UIView *_tunningview;
    UITextView *_textview;
    
    UIView *_imagebackview;
    UIView *_imagetunningview;
    
    UIView *_timebackview;
    UIView *_timetunningview;
    
    UIView *wview;
    NSMutableArray *_yuyueRetary;
    NSMutableArray *_timeDataary;
    
}
@property(nonatomic,retain)NSString *customersno;
@property(nonatomic,retain)NSString *customername;
@property(nonatomic,retain)NSString *logSno;
@property(nonatomic,retain)NSMutableArray *pinglunARRAYary;

@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger day;
@property(nonatomic,retain)NSMutableArray *dayarray;
@property(nonatomic,retain)NSArray *monaay;
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *beautifySno;
@property(nonatomic,retain)NSString *hosptSno;
@property(nonatomic,retain)NSString *PhoneNo;
@property(nonatomic,retain)NSString *doctorname;
@property(nonatomic,retain)NSString *TrueName;
@property(nonatomic,retain)NSString *hostitalname;
@property(nonatomic,retain)NSString *dates;
@property(nonatomic,assign)NSInteger buttonindex;

@end

