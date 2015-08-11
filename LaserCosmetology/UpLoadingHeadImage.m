//
//  UpLoadingHeadImage.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/4.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "UpLoadingHeadImage.h"
#import "TopBarView.h"
#import "mybutton.h"
#import "pickerimageViewController.h"
#import "MeiRongRiJi.h"
#import "PrefixHeader.pch"
@interface UpLoadingHeadImage ()

@end

@implementation UpLoadingHeadImage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 260, self.view.bounds.size.width, self.view.bounds.size.height - 255)];
    _background.image = [UIImage imageNamed:@"huidi"];
    _background.userInteractionEnabled = YES;
    [self.view addSubview:_background];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"编辑足迹";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclickk) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];

    _commity = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, 30,40, 20)];
    [_commity setTitle:@"发送" forState:UIControlStateNormal];
    [_commity addTarget:self action:@selector(commitybuttonclick) forControlEvents:UIControlEventTouchUpInside];
    _commity.layer.masksToBounds = YES;
    _commity.layer.cornerRadius = 4;
    [topbar addSubview:_commity];
    
    _textv = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width , 100)];
    _textv.text = @"记录一下自己的美容足迹！";
    _textv.font = [UIFont systemFontOfSize:15];
    _textv.layer.masksToBounds = YES;
    _textv.layer.cornerRadius = 2;
    _textv.layoutManager.allowsNonContiguousLayout = NO;//防止满框跳动
    _textv.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    [self.view addSubview:_textv];
    
    
    NSInteger a = 1;
    NSInteger xn = a % 4;
    NSInteger yn = a / 4;
    
    float width = (self.view.bounds.size.width - (15 * 5))/4;
    float heiht = width;
    int x = (15 + width) * xn + 15;
    int y = (15 + heiht) * yn + 170;
    
    UIButton *guoqu = [[UIButton alloc] initWithFrame:CGRectMake( 15, 170, width , width)];
    guoqu.backgroundColor = [UIColor grayColor];
    [guoqu setBackgroundImage:[UIImage imageNamed:@"编辑日志3_03(1)"] forState:UIControlStateNormal];
    [guoqu addTarget:self action:@selector(imageshoosebtnclick1) forControlEvents:UIControlEventTouchUpInside];
    guoqu.tag = 29;
    self.guoqunavergation = NO;
    [self.view addSubview:guoqu];
    
    _addimagebtn = [[UIButton alloc] initWithFrame:CGRectMake( x, y, width , width)];
    _addimagebtn.backgroundColor = [UIColor grayColor];
    [_addimagebtn setBackgroundImage:[UIImage imageNamed:@"编辑日志3_05(1)"] forState:UIControlStateNormal];
    [_addimagebtn addTarget:self action:@selector(imageshoosebtnclick) forControlEvents:UIControlEventTouchUpInside];
    _addimagebtn.tag = 30;
    [self.view addSubview:_addimagebtn];
    
     _imageviewfenlei = [[UIImageView alloc] initWithFrame:CGRectMake(0, 260, self.view.bounds.size.width, 45)];
    _imageviewfenlei.image = [UIImage imageNamed:@"编辑日志3_02"];
    _imageviewfenlei.userInteractionEnabled = YES;
    [self.view addSubview:_imageviewfenlei];
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    image1.image = [UIImage imageNamed:@"编辑日志_06"];
    image1.userInteractionEnabled = YES;
    [_imageviewfenlei addSubview:image1];
    
    UIImageView *image0 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 40, 12, 20, 20)];
    image0.image = [UIImage imageNamed:@"编辑日志_03"];
    image0.userInteractionEnabled = YES;
    [_imageviewfenlei addSubview:image0];
    
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(35, 12, 80, 20)];
    lable1.text = @"选择项目";
    lable1.textColor = [self colorWithRGB:0x434343 alpha:1];
    [_imageviewfenlei addSubview:lable1];
    
    self.projectlable = [[UILabel alloc] initWithFrame:CGRectMake(110, 12, self.view.bounds.size.width - 140, 20)];
    self.projectlable.text = @"";
    self.projectlable.textColor = [self colorWithRGB:0x00c5bb alpha:1];
    [_imageviewfenlei addSubview:self.projectlable];
    
    _meirongfenlei = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 45)];
    [_meirongfenlei setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _meirongfenlei.layer.masksToBounds = YES;
    _meirongfenlei.layer.cornerRadius = 4;
    [_meirongfenlei addTarget:self action:@selector(meirongfenlei) forControlEvents:UIControlEventTouchUpInside];
    [_imageviewfenlei addSubview:_meirongfenlei];
    
    _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 320, self.view.bounds.size.width, 45)];
    _imageview.image = [UIImage imageNamed:@"编辑日志3_02"];
    _imageview.userInteractionEnabled = YES;
    [self.view addSubview:_imageview];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    image2.image = [UIImage imageNamed:@"编辑日志_10"];
    image2.userInteractionEnabled = YES;
    [_imageview addSubview:image2];
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(35, 12, 80, 20)];
    lable2.text = @"公开发表";
    lable2.textColor = [self colorWithRGB:0x434343 alpha:1];
    [_imageview addSubview:lable2];
    
    //创建开关对象
    UISwitch *pSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 70, 7, 60, 20)];
    //给开关添加关联动作, 方法需要实现
    [pSwitch addTarget:self action:@selector(switchMethod:) forControlEvents:UIControlEventValueChanged];
