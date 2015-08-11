//
//  StarBeauticianViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/11.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "StarBeauticianViewController.h"
#import "TopBarView.h"
#import "zhuanjiashuju.h"
#import "UIImageView+WebCache.h"
#import "AudioStreamer.h"
#import "begoogatbeauty.h"
#import "Detailsproject2.h"
#import "CommunicateWithDoctors.h"
#import "StarBeautycell.h"
#import "doctorSuccessCaseVC.h"
#import "doctorSuccessdetaile.h"
#import "ShareSDK/ShareSDK.h"
#import "PrefixHeader.pch"
@interface StarBeauticianViewController ()
{
    AudioStreamer *streamer;
}
@end


@implementation StarBeauticianViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [_scrollerView removeFromSuperview];
    _scrollerView = nil;
    
   
   NSLog(@"AA");
}
-(void)dealloc
{
    
    NSLog(@"BB");
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
     self.AA = 0;
    if (self.AA != 0) {
        [self viewDidLoad];
    }
    self.AA++;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height - 44)];
    _scrollerView.contentSize = CGSizeMake(0, self.view.bounds.size.height- 44);
    _scrollerView.pagingEnabled = YES;
    _scrollerView.delegate = self;
    _scrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollerView];
    
    
    NSArray *backeimage = [[NSArray alloc] initWithObjects:@"专家详情页_03s",@"专家详情页_06s",@"专家详情页_08s", nil];
    _anniubutton1 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 50, 80, 30, 30)];
    _anniubutton1.tag = 10;
    [_anniubutton1 setBackgroundImage:[UIImage imageNamed:[backeimage objectAtIndex:0]] forState:UIControlStateNormal];
    [_anniubutton1 addTarget:self action:@selector(playmusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_anniubutton1];
    
    _anniubutton2 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 50,50  + 80, 30, 30)];
    _anniubutton2.tag = 11;
    [_anniubutton2 setBackgroundImage:[UIImage imageNamed:[backeimage objectAtIndex:1]] forState:UIControlStateNormal];
    [_anniubutton2 addTarget:self action:@selector(playmusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_anniubutton2];
    
    _anniubutton3 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 50,50 * 2 + 80, 30, 30)];
    _anniubutton3.tag = 12;
    [_anniubutton3 setBackgroundImage:[UIImage imageNamed:[backeimage objectAtIndex:2]] forState:UIControlStateNormal];
    [_anniubutton3 addTarget:self action:@selector(playmusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_anniubutton3];
    
    _images = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 25, self.view.bounds.size.height - 70, 60, 50)];
    _images.image = [UIImage imageNamed:@"专家详情页xs_07"];
    [self.view addSubview:_images];
    
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = self.doctorname;
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];

    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    
    UIButton *fenxiang = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 50, 25, 40, 40)];
    [fenxiang setBackgroundImage:[UIImage imageNamed:@"fx"] forState:UIControlStateNormal];
    [fenxiang addTarget:self action:@selector(gotofenxiangclickd) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:fenxiang];
    
    NSLog(@"传过来的专家Sno-%@",self.sno);
    NSUserDefaults *userdf = [NSUserDefaults standardUserDefaults];
    self.customerSno = [userdf objectForKey:@"customerSno"];

    [self soaprequstWithSno:self.sno cusSno:self.customerSno];

    if (self.notifi) {
    }else{
        self.notifi = [NSNotificationCenter defaultCenter];
        [self.notifi addObserver:self selector:@selector(ReturnRefreshs) name:@"ReturnRefresh" object:nil];
    }

    
}
-(void)ReturnRefreshs
{
    [self viewDidLoad];
}

