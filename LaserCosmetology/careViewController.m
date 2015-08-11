//
//  careViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/28.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "careViewController.h"
#import "TopBarView.h"
#import "NSString+DocumentPath.h"
#import "CustomerMessage.h"
#import "careViewChat.h"
#import "caremuban.h"
#import "PrefixHeader.pch"
@interface careViewController ()

@end

@implementation careViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getdate];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.view.bounds];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    
    _monaay = [[NSArray alloc] initWithObjects:@"01",@"02", @"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil];
    
    self.pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 24, self.view.bounds.size.width/2 - 35, 20)];
    self.pickerview.backgroundColor = [UIColor clearColor];
    self.pickerview.dataSource = self;
    self.pickerview.delegate = self;
    self.pickerview.tag = 31;
    [self.view addSubview:self.pickerview];
    
    [self.pickerview selectRow:self.month-1 inComponent:0 animated:YES];
    [self.pickerview selectRow:self.day-1 inComponent:2 animated:YES];
    
    
    UILabel *zhi = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 25, 105, 50, 25)];
    zhi.text = @"至";
    zhi.textColor = [UIColor blackColor];
    zhi.font = [UIFont systemFontOfSize:22];
    zhi.center = CGPointMake(self.view.bounds.size.width/2, 105);
    zhi.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:zhi];
    
    self.pickerview2 = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 + 35, 24, self.view.bounds.size.width/2 - 35, 20)];
    self.pickerview2.backgroundColor = [UIColor clearColor];
    self.pickerview2.dataSource = self;
    self.pickerview2.delegate = self;
    self.pickerview2.tag = 32;
    [self.view addSubview:self.pickerview2];
    
    [self.pickerview2 selectRow:self.month-1 inComponent:0 animated:YES];
    [self.pickerview2 selectRow:self.day-1 inComponent:2 animated:YES];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"客户关怀";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(comebacky) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 145, self.view.bounds.size.width, self.view.bounds.size.height - 145 - 60)];
    _tableview.backgroundColor = [UIColor whiteColor];
    _tableview.rowHeight = 120;
    _tableview.delegate = self;
    _tableview.tag = 100;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
    _images = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60)];
    _images.image = [UIImage imageNamed:@"dhk_02"];
    _images.userInteractionEnabled = YES;
    [self.view addSubview:_images];
    
//    UIButton *Sound = [[UIButton alloc] initWithFrame:CGRectMake(5, 12, 20, 30)];
//    [Sound setBackgroundImage:[UIImage imageNamed:@"liaotiananniu"] forState:UIControlStateNormal];
//    [Sound addTarget:self action:@selector(beginRecord) forControlEvents:UIControlEventTouchDown];
//    [Sound addTarget:self action:@selector(finishRecord) forControlEvents:UIControlEventTouchUpInside];
//    [_images addSubview:Sound];
    
    _addmoban = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 25, 25)];
    [_addmoban setBackgroundImage:[UIImage imageNamed:@"liaotianjiahao"] forState:UIControlStateNormal];
    [_addmoban addTarget:self action:@selector(doctoraddMessage) forControlEvents:UIControlEventTouchUpInside];
    [_images addSubview:_addmoban];
    
    _text = [[UITextView alloc] initWithFrame:CGRectMake(50, 10,self.view.bounds.size.width - 120, 35)];
    _text.backgroundColor = [UIColor whiteColor];
    _text.layer.masksToBounds = YES;
    _text.layer.cornerRadius = 3;
    _text.delegate = self;
    _text.font = [UIFont systemFontOfSize:17];
    [_images addSubview:_text];
    
    _sendmasses = [[UIButton alloc] initWithFrame:CGRectMake(_text.frame.size.width + _text.frame.origin.x + 5, 12, 50, 30)];
    [_sendmasses setBackgroundImage:[UIImage imageNamed:@"xiaoxifasong"] forState:UIControlStateNormal];
    [_sendmasses addTarget:self action:@selector(doctorSendAMessages) forControlEvents:UIControlEventTouchUpInside];
    [_images addSubview:_sendmasses];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.fromType = @"";
    self.data = @"";
    self.fileTypeName = @"";
    self.lastInfoSno = @"";
    self.noticeDt = @"";
    self.pickermonth1 = [NSString stringWithFormat:@"%ld",self.month];
    self.pickermonth2 =[NSString stringWithFormat:@"%ld",self.month2];
    self.pickerday1 = [NSString stringWithFormat:@"%ld",self.day];
    self.pickerday2 = [NSString stringWithFormat:@"%ld",self.day2];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
    self.doctorsno = [userdf objectForKey:@"customerSno"];
    
    //根据医生SNO/客户SNO/发送类型(医生发给客户:20150213142252612;客户发给医生20150213142231226)
    [self soaprequstWithdoctorSno:self.doctorsno customerSno:self.customerSno fromType:@"" strPageindex:@"1" strPagesize:@"40"];
    NSLog(@"-self.doctorsno------->> %@ <<---self.customerSno-->> %@ <<------",self.doctorsno,self.customerSno);
}


