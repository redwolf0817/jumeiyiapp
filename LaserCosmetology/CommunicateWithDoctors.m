//
//  CommunicateWithDoctors.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/5.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "CommunicateWithDoctors.h"
#import "TopBarView.h"
#import "ChatRecord.h"
#import "ChatWithTheDoctor.h"
#import "PrefixHeader.pch"
@interface CommunicateWithDoctors ()

@end

@implementation CommunicateWithDoctors

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 160, 25)];
    titilelable.text = @"与专家对话中";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclickl) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 60)];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = 45;
    _table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_table];
    
    
    _images = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60)];
    _images.image = [UIImage imageNamed:@"dhk_02"];
    _images.userInteractionEnabled = YES;
    [self.view addSubview:_images];
    
//    UIButton *Sound = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 20, 30)];
//    [Sound setBackgroundImage:[UIImage imageNamed:@"liaotiananniu"] forState:UIControlStateNormal];
//    //[Sound addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
//    [_images addSubview:Sound];
    
    _text = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 90, 35)];
    _text.backgroundColor = [UIColor whiteColor];
    _text.layer.masksToBounds = YES;
    _text.layer.cornerRadius = 3;
    _text.delegate = self;
    _text.font = [UIFont systemFontOfSize:17];
    [_images addSubview:_text];
    
    _sendmasses = [[UIButton alloc] initWithFrame:CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, 10, 60, 35)];
    [_sendmasses setBackgroundImage:[UIImage imageNamed:@"xiaoxifasong"] forState:UIControlStateNormal];
    [_sendmasses addTarget:self action:@selector(SendAMessage) forControlEvents:UIControlEventTouchUpInside];
    [_images addSubview:_sendmasses];
    
    self.customerSno = [[NSUserDefaults standardUserDefaults] objectForKey:@"customerSno"];
    self.fromType = @"20150213142231226";//发送类型，客户发给医生
    self.data = @"";
    self.fileTypeName = @"";
    self.lastInfoSno = @"";
    self.noticeDt = @"";
    self.orderDetailSno = @"";
    
    _messarray = [[NSMutableArray alloc] initWithCapacity:0];
    
   _getmesstimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(referenceViewimess) userInfo:nil repeats:YES];
    
    [self soaprequstWithdoctorSno:self.doctorSno customerSno:self.customerSno fromType:@"" strPageindex:@"1" strPagesize:@"40"];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_getmesstimer invalidate];
    _getmesstimer = nil;
}
-(void)referenceViewimess
{
        [self soaprequstWithdoctorSno:self.doctorSno customerSno:self.customerSno fromType:@"" strPageindex:@"1" strPagesize:@"40"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)SendAMessage
{
    if ([_text.text isEqualToString:@""]) {
        
    }else{
        
        ChatRecord *recod = [[ChatRecord alloc] init];
        recod.TextInfo = _text.text;
        recod.FromType = @"20150213142231226";
        recod.FileType = @"20150213142908837";
        
        [_messarray insertObject:recod atIndex:0];
        [_table reloadData];
        
        self.textInfo = _text.text;
        self.fileType = @"20150213142908837";//文件类型，文字
        [self tableViewScrollCurrentIndexPath];
        
        _text.text = @"";
        
        [self soaprequstWithdoctorSno:self.doctorSno customerSno:self.customerSno fromType:self.fromType fileType:self.fileType textInfo:self.textInfo data:self.data fileTypeName:self.fileTypeName lastInfoSno:self.lastInfoSno noticeDt:self.noticeDt orderDetailSno:self.orderDetailSno];
    }
    
//    if (_messarray.count > 0) {
//        ChatRecord *recod = [_messarray objectAtIndex:0];
//    }
    
    _images.frame = CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60);
    _text.frame = CGRectMake(10, 10, self.view.bounds.size.width - 90, 35);
    _sendmasses.frame = CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, _images.frame.size.height - 50, 60, 35);
  
    
}
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
       // self.view.transform=CGAffineTransformMakeTranslation(0, - deltaY);
        NSLog(@"deltaY = %f",deltaY);
        
        float a = [self contentsWithnsstringcell:_text.text];
        NSLog(@"高度 %f-",a);
        
        if (a > 21) {
            
            if (a > 120) {
                a = 120;
            }
            _images.frame = CGRectMake(0, self.view.bounds.size.height - 30 - 252 - a, self.view.bounds.size.width, 30 + a);
            _text.frame = CGRectMake(10, 10, self.view.bounds.size.width - 90, a + 10);
            _sendmasses.frame = CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, _images.frame.size.height - 50, 60, 35);
        }else{
            _images.frame = CGRectMake(0, self.view.bounds.size.height - 60 - 252, self.view.bounds.size.width, 60);
            _sendmasses.frame = CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, 10, 60, 35);
            _text.frame = CGRectMake(10, 10, self.view.bounds.size.width - 90, 35);
        }
        
    }];
    
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        //self.view.transform = CGAffineTransformIdentity;
        _images.frame = CGRectMake(0, self.view.bounds.size.height - _images.frame.size.height, self.view.bounds.size.width, _images.frame.size.height);
         _table.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 80);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}