//    //设置ON一边的背景颜色，默认是绿色
//    pSwitch.onTintColor=[UIColor yellowColor];
//    //设置OFF一边的背景颜色，默认是灰色，发现OFF背景颜色其实也是控件”边框“颜色
//    pSwitch.tintColor=[UIColor purpleColor];
//    //设置滑块颜色
//    pSwitch.thumbTintColor=[UIColor greenColor];
    //把开关添加到当前视图中
    [_imageview addSubview:pSwitch];
    
     _imagearry = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self soaprequestwithcustomerSno:self.customerSno];
    
    self.a = 1;
}
-(void)switchMethod:(UISwitch *)swith
{
    
    UISwitch *swi2=(UISwitch *)swith;
    if (swi2.isOn) {
        NSLog(@"On");
        self.ispublic = 1;
    }else{
        NSLog(@"Off");
        self.ispublic = 0;
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];

}

-(UIColor *)colorWithRGB:(int)color alpha:(float)alpha{
    
    return [UIColor colorWithRed:((Byte)(color >> 16))/255.0 green:((Byte)(color >> 8))/255.0 blue:((Byte)color)/255.0 alpha:alpha];
}

-(void)keyboardShow:(NSNotification *)note
{
    if (self.sendmasee == NO) {
        _textv.text = @"";
        self.sendmasee = YES;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark 按钮点击事件
//美容分类
-(void)meirongfenlei{
    
     if (_viewbtn == nil) {
        _viewbtn = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 300, self.view.bounds.size.width, 300)];
        _viewbtn.backgroundColor = [UIColor grayColor];
        _viewbtn.alpha = 0.8;
        [self.view addSubview:_viewbtn];
         
         
         float btnhigth = 25;
         
         float jianxi = 10;
         float x = 10;
         NSInteger hangshu = 0;
         
         if (self.a > 0) {
             for (int j = 0; j < self.a; j++) {
                 UIButton *buttn = (UIButton *)[self.view viewWithTag:j + 10];
                 [buttn removeFromSuperview];
             }
         }
         
         for (int i = 0; i < _SelectProductData.count; i ++) {
             MeiRongRiJi *meirong = [_SelectProductData objectAtIndex:i];
             
             if (x + [self NSStringwithsize:17 str:meirong.ProductorName] + 5 >= self.view.bounds.size.width) {
                 hangshu = hangshu + 1;
                 x = 10;
             }
             NSInteger yh = (5 + btnhigth) * hangshu + jianxi + 10;
             
             UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, yh,10 + [self NSStringwithsize:17 str:meirong.ProductorName], btnhigth)];
             button.titleLabel.font = [UIFont systemFontOfSize:17];
             [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
             [button setTitle:meirong.ProductorName forState:UIControlStateNormal];
             [button addTarget:self action:@selector(titleforclickss:) forControlEvents:UIControlEventTouchUpInside];
             button.tag = 10 + i;
             button.layer.masksToBounds = YES;
             button.layer.cornerRadius = 2;
             button.backgroundColor = [UIColor whiteColor];
             [_viewbtn addSubview:button];
             
             self.btnyhigth = yh + btnhigth;
             x = [self NSStringwithsize:17 str:meirong.ProductorName] + 10 + x + jianxi;
         }
         
         if (self.btnyhigth == 0){
             self.btnyhigth = 160;
         }

    }
    

   self.a++;
    if (self.a % 2 == 1 && _viewbtn) {
        [_viewbtn removeFromSuperview];
        _viewbtn = nil;
    }
}
-(void)titleforclickss:(UIButton *)btn{

    MeiRongRiJi *meirong = [_SelectProductData objectAtIndex:btn.tag - 10];
    self.productSno = meirong.Sno;
    self.projectlable.text = [NSString stringWithFormat:@"#%@",meirong.ProductorName];
    
    self.a++;
    if (self.a % 2 == 1 && _viewbtn) {
        [_viewbtn removeFromSuperview];
        _viewbtn = nil;
    }
}