-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        // self.view.transform=CGAffineTransformMakeTranslation(0, - deltaY);
        NSLog(@"deltaY = %f",deltaY);
//        _images.frame = CGRectMake(0, self.view.bounds.size.height - 60 - 252, self.view.bounds.size.width, 60);
//        _tableview.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 252 - 64 - 49);
        
        float a = [self contentsWithnsstringcell:_text.text];
        NSLog(@"高度 %f-",a);
        
        if (a > 21) {
            
            if (a > 120) {
                a = 120;
            }
            _images.frame = CGRectMake(0, self.view.bounds.size.height - 30 - 252 - a, self.view.bounds.size.width, 30 + a);
            _text.frame = CGRectMake(50, 10, self.view.bounds.size.width - 120, a + 10);
            _sendmasses.frame = CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, _images.frame.size.height - 50, 60, 35);
            _addmoban.frame = CGRectMake(15,  _images.frame.size.height - 50, 25, 25);
        }else{
            _images.frame = CGRectMake(0, self.view.bounds.size.height - 60 - 252, self.view.bounds.size.width, 60);
            _sendmasses.frame = CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, 10, 60, 35);
            _text.frame = CGRectMake(50, 10, self.view.bounds.size.width - 120, 35);
            _addmoban.frame = CGRectMake(15, 15, 25, 25);
        }

    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        //self.view.transform = CGAffineTransformIdentity;
//        _images.frame = CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60);
//        _tableview.frame = CGRectMake(0, 145, self.view.bounds.size.width, self.view.bounds.size.height - 145 - 60);
        
        _images.frame = CGRectMake(0, self.view.bounds.size.height - _images.frame.size.height, self.view.bounds.size.width, _images.frame.size.height);
        _tableview.frame = CGRectMake(0, 145, self.view.bounds.size.width, self.view.bounds.size.height - 145 -  _images.frame.size.height);
        

        
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    
    float a = [self contentsWithnsstringcell:_text.text];
    NSLog(@"高度 %f-",a);
    
    if (a > 21) {
        
        if (a > 120) {
            a = 120;
        }
        _images.frame = CGRectMake(0, self.view.bounds.size.height - 30 - 252 - a, self.view.bounds.size.width, 30 + a);
        _text.frame = CGRectMake(50, 10, self.view.bounds.size.width - 120, a + 10);
        _sendmasses.frame = CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, _images.frame.size.height - 50, 60, 35);
        _addmoban.frame = CGRectMake(15,  _images.frame.size.height - 50, 25, 25);
    }else{
        _images.frame = CGRectMake(0, self.view.bounds.size.height - 60 - 252, self.view.bounds.size.width, 60);
        _sendmasses.frame = CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, 10, 60, 35);
        _text.frame = CGRectMake(50, 10, self.view.bounds.size.width - 120, 35);
    }
    
    
}

