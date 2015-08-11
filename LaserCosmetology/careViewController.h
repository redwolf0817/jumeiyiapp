//
//  careViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/28.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface careViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate,AVAudioRecorderDelegate,NSXMLParserDelegate,UITextViewDelegate>

{
    NSArray *_monaay;
    
    UIImageView *_images;
    UITextView *_text;
    UITableView *_tableview;
    
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_custommesarray;
    NSMutableArray *_doctorCareModelDataary;
    
    UIButton *_sendmasses;
    UIButton *_addmoban;
    
    UIView *_mobanview;
    UITableView *_mobantableview;
}
@property(nonatomic,retain)UIPickerView *pickerview;
@property(nonatomic,retain)UIPickerView *pickerview2;
@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger day;
@property(nonatomic,assign)NSInteger year1;
@property(nonatomic,assign)NSInteger month1;
@property(nonatomic,assign)NSInteger day1;
@property(nonatomic,assign)NSInteger year2;
@property(nonatomic,assign)NSInteger month2;
@property(nonatomic,assign)NSInteger day2;
@property(nonatomic,retain)NSMutableArray *dayarray;//每个月的天数
@property(nonatomic,retain)NSString *pickermonth1;
@property(nonatomic,retain)NSString *pickerday1;
@property(nonatomic,retain)NSString *pickermonth2;
@property(nonatomic,retain)NSString *pickerday2;

@property(nonatomic,retain)NSString *chatdata1;
@property(nonatomic,retain)NSString *chatdata2;

@property (nonatomic,strong) AVAudioRecorder *recorder;
@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,assign) BOOL recording;
@property (nonatomic,strong) NSString *fileName;

@property(nonatomic,retain)NSString *doctorsno;
@property(nonatomic,retain)NSString *customerSno;
@property(nonatomic,retain)NSString *fromType;
@property(nonatomic,retain)NSString *firstWord;
@property(nonatomic,retain)NSString *strPageindex;
@property(nonatomic,retain)NSString *strPagesize;

@property(nonatomic,retain)NSString *fileType;
@property(nonatomic,retain)NSString *textInfo;
@property(nonatomic,retain)NSString *data;
@property(nonatomic,retain)NSString *fileTypeName;
@property(nonatomic,retain)NSString *lastInfoSno;
@property(nonatomic,retain)NSString *noticeDt;
@property(nonatomic,retain)NSString *orderDetailSno;

@property(nonatomic,retain)NSString *CareDate;


@property(nonatomic,assign)BOOL isRefreshLoading;



@end