-(void)creatmuseebutton
{
    NSLog(@"self.isFocus-->%@",self.isFocus);
    if ([self.isFocus isEqualToString:@"1"]) {
        [_anniubutton2 setBackgroundImage:[UIImage imageNamed:@"专家详情页guanzhu_03"] forState:UIControlStateNormal];
    }else{
        [_anniubutton2 setBackgroundImage:[UIImage imageNamed:@"专家详情页_06s"] forState:UIControlStateNormal];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    float a =  _scrollerView.contentOffset.y;
    float b = _scrollerView.contentSize.height - (self.view.bounds.size.height - 44);
    if (a >= b) {
        _images.alpha = 0;
        _anniubutton1.alpha = 0;
        _anniubutton2.alpha = 0;
        _anniubutton3.alpha = 0;

    }else{
        _images.alpha = 1;

        _anniubutton1.alpha = 1;
        _anniubutton2.alpha = 1;
        _anniubutton3.alpha = 1;
    }
    
}

-(void)creatbackeimage
{

    
    
     _scrollerView.contentSize = CGSizeMake(0, (self.view.bounds.size.height- 44) * (_doctorPicDataArray.count + 1));
    
    for (int i = 0; i < _doctorPicDataArray.count; i++) {
        
        zhuanjiashuju *zj = [_doctorPicDataArray objectAtIndex:i];
        UIImageView *slideimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.height- 44) * i, self.view.bounds.size.width, self.view.bounds.size.height- 44)];
        [slideimage sd_setImageWithURL:[NSURL URLWithString:zj.PicSrc]];
        NSLog(@"zj.PicSrc:%@",zj.PicSrc);
        [_scrollerView addSubview:slideimage];
        
        [self creattheimageandlablewithintege:i and:zj.PicDesc];
    }
   
    [self creatscrollerviewwith];
}