-(void)imageshoosebtnclick{
    
    pickerimageViewController *picker = [[pickerimageViewController alloc] init];
    picker.delegate1 = self;
    [self.navigationController pushViewController:picker animated:YES];
    
}
-(void)imageshoosebtnclick1{
    
    if (self.guoqunavergation == NO) {
        pickerimageViewController *picker = [[pickerimageViewController alloc] init];
        picker.delegate1 = self;
        self.isoneimage = YES;
        [self.navigationController pushViewController:picker animated:YES];
    }else{
    
        _imagebackview = [[UIView alloc] initWithFrame:self.view.bounds];
        _imagebackview.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_imagebackview];
        
        UIButton *gobackbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 50, 50)];
        [gobackbtn addTarget:self action:@selector(gobackbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [gobackbtn setBackgroundImage:[UIImage imageNamed:@"c"] forState:UIControlStateNormal];
        [_imagebackview addSubview:gobackbtn];
        
        UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 40, 38, 38)];
        [cancel addTarget:self action:@selector(guoqucancelclick) forControlEvents:UIControlEventTouchUpInside];
        [cancel setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [_imagebackview addSubview:cancel];
        
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width,self.lastimage.size.height/(self.lastimage.size.width/self.view.bounds.size.width))];
        imageview.image = self.lastimage;
        [_imagebackview addSubview:imageview];
    }

}
-(void)sendimage:(UIImage *)imagess
{
    if (self.isoneimage == NO) {
        [_imagearry addObject:imagess];
        [self createrimagesAndButtonWith];
    }else{
        
        self.lastimage = imagess;
    [self createrimagesAndButtonWith];
        NSData *_data = UIImageJPEGRepresentation(imagess, 0.4f);
        NSString *_encodedImageStr = [_data base64Encoding];
        self.beforeDdata = _encodedImageStr;
    }

}
-(void)commitybuttonclick{
    
    self.contensstring = _textv.text;
    
    if (self.productSno == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请选择分类" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }else if (_imagearry.count < 1){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请选择现在的照片或者拍照！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }else if (_textv.text.length < 5){
        NSLog(@"self.contensstring.length:%@",self.contensstring);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"内容太少了！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    
    }else{
        UIImage *image = nil;
        if (_imagearry.count > 0) {
            image = [_imagearry objectAtIndex:0];
        }
        NSData *_data = UIImageJPEGRepresentation(image, 0.4f);
        NSString *_encodedImageStr = [_data base64Encoding];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSDictionary *citydic = [userDefaultes objectForKey:@"citydiction"];
        NSString *city = [citydic objectForKey:@"cityname"];
        
        NSString *beforeFileTypeName = @"png";
        if (self.beforeDdata == nil) {
            self.beforeDdata = @"";
            beforeFileTypeName = @"";
        }
        
        [self soaprequestwithorderDetailSno:self.productSno customerSno:self.customerSno isOpen:[NSString stringWithFormat:@"%ld",self.ispublic] contents:self.contensstring beforeDdata:self.beforeDdata beforeFileTypeName:beforeFileTypeName afterData:_encodedImageStr afterFileTypeName:@"png" cityName:city];
        
        _commity.userInteractionEnabled = NO;
        _commity.alpha = 0.5;
        _comittime = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timestop) userInfo:nil repeats:NO];
        
    }

}
-(void)timestop
{
    _commity.userInteractionEnabled = YES;
    _commity.alpha = 1;
    [_comittime invalidate];
    _comittime = nil;

}
-(void)xunhuanshangchuan
{
    if (_imagearry.count > 1) {
        
        for (int a = 1; a < _imagearry.count; a++) {
            UIImage *image = [_imagearry objectAtIndex:a];
            NSData *_data = UIImageJPEGRepresentation(image, 0.4f);
            NSString *_encodedImageStr = [_data base64Encoding];
            
            [self soaprequestwithcustomerSno:self.customerSno logSno:self.logSno data:_encodedImageStr fileTypeName:@"png" infoType:@"after"];
            }
    }

}
-(void)backbuttonclickk
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createrimagesAndButtonWith
{
    
    if (self.isoneimage == YES) {
        UIButton *button = (UIButton *)[self.view viewWithTag:29];
        if (self.lastimage == nil) {
            [button setBackgroundImage:[UIImage imageNamed:@"编辑日志3_03(1)"] forState:UIControlStateNormal];
        }else{
        [button setBackgroundImage:self.lastimage forState:UIControlStateNormal];
        }
        
        [button setTitle:@"过去" forState:UIControlStateNormal];
        [self.view addSubview:button];
        self.isoneimage = NO;
        self.guoqunavergation = YES;
        return;
        
    }else{
    
        [_addimagebtn removeFromSuperview];
        _addimagebtn = nil;
        
        for (int c = 0; c < self.lastbtnindex; c++) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:70 + c];
            [btn removeFromSuperview];
        }
        
        NSInteger a = [_imagearry count] - 1;
        float width = (self.view.bounds.size.width - (15 * 5))/4;
        float heiht = width;
        
        for (int j = 0; j < [_imagearry count]; j ++) {

            NSInteger xn = (j + 1) % 4;
            NSInteger yn = (j + 1) / 4;
            
            int x = (15 + width) * xn + 15;
            int y = (15 + heiht) * yn + 170;
            
            //NSString *title = [NSString stringWithFormat:@"%ld",[array count]];
            NSString *title = [NSString stringWithFormat:@"%d",j + 1];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, heiht)];
            button.backgroundColor = [UIColor redColor];
            [button setBackgroundImage:[_imagearry objectAtIndex:j] forState:UIControlStateNormal];
            [button setTitle:title forState:UIControlStateNormal];
            button.tag = 70 + j;
            [button addTarget:self action:@selector(cancelimageclick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            
            self.lastbtnindex = _imagearry.count;
        }
        
        
        
        
        NSInteger a1 = [_imagearry count] + 1;
        NSInteger xn1 = a1 % 4;
        NSInteger yn1 = a1 / 4;
        
        int x1 = (15 + width) * xn1 + 15;
        int y1 = (15 + heiht) * yn1 + 170;
        
        if (_addimagebtn == nil && _imagearry.count < 5) {
            _addimagebtn = [[UIButton alloc] initWithFrame:CGRectMake(x1, y1, width , heiht)];
            _addimagebtn.backgroundColor = [UIColor grayColor];
            [_addimagebtn setBackgroundImage:[UIImage imageNamed:@"编辑日志3_05(1)"] forState:UIControlStateNormal];
            [_addimagebtn addTarget:self action:@selector(imageshoosebtnclick) forControlEvents:UIControlEventTouchUpInside];
            _addimagebtn.tag = 30;
            [self.view addSubview:_addimagebtn];
        }
        
        if (a == 2) {
            
            _imageviewfenlei.frame = CGRectMake(_imageviewfenlei.frame.origin.x, _imageviewfenlei.frame.origin.y + 15 + heiht, _imageviewfenlei.frame.size.width, _imageviewfenlei.frame.size.height);
            _imageview.frame = CGRectMake(_imageview.frame.origin.x, _imageview.frame.origin.y + 15 + heiht, _imageview.frame.size.width, _imageview.frame.size.height);
            
                _background.frame = CGRectMake(0, 260 + 15 + heiht, self.view.bounds.size.width, self.view.bounds.size.height - 255);
        }else if (a < 2){
        
            _imageviewfenlei.frame = CGRectMake(0, 260, self.view.bounds.size.width, 45);
            _imageview.frame = CGRectMake(0, 320, self.view.bounds.size.width, 45);
        
            _background.frame = CGRectMake(0, 260, self.view.bounds.size.width, self.view.bounds.size.height - 255);

        }
        

    }
    
    
}