-(CGFloat)contentsWithnsstringcell:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 120,6000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}
-(void)getdate
{
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    // 年月日获得
    comps =[calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay)
                       fromDate:date];
    self.year = [comps year];
    self.month = [comps month];
    self.day = [comps day];
    self.year1 = [comps year];
    self.month1 = [comps month];
    self.day1 = [comps day];
    self.month2 = [comps month];
    self.day2 = [comps day];
    NSInteger days = [self getDaysOfMonthwithyear:self.year month:self.month];//计算当月的天数
    self.dayarray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int a = 1; a < days + 1; a ++) {
        NSString *daystr = [NSString stringWithFormat:@"%d",a];
        [self.dayarray addObject:daystr];
    }
    
}
-(void)doctoraddMessage{
    NSLog(@"添加模板");
    
    [self soaprequstWithstrPageindex:@"1" strPagesize:@"50" orderDetailSno:self.orderDetailSno];//获取模板数据包
    
    _mobanview = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height - 200)];
    _mobanview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mobanview];
    
    UIImageView *imgeview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height - 200)];
    imgeview.image = [UIImage imageNamed:@"mubanbackimages"];
    imgeview.alpha = 0.8;
    [_mobanview addSubview:imgeview];
    
    UIButton *imagev = [[UIButton alloc] initWithFrame:CGRectMake(_mobanview.bounds.size.width/2 - 15, 10, 30, 15)];
    [imagev setBackgroundImage:[UIImage imageNamed:@"mobanxla"] forState:UIControlStateNormal];
    [imagev addTarget:self action:@selector(dissmismuban) forControlEvents:UIControlEventTouchUpInside];
    [_mobanview addSubview:imagev];
    
    _mobantableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, _mobanview.bounds.size.width , _mobanview.bounds.size.height - 50)];
    _mobantableview.delegate = self;
    _mobantableview.dataSource = self;
    _mobantableview.tag = 101;
    _mobantableview.layer.masksToBounds = YES;
    _mobantableview.layer.cornerRadius = 4;
    _mobantableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mobantableview.backgroundColor = [UIColor clearColor];
    [_mobanview addSubview:_mobantableview];
    
    
}
-(void)doctorSendAMessages
{

    
    NSString *date1 = [NSString stringWithFormat:@"%ld-%@-%@",self.year1,self.pickermonth1,self.pickerday1];
    NSString *date2 = [NSString stringWithFormat:@"%ld-%@-%@",self.year1,self.pickermonth2,self.pickerday2];
    
    self.chatdata1 = date1;
    self.chatdata2 = date2;
   
    
    
    if ([date1 isEqualToString:date2]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有选择提醒日期" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];   return;
    }else if (self.month1 > self.month2){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"1日期有误，日期应大于当前日期" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];   return;
    }else if (self.month1 == self.month2) {
        if ( self.day1 > self.day2) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"2日期有误，日期应大于当前日期" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];   return;
        }

    }else if (self.month1 < self.month){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"3日期有误，日期应大于当前日期" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];   return;
    }else {
        
    }
    self.CareDate = [NSString stringWithFormat:@"%@ 至 %@",date1,date2];
    //fromType发送类型(医生发给客 户:20150213142252612;客户发给医生20150213142231226);fileType发送文件类型(文字 20150213142908837;图片20150213142921851;音频20150213142939496;视频 20150213142950810)
    
    CustomerMessage *recod = [[CustomerMessage alloc] init];
    recod.TextInfo = _text.text;
    recod.FromType = @"20150213142252612";
    recod.FileType = @"20150213142908837";
    recod.CreateDt = self.CareDate;

    
    
    self.textInfo = _text.text;
    self.fileType = @"20150213142908837";//文件类型，文字
    self.fileTypeName = @"";

    
    if ([self.fileType isEqualToString:@"20150213142908837"]) {
        
        if (self.textInfo == nil || [self.textInfo isEqualToString:@""]) {
            return;
        }else{
        
            [_custommesarray insertObject:recod atIndex:0];
            [_tableview reloadData];
            [self tableViewScrollCurrentIndexPath];
            
        [self soaprequstWithdoctorSno:self.doctorsno customerSno:self.customerSno fromType:@"20150213142252612" fileType:self.fileType textInfo:self.textInfo data:self.data fileTypeName:self.fileTypeName lastInfoSno:self.lastInfoSno noticeDt:date1 orderDetailSno:self.orderDetailSno noticeEndDt:date2];
        }
        
    }else{
    
//        [self soaprequstWithdoctorSno:self.doctorsno customerSno:self.customerSno fromType:@"20150213142252612" fileType:self.fileType textInfo:self.textInfo data:self.data fileTypeName:self.fileTypeName lastInfoSno:self.lastInfoSno noticeDt:date1 orderDetailSno:self.orderDetailSno noticeEndDt:date2];
        
    }
    
    _text.text = @"";
    
    _images.frame = CGRectMake(0, self.view.bounds.size.height - 60 - 252, self.view.bounds.size.width, 60);
    _sendmasses.frame = CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, 10, 60, 35);
    _text.frame = CGRectMake(50, 10, self.view.bounds.size.width - 120, 35);
    _addmoban.frame = CGRectMake(15, 15, 25, 25);
    
}
-(void)tableViewScrollCurrentIndexPath
{
    if (_custommesarray.count > 0) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_custommesarray.count-1 inSection:0];
        [_tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}