-(CGFloat)contentsWithnsstringcell:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = CGSizeMake(self.view.bounds.size.width - 90,6000);
    CGRect labelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    CGFloat gaodu = labelRect.size.height;
    return gaodu;
}


- (void)textViewDidChange:(UITextView *)textView{
    
   float a = [self contentsWithnsstringcell:_text.text];
    NSLog(@"高度 %f-",a);
    
    if (a > 21) {
        
        if (a > 120) {
            a = 120;
        }
       _images.frame = CGRectMake(0, self.view.bounds.size.height - 30 - 252 - a, self.view.bounds.size.width, 30 + a);
        _text.frame = CGRectMake(10, 10, self.view.bounds.size.width - 90, a + 10);
        _sendmasses.frame = CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, _images.frame.size.height - 50, 60, 35);
    }else{
        _images.frame = CGRectMake(0, self.view.bounds.size.height - 60 - 252, self.view.bounds.size.width, 60);
         _sendmasses.frame = CGRectMake(_text.frame.size.width + _text.frame.origin.x + 10, 10, 60, 35);
    _text.frame = CGRectMake(10, 10, self.view.bounds.size.width - 90, 35);
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)backbuttonclickl
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReturnRefresh" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIView *cellview = [[UIView alloc] initWithFrame:cell.bounds];
        cellview.tag = 2;
        [cell addSubview:cellview];
    }
    ChatRecord *cusmes = [_messarray objectAtIndex:_messarray.count - indexPath.row - 1];
    ChatRecord *TETE = [_messarray objectAtIndex:0];
    self.lastmess = TETE.TextInfo;
    
    NSLog(@"&&&&&& ---------->> %@ || %@ || %@ <<-------",TETE.TextInfo,TETE.FromType,TETE.FileType);
    UIView *vi = (UIView *)[cell viewWithTag:2];
    UIView *vv = (UIView *)[vi viewWithTag:3];
    [vv removeFromSuperview];
    
    NSLog(@"vv.bounds.size.width = >> %F",cell.bounds.size.width);
    
    NSUserDefaults *myuser = [NSUserDefaults standardUserDefaults];
    NSDictionary *diction = [myuser objectForKey:@"imagedictionarray"];
    
    NSData *imagedata = [diction objectForKey:cusmes.PicSrc];
    
    //fromType发送类型(医生发给客 户:20150213142252612;客户发给医生20150213142231226);fileType发送文件类型(文字 20150213142908837;图片20150213142921851;音频20150213142939496;视频 20150213142950810)
    
    //客户发给医生
    if ([cusmes.FromType isEqualToString:@"20150213142231226"]) {
        
        //图片
        if ([cusmes.FileType isEqualToString:@"20150213142921851"]) {
            
            ChatWithTheDoctor *chatview = [[ChatWithTheDoctor alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width tyfrom:@"kehu" andcontents:cusmes.TextInfo creatdate:cusmes.CreateDt andimages:imagedata filetype:cusmes.FileType];
            chatview.tag = 3;
            [vi addSubview:chatview];
            
        }else if ([cusmes.FileType isEqualToString:@"20150213142908837"]){//文字
            
            ChatWithTheDoctor *chatview = [[ChatWithTheDoctor alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width tyfrom:@"kehu" andcontents:cusmes.TextInfo creatdate:cusmes.CreateDt andimages:imagedata filetype:cusmes.FileType];    NSLog(@"文字来了，赋值(%@)",cusmes.TextInfo);
            chatview.tag = 3;
            [vi addSubview:chatview];
            
            
        }else if ([cusmes.FileType isEqualToString:@"20150213142939496"]){//音频
            
            
            ChatWithTheDoctor *chatview = [[ChatWithTheDoctor alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width tyfrom:@"kehu" andcontents:cusmes.TextInfo creatdate:cusmes.CreateDt andimages:imagedata filetype:cusmes.FileType];
            chatview.tag = 3;
            [vi addSubview:chatview];
            
            //视频
        }else{
            
            ChatWithTheDoctor *chatview = [[ChatWithTheDoctor alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width tyfrom:@"kehu" andcontents:cusmes.TextInfo creatdate:cusmes.CreateDt andimages:imagedata filetype:cusmes.FileType];
            chatview.tag = 3;
            [vi addSubview:chatview];
            
        }
        
        
    }else{
        
        //图片
        if ([cusmes.FileType isEqualToString:@"20150213142921851"]) {
            
            ChatWithTheDoctor *chatview = [[ChatWithTheDoctor alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width  tyfrom:@"yisheng" andcontents:cusmes.TextInfo creatdate:cusmes.CreateDt andimages:imagedata filetype:cusmes.FileType];
            chatview.tag = 3;
            [vi addSubview:chatview];
            
            //文字
        }else if ([cusmes.FileType isEqualToString:@"20150213142908837"]){
            
            ChatWithTheDoctor *chatview = [[ChatWithTheDoctor alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width  tyfrom:@"yisheng" andcontents:cusmes.TextInfo creatdate:cusmes.CreateDt andimages:imagedata filetype:cusmes.FileType];
            chatview.tag = 3;
            [vi addSubview:chatview];
            
            //音频
        }else if ([cusmes.FileType isEqualToString:@"20150213142939496"]){
            
            ChatWithTheDoctor *chatview = [[ChatWithTheDoctor alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width  tyfrom:@"yisheng" andcontents:cusmes.TextInfo creatdate:cusmes.CreateDt andimages:imagedata filetype:cusmes.FileType];
            chatview.tag = 3;
            [vi addSubview:chatview];
            
            
            //视频
        }else{
            
            ChatWithTheDoctor *chatview = [[ChatWithTheDoctor alloc] initWithFrame:self.view.bounds andwidth:self.view.bounds.size.width  tyfrom:@"yisheng" andcontents:cusmes.TextInfo creatdate:cusmes.CreateDt andimages:imagedata filetype:cusmes.FileType];
            chatview.tag = 3;
            [vi addSubview:chatview];
            
        }
        
    }
    

    
    return cell;
}
-(void)tableViewScrollCurrentIndexPath
{
    if (_messarray.count > 0) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_messarray.count-1 inSection:0];
        [_table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatRecord *cusmes = [_messarray objectAtIndex:_messarray.count - indexPath.row - 1];
   
   return  [self contentsWithnsstring:cusmes.TextInfo] + 40;
    
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
//计算字体长度
-(float)NSStringwithsize:(int )a str:(NSString *)string
{
    
    UIFont *font = [UIFont systemFontOfSize:a];
    
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat strwidth = size.width;
    
    return strwidth;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static int a = 1;
    // 假设偏移表格高度的20%进行刷新
    
    if (!_isLoading) { // 判断是否处于刷新状态，刷新中就不执行
        // 取内容的高度：
        //    如果内容高度大于UITableView高度，就取TableView高度
        //    如果内容高度小于UITableView高度，就取内容的实际高度
        float height = scrollView.contentSize.height > _table.frame.size.height ?_table.frame.size.height : scrollView.contentSize.height;
        if ((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2) {
            // 调用上拉刷新方法
            NSLog(@"到底了");
        }
        if (- scrollView.contentOffset.y / _table.frame.size.height > 0.2) {
            _isLoading = YES;
            a++;
            // 调用下拉刷新方法
             NSLog(@"到顶了");
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.50 target:self selector:@selector(shuaxin) userInfo:nil repeats:NO];
            
            [self soaprequstWithdoctorSno:self.doctorSno customerSno:self.customerSno fromType:@"" strPageindex:[NSString stringWithFormat:@"%d",a] strPagesize:@"40"];
             self.isRefreshLoading = NO;
        }
    }
    
   
}
-(void)shuaxin
{
    _isLoading = NO;

}

#pragma mark - SOAP请求
//提交医生/客户交流数据(发送客户关怀);fromType发送类型(医生发给客 户:20150213142252612;客户发给医生20150213142231226);fileType发送文件类型(文字 20150213142908837;图片20150213142921851;音频20150213142939496;视频 20150213142950810)
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno customerSno:(NSString *)customerSno fromType:(NSString *)fromType fileType:(NSString *)fileType textInfo:(NSString *)textInfo data:(NSString *)data fileTypeName:(NSString *)fileTypeName lastInfoSno:(NSString *)lastInfoSno noticeDt:(NSString *)noticeDt orderDetailSno:(NSString *)orderDetailSno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SendDoctorCustomerTalkData xmlns=\"Doc\">\n"
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
                             "</SendDoctorCustomerTalkData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,customerSno,fromType,fileType,textInfo,data,fileTypeName,lastInfoSno,noticeDt,orderDetailSno];
                             
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SendDoctorCustomerTalkData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//获取医生/客户交流数据;根据医生SNO/客户SNO/发送类型(医生发给客户:20150213142252612;客户发给医生20150213142231226)
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno customerSno:(NSString *)customerSno fromType:(NSString *)fromType strPageindex:(NSString *)strPageindex strPagesize:(NSString *)strPagesize
{
    
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorCustomerTalkData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<fromType>%@</fromType>\n"
                             "<strPageindex>%@</strPageindex>\n"
                             "<strPagesize>%@</strPagesize>\n"
                             "</GetDoctorCustomerTalkData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,customerSno,fromType,strPageindex,strPagesize];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorCustomerTalkData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    NSLog(@"提交聊天的数据--%@",theXML);
    
    
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
    
    
    
    
    if ([elementName isEqualToString:@"GetDoctorCustomerTalkDataResult"]) {
        
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
    
    if ([elementName isEqualToString:@"GetDoctorCustomerTalkDataResult"]) {
        
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"聊天记录：dic%@",dic);
        NSString *state = [dic objectForKey:@"state"];
        NSMutableArray *ret = [dic objectForKey:@"ret"];
        if ([state isEqualToString:@"1"]) {
            //第一次进来和上啦拉下拉会执行这个方法
            if (self.isRefreshLoading == NO) {
                for (NSDictionary *diction in ret) {
                    ChatRecord *chat = [ChatRecord ChatRecordWithdiction:diction];
                    [_messarray addObject:chat];
                }
                self.isRefreshLoading = YES;
                [_table reloadData];
                [self tableViewScrollCurrentIndexPath];
            }
            
            //定时请求的消息
            NSMutableArray *newmess = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *diction in ret) {
                ChatRecord *chat = [ChatRecord ChatRecordWithdiction:diction];
                [newmess addObject:chat];
            }
            NSInteger newmesscount = newmess.count;
            
            NSInteger a = _messarray.count;
            for (int i = 0; i < newmesscount; i ++) {
                ChatRecord *chat = [_messarray objectAtIndex:i];
                ChatRecord *chat1 = [newmess objectAtIndex:i];
                //判断有没有新的消息
                if ([chat1.TextInfo isEqualToString:chat.TextInfo]) {
                    return;
                }else{
                    _messarray = newmess;//最新的消息
                    
                    [_table reloadData];
                    [self tableViewScrollCurrentIndexPath];
                }
                NSInteger b = _messarray.count;
                //有新消息，刷新表格
                if (a != b) {
                    
                    [_table reloadData];
                    [self tableViewScrollCurrentIndexPath];
                }
                
            }

        }
        
        
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