-(void)cancelimageclick:(UIButton *)btn{

    NSLog(@"btn.tag-: %ld",btn.tag);
    self.cancelbtnindex = btn.tag - 70;
    
    _imagebackview = [[UIView alloc] initWithFrame:self.view.bounds];
    _imagebackview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_imagebackview];
    
    UIImage *images = [_imagearry objectAtIndex:btn.tag - 70];
    
    NSLog(@"_imagearry .count : %ld---",_imagearry.count);
    
    UIButton *gobackbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 50, 50)];
    [gobackbtn addTarget:self action:@selector(gobackbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [gobackbtn setBackgroundImage:[UIImage imageNamed:@"c"] forState:UIControlStateNormal];
    [_imagebackview addSubview:gobackbtn];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 40, 38, 38)];
    [cancel addTarget:self action:@selector(cancelclick) forControlEvents:UIControlEventTouchUpInside];
    [cancel setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [_imagebackview addSubview:cancel];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width,images.size.height/(images.size.width/self.view.bounds.size.width))];
    imageview.image = images;
    [_imagebackview addSubview:imageview];
    
    
}

-(void)gobackbtnclick{

    [_imagebackview removeFromSuperview];
}
-(void)cancelclick{
    
     [_imagebackview removeFromSuperview];
    [_imagearry removeObjectAtIndex:self.cancelbtnindex];
    
    [self createrimagesAndButtonWith];
}