-(void)beginRecord
{
    
    self.recording=NO;
    [self.recorder stop];
    self.recorder=nil;
    
    NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:8000],AVSampleRateKey,
                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                            nil];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *fileName = [NSString stringWithFormat:@"rec_%@.wav",[dateFormater stringFromDate:now]];
    self.fileName=fileName;
    NSString *filePath=[NSString documentPathWith:fileName];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    NSError *error;
    self.recorder=[[AVAudioRecorder alloc]initWithURL:fileUrl settings:settings error:&error];
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder peakPowerForChannel:0];
    [self.recorder record];
    
    NSLog(@"开始录音");
    
}
-(void)finishRecord
{
    self.recording = NO;
    [self.recorder stop];
    self.recorder=nil;
    

    
    NSLog(@"录音结束");
}
-(void)initPlayer{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    audioSession = nil;
}
-(void)doctoraddimageSendAMessage:(NSString *)content//content是音频文件名
{
    if(self.player.isPlaying){
        
        [self.player stop];
    }
    //播放
    NSString *filePath=[NSString documentPathWith:content];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    [self initPlayer];
    NSError *error;
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
    [self.player setVolume:1];
    [self.player prepareToPlay];
    [self.player setDelegate:self];
    [self.player play];
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    NSLog(@"播放录音");
}

