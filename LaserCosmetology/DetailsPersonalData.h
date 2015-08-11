//
//  DetailsPersonalData.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsPersonalData : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,UIAlertViewDelegate,UITextFieldDelegate,UITextViewDelegate>

{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    UIScrollView *scrollview;
    UIImageView *background;
    UIButton *commit;
    
    UITextField *nametextf;
    UISegmentedControl *segmented;
    UILabel *hospitaltf;
    UITextField *Posttf;
    UITextField *publicPosttf;
    UITextField *Qualificationstf;
    UITextField *Areatf;
    UITextView *_Introduction;

}
@property(nonatomic,retain)NSString *doctorSno;
@property(nonatomic,assign)BOOL isfenlei;
@property(nonatomic,retain)UIImageView *imahe;
@property(nonatomic,retain)UITableView *Righttableview;
@property(nonatomic,retain)UIButton *shoosebtn;
@property(nonatomic,retain)UIImageView *shoosebackimage;

@property(nonatomic,retain)NSMutableArray *numberary;
@property(nonatomic,retain)NSMutableArray *selectorary;
@property(nonatomic,retain)NSMutableArray *resut;
@property(nonatomic,assign)NSInteger a;
@property(nonatomic,assign)float btnyhigth;

@property(nonatomic,retain)NSString *trueName;
@property(nonatomic,retain)NSString *postName;
@property(nonatomic,retain)NSString *societyPostName;
@property(nonatomic,retain)NSString *qualification;
@property(nonatomic,retain)NSString *district;
@property(nonatomic,retain)NSString *contents;
@property(nonatomic,retain)NSString *proSnos;
@property(nonatomic,retain)NSString *hospitalName;
@property(nonatomic,retain)NSString *SexType;
@property(nonatomic,retain)NSMutableArray *proSnosaryindex;
@property(nonatomic,assign)NSInteger cancelbtnindex;
@property(nonatomic,retain)NSMutableArray *orderproject;

@property(nonatomic,retain)UILabel *endediting;

@end