-(void)guoqucancelclick{
    
    self.beforeDdata = nil;
    self.lastimage = nil;
     [_imagebackview removeFromSuperview];
    self.isoneimage = YES;
    [self createrimagesAndButtonWith];
    self.guoqunavergation = NO;
    
}

#pragma mark-- SOAP请求
//获取客户添加美容日志页面预备数据
-(void)soaprequestwithcustomerSno:(NSString *)customerSno
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetWriteLogPageData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "</GetWriteLogPageData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetWriteLogPageData" forHTTPHeaderField:@"SOAPAction"];
    
    
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


//提交客户美容日志数据
-(void)soaprequestwithorderDetailSno:(NSString *)orderDetailSno customerSno:(NSString *)customerSno  isOpen:(NSString *)isOpen contents:(NSString *)contents beforeDdata:(NSString *)beforeDdata beforeFileTypeName:(NSString *)beforeFileTypeName afterData:(NSString *)afterData afterFileTypeName:(NSString *)afterFileTypeName cityName:(NSString *)cityName
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SendCustomerBeautifyLogData2 xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<orderDetailSno>%@</orderDetailSno>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<isOpen>%@</isOpen>\n"
                             "<contents>%@</contents>\n"
                             "<beforeDdata>%@</beforeDdata>\n"
                             "<beforeFileTypeName>%@</beforeFileTypeName>\n"
                             "<afterData>%@</afterData>\n"
                             "<afterFileTypeName>%@</afterFileTypeName>\n"
                             "<cityName>%@</cityName>\n"
                             "</SendCustomerBeautifyLogData2>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,orderDetailSno,customerSno,isOpen,contents,beforeDdata,beforeFileTypeName,afterData,afterFileTypeName,cityName];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SendCustomerBeautifyLogData2" forHTTPHeaderField:@"SOAPAction"];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//提交客户美容日志图片文件///infoType   before术前   after术后
