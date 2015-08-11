//
//  CommunicateWithDoctors.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/5.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunicateWithDoctors : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,UITextViewDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UITableView *_table;
    
    UIImageView *_images;
    NSMutableArray *_messarray;
    UITextView *_text;
    UIButton *_sendmasses;
    BOOL _isLoading;
    NSTimer *_timer;
    
    NSTimer *_getmesstimer;
}

@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *fromType;
@property(nonatomic,retain)NSString *fileType;
@property(nonatomic,retain)NSString *textInfo;
@property(nonatomic,retain)NSString *data;
@property(nonatomic,retain)NSString *fileTypeName;
@property(nonatomic,retain)NSString *lastInfoSno;
@property(nonatomic,retain)NSString *noticeDt;
@property(nonatomic,retain)NSString *orderDetailSno;

@property(nonatomic,retain)NSString *lastmess;
@property(nonatomic,assign)BOOL isRefreshLoading;

@end