#pragma mark--计算每个月的天数
-(NSInteger)getDaysOfMonthwithyear:(NSInteger)year month:(NSInteger)month
{
    int days = 0;
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 9 || month == 10 || month == 12)
    {
        days = 31;
    }
    else if (month == 4 || month == 6 || month == 8 || month == 11)
    {
        days = 30;
    }
    else
    { // 2月份，闰年29天、平年28天
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
        {
            days = 29;
        }
        else
        {
            days = 28;
        }
    }
    
    return days;
}
#pragma mark--UIPickerView
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 25;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 25;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        return [_monaay objectAtIndex:row];
    }else if (component == 1){
        return @"月";
    }else if (component == 2){
        return [self.dayarray objectAtIndex:row];
    }else{
        return @"日";
    }
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{


    if (pickerView.tag == 31) {
        NSLog(@"row%ld---component%ld",row + 1,component);
        //月份
        if (component == 0) {
            self.pickermonth1 =[NSString stringWithFormat:@"%ld",row + 1];
             self.month1 = row + 1;
        }
        //日期
        if (component == 2) {
            self.pickerday1 =[NSString stringWithFormat:@"%ld",row + 1];
             self.day1 = row + 1;
        }
        
    }else if (pickerView.tag == 32 ) {
    NSLog(@"yy-row%ld---component%ld",row + 1,component);
        //月份
        if (component == 0) {
            self.pickermonth2 =[NSString stringWithFormat:@"%ld",row + 1];
            self.month2 = row + 1;
        }
        //日期
        if (component == 2) {
            self.pickerday2 =[NSString stringWithFormat:@"%ld",row + 1];
            self.day2 = row + 1;
        }

    }else{
    
    }

}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 12;
    }else if (component == 1){
        return 1;
    }else if (component == 2){
        return self.dayarray.count;
    }else{
        return 1;
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view{

    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    lable.textColor = [UIColor blackColor];
    [vv addSubview:lable];
    
    if (component == 0) {
        lable.text = [_monaay objectAtIndex:row];
    }else if (component == 1){
        lable.text = @"月";
    }else if (component == 2){
        lable.text = [self.dayarray objectAtIndex:row];
    }else{
        lable.text = @"日";
    }

    return vv;
}


-(void)comebacky
{
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 101) {
        return _doctorCareModelDataary.count;
    }else{
    return _custommesarray.count;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        static NSString *identifier = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            UIView *cellview = [[UIView alloc] initWithFrame:cell.bounds];
            cellview.tag = 2;
            [cell addSubview:cellview];
        }
        CustomerMessage *cusmes = [_custommesarray objectAtIndex:_custommesarray.count - indexPath.row - 1];
        
        UIView *vi = (UIView *)[cell viewWithTag:2];
        UIView *vv = (UIView *)[vi viewWithTag:3];
        [vv removeFromSuperview];
        
        if (cusmes.NoticeDt == nil || cusmes.NoticeEndDt == nil) {
            cusmes.NoticeDt = self.chatdata1;
            cusmes.NoticeEndDt = self.chatdata2;
        }
        self.CareDate = [NSString stringWithFormat:@"%@ 至 %@",cusmes.NoticeDt,cusmes.NoticeEndDt];
        
        
        NSUserDefaults *myuser = [NSUserDefaults standardUserDefaults];
        NSDictionary *diction = [myuser objectForKey:@"imagedictionarray"];
        
        NSData *imagedata = [diction objectForKey:cusmes.PicSrc];
        
        //fromType发送类型(医生发给客 户:20150213142252612;客户发给医生20150213142231226);fileType发送文件类型(文字 20150213142908837;图片20150213142921851;音频20150213142939496;视频 20150213142950810)
        
        
        //医生发给客户
        if ([cusmes.FromType isEqualToString:@"20150213142252612"]) {
            
            //图片
            if ([cusmes.FileType isEqualToString:@"20150213142921851"]) {
                
                careViewChat *chatview = [[careViewChat alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width tyfrom:@"yisheng" andcontents:cusmes.TextInfo creatdate:self.CareDate andimages:imagedata filetype:cusmes.FileType];
                chatview.tag = 3;
                [vi addSubview:chatview];
                
            }else if ([cusmes.FileType isEqualToString:@"20150213142908837"]){//文字
                
                careViewChat *chatview = [[careViewChat alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width tyfrom:@"yisheng" andcontents:cusmes.TextInfo creatdate:self.CareDate andimages:imagedata filetype:cusmes.FileType];    NSLog(@"文字来了，赋值(%@)",cusmes.TextInfo);
                chatview.tag = 3;
                [vi addSubview:chatview];
                
                
            }else if ([cusmes.FileType isEqualToString:@"20150213142939496"]){//音频
                
                
                careViewChat *chatview = [[careViewChat alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width tyfrom:@"yisheng" andcontents:cusmes.TextInfo creatdate:self.CareDate andimages:imagedata filetype:cusmes.FileType];
                chatview.tag = 3;
                [vi addSubview:chatview];
                
                //视频
            }else{
                
                careViewChat *chatview = [[careViewChat alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width tyfrom:@"yisheng" andcontents:cusmes.TextInfo creatdate:self.CareDate andimages:imagedata filetype:cusmes.FileType];
                chatview.tag = 3;
                [vi addSubview:chatview];
                
            }
            
            
        }else{
            
            //图片
            if ([cusmes.FileType isEqualToString:@"20150213142921851"]) {
                
                careViewChat *chatview = [[careViewChat alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width  tyfrom:@"kehu" andcontents:cusmes.TextInfo creatdate:self.CareDate andimages:imagedata filetype:cusmes.FileType];
                chatview.tag = 3;
                [vi addSubview:chatview];
                
                //文字
            }else if ([cusmes.FileType isEqualToString:@"20150213142908837"]){
                
                careViewChat *chatview = [[careViewChat alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width  tyfrom:@"kehu" andcontents:cusmes.TextInfo creatdate:self.CareDate andimages:imagedata filetype:cusmes.FileType];
                chatview.tag = 3;
                [vi addSubview:chatview];
                
                //音频
            }else if ([cusmes.FileType isEqualToString:@"20150213142939496"]){
                
                careViewChat *chatview = [[careViewChat alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width  tyfrom:@"kehu" andcontents:cusmes.TextInfo creatdate:self.CareDate andimages:imagedata filetype:cusmes.FileType];
                chatview.tag = 3;
                [vi addSubview:chatview];
                
                
                //视频
            }else{
                
                careViewChat *chatview = [[careViewChat alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width  tyfrom:@"kehu" andcontents:cusmes.TextInfo creatdate:self.CareDate andimages:imagedata filetype:cusmes.FileType];
                chatview.tag = 3;
                [vi addSubview:chatview];
                
            }
            
        }
         return cell;
    }else if(tableView.tag == 101){
        
        static NSString *identifier1 = @"cell";
        
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
            
            UIView *cellview = [[UIView alloc] initWithFrame:cell1.bounds];
            cellview.tag = 2;
            [cell1 addSubview:cellview];
        }
        CustomerMessage *cusmes = [_doctorCareModelDataary objectAtIndex:_doctorCareModelDataary.count - indexPath.row - 1];
        
        UIView *vi = (UIView *)[cell1 viewWithTag:2];
        UIView *vv = (UIView *)[vi viewWithTag:3];
        [vv removeFromSuperview];
        
        NSLog(@"模板的信息----》%@",cusmes.TextInfo);
        cell1.backgroundColor = [UIColor clearColor];
        
        caremuban *muban = [[caremuban alloc] initWithFrame:self.view.bounds andcontents:cusmes.TextInfo];
        muban.tag = 3;
        [vi addSubview:muban];
        
        
        return cell1;
    }else{
        return nil;
    }

    
   
    
}
//计算文字内容在规定宽度时候它的显示高度
-(CGFloat)contentsWithnsstring:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(250,2000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
         CustomerMessage *cusmes = [_custommesarray objectAtIndex:_custommesarray.count - indexPath.row - 1];
        
        if ([cusmes.FileType isEqualToString:@"20150213142908837"]) {
            return [self contentsWithnsstring:cusmes.TextInfo] + 40;
        }else{
            return 310;
        }
    }else{
     CustomerMessage *cusmes = [_doctorCareModelDataary objectAtIndex:_doctorCareModelDataary.count - indexPath.row - 1];
        return [self contentsWithnsstring:cusmes.TextInfo] + 40;
    }
   
    

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    NSLog(@"点击了表格");
    
    if (tableView.tag == 101) {
         [self dissmismuban];
        CustomerMessage *cusmes = [_doctorCareModelDataary objectAtIndex:_doctorCareModelDataary.count - indexPath.row - 1];
        _text.text =[NSString stringWithFormat:@"%@%@",_text.text,cusmes.TextInfo];
       
    }
    
    
}
-(void)dissmismuban
{
    if (_mobanview) {
        [_mobanview removeFromSuperview];
        _mobanview = nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- soap请求

//提交客户关怀;fromType发送类型(医生发给客户:20150213142252612; 客户发给医生20150213142231226);fileType发送文件类型(文字20150213142908837;图片 20150213142921851;音频20150213142939496;视频20150213142950810)
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno customerSno:(NSString *)customerSno fromType:(NSString *)fromType fileType:(NSString *)fileType textInfo:(NSString *)textInfo data:(NSString *)data fileTypeName:(NSString *)fileTypeName lastInfoSno:(NSString *)lastInfoSno noticeDt:(NSString *)noticeDt orderDetailSno:(NSString *)orderDetailSno noticeEndDt:(NSString *)noticeEndDt
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SendCustomerCare xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<fromType>%@</fromType>\n"
                             "<fileType>%@</fileType>\n"
                             "<textInfo>%@</textInfo>\n"
                             "<data>%@</data>\n"
                             "<fileTypeName>%@</fileTypeName>\n"
                             "<lastInfoSno>%@</lastInfoSno>\n"
                             "<noticeDt>%@</noticeDt>\n"
                             "<orderDetailSno>%@</orderDetailSno>\n"
                             "<noticeEndDt>%@</noticeEndDt>\n"
                             "</SendCustomerCare>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,customerSno,fromType,fileType,textInfo,data,fileTypeName,lastInfoSno,noticeDt,orderDetailSno,noticeEndDt];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SendCustomerCare" forHTTPHeaderField:@"SOAPAction"];
    
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"post"];//这个有时候可以换一下一种请求方式，不然请求方式错了返回的是HTML格式的代码而且得不到返回值
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    //如果连接已经建好，则初始化data
    if( theConnection )
    {
        //webData = [[NSMutableData data] retain];
        webData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
}

//获取客户留言的数据
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno customerSno:(NSString *)customerSno fromType:(NSString *)fromType
                  strPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorCareCustomerData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<fromType>%@</fromType>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetDoctorCareCustomerData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,customerSno,fromType,strPageindex,strPagesize];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorCareCustomerData" forHTTPHeaderField:@"SOAPAction"];
    
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"post"];//这个有时候可以换一下一种请求方式，不然请求方式错了返回的是HTML格式的代码而且得不到返回值
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    //如果连接已经建好，则初始化data
    if( theConnection )
    {
        //webData = [[NSMutableData data] retain];
        webData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
}
//获取客户关怀模版数据
-(void)soaprequstWithstrPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize orderDetailSno:(NSString *)orderDetailSno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorCareModelData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "<orderDetailSno>%@</orderDetailSno>\n"
                             "</GetDoctorCareModelData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,strPageindex,strPagesize,orderDetailSno];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorCareModelData" forHTTPHeaderField:@"SOAPAction"];
    
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"post"];//这个有时候可以换一下一种请求方式，不然请求方式错了返回的是HTML格式的代码而且得不到返回值
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    //如果连接已经建好，则初始化data
    if( theConnection )
    {
        //webData = [[NSMutableData data] retain];
        webData = [NSMutableData data];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
}

#pragma mark SOAP请求方法
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
    NSHTTPURLResponse *urlresponse = (NSHTTPURLResponse *)response;
    NSLog(@"状态码----》%ld",(long)[urlresponse statusCode]);
    NSLog(@"响应头部信息---》%@",[urlresponse allHeaderFields]);
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
    //NSLog(@"connection: didReceiveData:2");
    
}