-(void)soaprequestwithcustomerSno:(NSString *)customerSno logSno:(NSString *)logSno data:(NSString *)data fileTypeName:(NSString *)fileTypeName infoType:(NSString *)infoType
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SendCustomerBeautifyLogFileData2 xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<customerSno>%@</customerSno>\n"
                             "<logSno>%@</logSno>\n"
                             "<data>%@</data>\n"
                             "<fileTypeName>%@</fileTypeName>\n"
                             "<infoType>%@</infoType>\n"
                             "</SendCustomerBeautifyLogFileData2>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,customerSno,logSno,data,fileTypeName,infoType];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SendCustomerBeautifyLogFileData2" forHTTPHeaderField:@"SOAPAction"];
    
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
#pragma mark ---计算文字的长短，大小

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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
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
    //    [connection release];
    //    [webData release];
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
    NSLog(@"写美容日记--%@",theXML);
    
    //        [theXML release];
    
    //        NSString *str = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
    //
    //
    //             NSLog(@"请求回来的数据-2--%@",str);
    
    //重新加載xmlParser
    //    if( xmlParser )
    //    {
    //        [xmlParser release];
    //    }
    
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
    
    //    [connection release];
    //[webData release];
}
#pragma mark - XML数据接收
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"GetWriteLogPageDataResult"]) {//获取本页信息
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"SendCustomerBeautifyLogData2Result"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }

    if ([elementName isEqualToString:@"SendCustomerBeautifyLogFileDataResult"]) {
        
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
    
    
    if ([elementName isEqualToString:@"GetWriteLogPageDataResult"]) {//获取本页信息
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"1122个人中心的数据:%@",dic);
        
        NSMutableArray *ret = [dic objectForKey:@"ret"];
        
        _SelectProductData = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in ret) {
            MeiRongRiJi *meirong = [MeiRongRiJi meirongrijiWithdiction:diction];
            [_SelectProductData addObject:meirong];
        }

    }
    
    if ([elementName isEqualToString:@"SendCustomerBeautifyLogData2Result"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"上传美容日记后返回来的结果:%@",dic);
        
        NSString *msg = [dic objectForKey:@"msg"];
        NSString *ret = [dic objectForKey:@"ret"];
        NSString *state = [dic objectForKey:@"state"];
        
        self.logSno = ret;
        [self xunhuanshangchuan];//循环发送图片
        
        
        static int a = 0;
        
        if ([state isEqualToString:@"1"]) {
             a++;
            
        }
        
        if (_imagearry.count  == 1 && [state isEqualToString:@"1"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            [self backbuttonclickk];
        }
        
 
        
    }
    
    if ([elementName isEqualToString:@"SendCustomerBeautifyLogFileData2Result"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"上传多张图片后返回来的结果:%@",dic);
        
        NSString *msg = [dic objectForKey:@"msg"];
        NSString *state = [dic objectForKey:@"state"];
        
        static int a = 0;
        
        if ([state isEqualToString:@"1"]) {
            a++;
        }
        
        if ((_imagearry.count - 1) == a) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.tag = 15;
            [alert show];
        }
        
        if ([state isEqualToString:@"0"]) {
            [self timestop];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
        
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 15) {
    [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------start--------------");
    
    // 创建一个可变字符串
    _soapResults = [[NSMutableString alloc] initWithCapacity:0];//解析要开始了，创建空字符串来存
    
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"-------------------end--------------");
}

@end