-(void)creattheimageandlablewithintege:(int )a and:(NSString *)str
{       NSLog(@"gggggggg--%d",a);
    switch (a % 5) {
        case 0:
        {
            UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.height- 44) * (a+1) - 200, self.view.bounds.size.width, 120)];
            image1.image = [UIImage imageNamed:@"zhuanjiabeijing"];
            [_scrollerView addSubview:image1];
            
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 15,  self.view.bounds.size.width - 10, 90)];
            lable.numberOfLines = 0;
            lable.text = str;
            lable.textColor = [UIColor whiteColor];
            [image1 addSubview:lable];
        }
            break;
        case 1:
        {
            UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, (self.view.bounds.size.height- 44) * a + 30, self.view.bounds.size.width - 120, self.view.bounds.size.width - 120)];
            image2.image = [UIImage imageNamed:@"zhuanjiabeijing3"];
            [_scrollerView addSubview:image2];
            
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(35, 35, self.view.bounds.size.width - 120 - 50, self.view.bounds.size.width - 120 - 70)];
            lable.numberOfLines = 0;
            lable.text = str;
            lable.textColor = [UIColor whiteColor];
            [image2 addSubview:lable];
        }
            break;
        case 2:
        {
            UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.height- 44) * (a+1) - 200, self.view.bounds.size.width, 120)];
            image3.image = [UIImage imageNamed:@"zhuanjiabeijing2"];
            [_scrollerView addSubview:image3];
            
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10,  self.view.bounds.size.width - 10, 100)];
            lable.numberOfLines = 0;
            lable.text = str;
            lable.textColor = [UIColor whiteColor];
            [image3 addSubview:lable];
        }
            break;
        case 3:
        {
            UIImageView *image4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, (self.view.bounds.size.height- 44) * a + 80, self.view.bounds.size.width/3, self.view.bounds.size.height/3 + 50)];
            image4.image = [UIImage imageNamed:@"zhuanjiabeijing1"];
            [_scrollerView addSubview:image4];
            
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, self.view.bounds.size.width/3 - 30, self.view.bounds.size.height/3 + 50 - 30)];
            lable.numberOfLines = 0;
            lable.text = str;
            lable.textColor = [UIColor whiteColor];
            [image4 addSubview:lable];
        }
            break;
        case 4:
        {
            
            UIImageView *image5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.view.bounds.size.height- 44) * a + self.view.bounds.size.height/2, self.view.bounds.size.width, 120)];
            image5.image = [UIImage imageNamed:@"zhuanjiabeijing4"];
            [_scrollerView addSubview:image5];
            
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 15,self.view.bounds.size.width - 10, 90)];
            lable.numberOfLines = 0;
            lable.text = str;
            lable.textColor = [UIColor whiteColor];
            [image5 addSubview:lable];
        }
            break;
            
        default:
            break;
    }

   

}
-(void)creatscrollerviewwith
{
    
    UIImageView *morebacke = [[UIImageView alloc] initWithFrame:CGRectMake(0, _scrollerView.bounds.size.height * _doctorPicDataArray.count + 20, self.view.bounds.size.width, 35)];
    morebacke.image = [UIImage imageNamed:@"huisedi"];
    morebacke.userInteractionEnabled = YES;
    [_scrollerView addSubview:morebacke];
    
    UILabel *leftlable = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 120, 20)];
    leftlable.text = @"美容案例";
    leftlable.userInteractionEnabled = YES;
    [morebacke addSubview:leftlable];
    
    UILabel *lablerigth = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 8, 50, 20)];
    lablerigth.text = @"更多";
    lablerigth.userInteractionEnabled = YES;
    [morebacke addSubview:lablerigth];
    
    UIButton *more = [[UIButton alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 35)];
    [more addTarget:self action:@selector(moerbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [morebacke addSubview:more];
    
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,_scrollerView.bounds.size.height * _doctorPicDataArray.count + 55, self.view.bounds.size.width, self.view.bounds.size.height - 310 - 64)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [_scrollerView addSubview:tableview];
    

    
    UIView *mviw = [[UIView alloc] initWithFrame:CGRectMake(0,_scrollerView.bounds.size.height  * _doctorPicDataArray.count + _scrollerView.bounds.size.height - 310 , self.view.bounds.size.width, 30)];
    [_scrollerView addSubview:mviw];
    
    UIImageView *huidi = [[UIImageView alloc] initWithFrame:CGRectMake(0,0 , self.view.bounds.size.width, 30)];
    huidi.image = [UIImage imageNamed:@"huisedi"];
    huidi.userInteractionEnabled = YES;
    [mviw addSubview:huidi];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 20)];
    lable.textColor = [UIColor blackColor];
    lable.text = @"擅长美容项目";
    lable.font = [UIFont systemFontOfSize:17];
    [mviw addSubview:lable];
    
    _littlescrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,_scrollerView.bounds.size.height * _doctorPicDataArray.count + _scrollerView.bounds.size.height - 280, self.view.bounds.size.width, 200)];
    _littlescrollerView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    _littlescrollerView.pagingEnabled = YES;
    _littlescrollerView.backgroundColor = [UIColor clearColor];
    [_scrollerView addSubview:_littlescrollerView];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, _scrollerView.bounds.size.height  * _doctorPicDataArray.count + _scrollerView.bounds.size.height - 45, self.view.bounds.size.width/2, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    [button setTitle:@"在线咨询" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(butonclick) forControlEvents:UIControlEventTouchUpInside];
    button.center = CGPointMake(self.view.bounds.size.width/2, _scrollerView.bounds.size.height  * _doctorPicDataArray.count + _scrollerView.bounds.size.height - 60);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4;
    [_scrollerView addSubview:button];
    
    [self creatitemes];
}
-(void)creatitemes
{
    
    
    for (int i = 0; i < _beautifyProDataArray.count; i++) {
        zhuanjiashuju *zj = [_beautifyProDataArray objectAtIndex:i];
        NSLog(@"_beautifyProDataArray.count-%ld",_beautifyProDataArray.count);

        
            begoogatbeauty *begoodat = [[begoogatbeauty alloc] initWithFrame:CGRectMake((5 + (self.view.bounds.size.width - 20)/3)* 1.5 * i + 5, 5,(self.view.bounds.size.width - 20)/3 * 1.5, _littlescrollerView.bounds.size.height ) imagename:zj.BeautifyProPic itemes:zj.BeautifyProName prices:zj.SellPrice];
            [_littlescrollerView addSubview:begoodat];
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((5 + (self.view.bounds.size.width - 20)/3)* 1.5 * i + 5, 5,(self.view.bounds.size.width - 20)/3 * 1.5, _littlescrollerView.bounds.size.height )];
            [button addTarget:self action:@selector(gotodetail:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 30 + i;
            [_littlescrollerView addSubview:button];


    }
    
    
}
-(void)moerbtnclick
{
    NSLog(@"点击了更多--》");
    
    doctorSuccessCaseVC *doctorsuccess = [[doctorSuccessCaseVC alloc] init];
    doctorsuccess.mydataarray = _doctorSuccessCaseArray;
    [self.navigationController pushViewController:doctorsuccess animated:YES];
}
-(void)gotodetail:(UIButton *)btn
{
    NSInteger a = btn.tag - 30;
    zhuanjiashuju *zj = [_beautifyProDataArray objectAtIndex:a];
    self.projectSno = zj.ProductSno;
    
    Detailsproject2 *detail = [[Detailsproject2 alloc] init];
    detail.doctorSno = self.sno;
    detail.doctorname = self.doctorname;
    detail.customerSno = self.customerSno;
    detail.sno = self.projectSno;
    detail.EnumName = zj.BeautifyProName;
    detail.hostitalname = self.hospitolname;
    NSLog(@"在医生详情页面获取的-zj.HospitalName-%@",self.hospitolname);
    
    [self.navigationController pushViewController:detail animated:YES];

}

-(void)butonclick
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *iscustomer =[user objectForKey:@"CommomUserORCommomDoctor"];
    
    if ([iscustomer isEqualToString:@"CommomUser"]) {
        NSLog(@"是否进来CommomUser");
        CommunicateWithDoctors *comi = [[CommunicateWithDoctors alloc] init];
        comi.doctorSno = self.sno;
        [self.navigationController pushViewController:comi animated:YES];
        
    }else{
        
        NSLog(@"是否进来CommomDoctor");
        UIAlertView *alerter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您不是客户，请去个人中心登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alerter show];
    }
    

}
-(void)backbuttonclick
{
    [self destroyStreamer];
    [self.navigationController popViewControllerAnimated:YES];
    

}
-(void)gotofenxiangclickd
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1688" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"小朋友，不要点击哦！！！！！！！！！！！！！！！！ "
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]//http://jk.jumeiyiyun.com/Front/Share/SharpPage.aspx?source=quickbuy
                                                title:@"聚美医"
                                                  url:@"http://news.xinhuanet.com/photo/2015-05/20/127819845_14320779697971n.jpg"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];//
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //[container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
    

}
#pragma mark --- tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _doctorSuccessCaseArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    StarBeautycell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[StarBeautycell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    zhuanjiashuju *zj = [_doctorSuccessCaseArray objectAtIndex:indexPath.row];
    
    cell.projectname.text = zj.Title;
    cell.projectcontents.text = zj.Remark;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    zhuanjiashuju *zj = [_doctorSuccessCaseArray objectAtIndex:indexPath.row];
    
    doctorSuccessdetaile *doctor = [[doctorSuccessdetaile alloc] init];
    doctor.sno = zj.Sno;
    doctor.ReturnRefresh = @"1";
    [self.navigationController pushViewController:doctor animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark--soap请求
//获取医生数据
-(void)soaprequstWithSno:(NSString *)sno cusSno:(NSString *)cusSno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorBySno xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<sno>%@</sno>\n"
                             "<cusSno>%@</cusSno>\n"
                             "</GetDoctorBySno>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,sno,cusSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorBySno" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//添加客户关注医生数据
-(void)soaprequstWithcustomerSno:(NSString *)customerSno doctorSno:(NSString *)doctorSno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<CustomerFocusOnDoctor xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "</CustomerFocusOnDoctor>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,doctorSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/CustomerFocusOnDoctor" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//取消客户关注医生数据
-(void)soaprequstDeleteCustomerFocusOnDoctorWithcustomerSno:(NSString *)customerSno doctorSno:(NSString *)doctorSno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<DeleteCustomerFocusOnDoctor xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "</DeleteCustomerFocusOnDoctor>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,doctorSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/DeleteCustomerFocusOnDoctor" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    
    NSLog(@"专家数据theXML-%@",theXML);
    
    //NSString *str = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    
    
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
    
    
    
    
    if ([elementName isEqualToString:@"GetDoctorBySnoResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
        
    }
    
    if ([elementName isEqualToString:@"CustomerFocusOnDoctorResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
        
    }
    
    if ([elementName isEqualToString:@"DeleteCustomerFocusOnDoctorResult"]) {
        
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
    
    
    if ([elementName isEqualToString:@"GetDoctorBySnoResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"专家数据:%@",dic);
        
        NSMutableArray *array = [dic objectForKey:@"DoctorData"];
        _DoctorDataArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *doctdic in array) {
            zhuanjiashuju *zhuanjia = [zhuanjiashuju  zhuanjiaDetails:doctdic];
            [_DoctorDataArray addObject:zhuanjia];
        }
        
        NSMutableArray *doctorSuccessCase = [dic objectForKey:@"doctorSuccessCase"];
        _doctorSuccessCaseArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *doctdic in doctorSuccessCase) {
            zhuanjiashuju *zhuanjia = [zhuanjiashuju  zhuanjiaDetails:doctdic];
            [_doctorSuccessCaseArray addObject:zhuanjia];
        }
        
        
        NSMutableArray *barray = [dic objectForKey:@"beautifyProData"];
        _beautifyProDataArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *doctdic in barray) {
            zhuanjiashuju *zhuanjia = [zhuanjiashuju  zhuanjiaDetails:doctdic];
            [_beautifyProDataArray addObject:zhuanjia];
        }

        NSMutableArray *darray = [dic objectForKey:@"doctorPicData"];
        _doctorPicDataArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *doctdic in darray) {
            zhuanjiashuju *zhuanjia = [zhuanjiashuju  zhuanjiaDetails:doctdic];
            [_doctorPicDataArray addObject:zhuanjia];
        }
        [self creatbackeimage];
        
        if ([dic objectForKey:@"musicData"]) {
            self.musicData = [dic objectForKey:@"musicData"];
            NSLog(@"音频接口：%@",self.musicData);
            [self voluntaryplaymusic];
        }
        
        self.isFocus = [NSString stringWithFormat:@"%@",[dic objectForKey:@"isFocus"]];
       
        [self creatmuseebutton];
     }
    
  
    if ([elementName isEqualToString:@"CustomerFocusOnDoctorResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"关注医生 = %@",dic);
        NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            self.isFocus = @"1";
        }
        
        NSString *strinf = [dic objectForKey:@"msg"];
        UIAlertView *allert = [[UIAlertView alloc] initWithTitle:@"提示" message:strinf delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [allert show];
    }
    
    if ([elementName isEqualToString:@"DeleteCustomerFocusOnDoctorResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        
        NSLog(@"取消关注医生 = %@",dic);
        NSString *state = [dic objectForKey:@"state"];
        if ([state isEqualToString:@"1"]) {
            self.isFocus = @"0";
        }
        
        NSString *strinf = [dic objectForKey:@"msg"];
        
        UIAlertView *allert = [[UIAlertView alloc] initWithTitle:@"提示" message:strinf delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [allert show];
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
-(void)voluntaryplaymusic
{
    if (!streamer) {
        [self createStreamer];
    }
    [streamer start];



}

-(void)playmusic:(UIButton *)button
{
    static int a = 0;
    if(button.tag == 10)
    {
            if (!streamer) {
                [self createStreamer];
                [streamer start];
            }else{
                if (a % 2 == 0) {
                    [streamer pause];
                   [button setBackgroundImage:[UIImage imageNamed:@"专家详情页2_03s"] forState:UIControlStateNormal];
                }else{
                    [button setBackgroundImage:[UIImage imageNamed:@"专家详情页_03s"] forState:UIControlStateNormal];
                    [streamer start];
                }
           }
    }else if (button.tag == 12){
        _scrollerView.contentOffset = CGPointMake(0, _scrollerView.contentSize.height - (self.view.bounds.size.height - 44));
    }else{
        
        if ([self.isFocus isEqualToString:@"1"]) {
            [button setBackgroundImage:[UIImage imageNamed:@"专家详情页_06s"] forState:UIControlStateNormal];
            [self soaprequstDeleteCustomerFocusOnDoctorWithcustomerSno:self.customerSno doctorSno:self.sno];
        }else{
            [button setBackgroundImage:[UIImage imageNamed:@"专家详情页guanzhu_03"] forState:UIControlStateNormal];
            [self soaprequstWithcustomerSno:self.customerSno doctorSno:self.sno];
        }
        NSLog(@"self.isFocus----> %@",self.isFocus);
    }
    a++;
}

- (void)createStreamer
{
    [self destroyStreamer];
    
    NSString *escapedValue =
    ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                           nil,
                                                                           (CFStringRef)self.musicData,
                                                                           NULL,
                                                                           NULL,
                                                                           kCFStringEncodingUTF8)) ;
    ;
    NSURL *url = [NSURL URLWithString:escapedValue];
    streamer = [[AudioStreamer alloc] initWithURL:url];
    
    
}

- (void)destroyStreamer
{
    if (streamer)
    {
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:streamer];
        
        [streamer stop];
        streamer = nil;
    }
}


@end