//如果电脑没有连接网络，则出现此信息（不是网络服务器不通）
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
    
    // NSLog(@"ERROR with theConenction");
    UIAlertView * alert =
    [[UIAlertView alloc]
     initWithTitle:@"提示"
     message:@"链接超时或无网络!"
     delegate:self
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil];
    [alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // NSLog(@"3 DONE. Received Bytes: %ld", [webData length]);
    NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    NSLog(@"客户关怀--%@",theXML);
    
    //        NSString *str = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    //
    //
    //             NSLog(@"请求回来的数据-2--%@",str);
    
    //重新加載xmlParser
    //    if( xmlParser )
    //    {
    //       // [xmlParser release];
    //    }
    
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
    
    // [connection release];
    //[webData release];
}

#pragma mark - XML数据接收
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"GetDoctorCareCustomerDataResult"]) {
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    
    if ([elementName isEqualToString:@"GetDoctorCareModelDataResult"]) {
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"SendCustomerCareResult"]) {
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
}

// 找到内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // 如果内容太长,会分多次去读,这里需要拼接(追加)
    [_soapResults appendString:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"GetDoctorCareCustomerDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"客户留言的数据：dic%@",dic);
        
        NSMutableArray *ret = [dic objectForKey:@"ret"];
        
        //第一次进来和上啦拉下拉会执行这个方法
        if (self.isRefreshLoading == NO) {
            for (NSDictionary *diction in ret) {
                CustomerMessage *customermes = [CustomerMessage CustomerMessageWithdiction:diction];
                [_custommesarray addObject:customermes];
            }
            self.isRefreshLoading = YES;
            [_tableview reloadData];
            [self tableViewScrollCurrentIndexPath];
        }
        
        //定时请求的消息
        NSMutableArray *newmess = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in ret) {
            CustomerMessage *customermes = [CustomerMessage CustomerMessageWithdiction:diction];
            [newmess addObject:customermes];
        }
        NSInteger newmesscount = newmess.count;
        
        NSInteger a = _custommesarray.count;
        for (int i = 0; i < newmesscount; i ++) {
            CustomerMessage *chat = [_custommesarray objectAtIndex:i];
            CustomerMessage *chat1 = [newmess objectAtIndex:i];
            //判断有没有新的消息
            if ([chat1.TextInfo isEqualToString:chat.TextInfo]) {
                return;
            }else{
                _custommesarray = newmess;//最新的消息
                [_tableview reloadData];
                [self tableViewScrollCurrentIndexPath];
            }
            NSInteger b = _custommesarray.count;
            //有新消息，刷新表格
            if (a != b) {
                [_tableview reloadData];
                [self tableViewScrollCurrentIndexPath];
            }
            
        }
        
    }

        
   
    
    if ([elementName isEqualToString:@"GetDoctorCareModelDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"客户留言的数据：dic%@",dic);
        
        NSMutableArray *doctorCareModelData = [dic objectForKey:@"doctorCareModelData"];
        _doctorCareModelDataary  = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in doctorCareModelData) {
            CustomerMessage *customermes = [CustomerMessage CustomerMessageWithdiction:diction];
            [_doctorCareModelDataary addObject:customermes];
        }
        [_mobantableview reloadData];
        

    }
    
    if ([elementName isEqualToString:@"SendCustomerCareResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"发送给客户的留言的数据：dic%@",dic);
        

        
        
        
    }

    
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------start--------------");
    
    // 创建一个可变字符串
    _soapResults = [[NSMutableString alloc] initWithCapacity:0];//解析开始了，创建空字符串来存
    
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------end--------------");
    
}

@end
