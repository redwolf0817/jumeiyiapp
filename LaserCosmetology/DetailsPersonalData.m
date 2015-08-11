//
//  DetailsPersonalData.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/6/8.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//
#define UID @"wdc001"
#define PSW @"dcg658"

#import "DetailsPersonalData.h"
#import "TopBarView.h"
#import "detailsTableViewCell.h"
#import "persens.h"
#import "PrefixHeader.pch"
@interface DetailsPersonalData ()

@end

@implementation DetailsPersonalData

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"详细资料";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
    
    
    self.endediting = [[UILabel alloc] init];
    self.endediting.text = @"结束编辑";
    self.endediting.frame = CGRectMake(self.view.bounds.size.width - 80, 0, 0, 0);
    self.endediting.textColor = [UIColor whiteColor];
    self.endediting.font = [UIFont systemFontOfSize:17];
    self.endediting.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:self.endediting];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(xiangxizlbackbtn) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 )];
    [self.view addSubview:scrollview];
    
    background = [[UIImageView alloc] initWithFrame:scrollview.bounds];
    background.image = [UIImage imageNamed:@"huidi"];
    background.userInteractionEnabled = YES;
    [scrollview addSubview:background];
    
    UILabel *namelb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 50, 20)];
    namelb.text = @"姓名:";
    [scrollview addSubview:namelb];
    
    nametextf = [[UITextField alloc] initWithFrame:CGRectMake(60, 8, 110, 25)];
    nametextf.backgroundColor = [UIColor whiteColor];
    nametextf.delegate = self;
    [scrollview addSubview:nametextf];
    
    UILabel *sex = [[UILabel alloc] initWithFrame:CGRectMake(scrollview.bounds.size.width - 120, 10, 50, 20)];
    sex.text = @"性别:";
    [scrollview addSubview:sex];
    
    segmented = [[UISegmentedControl alloc] initWithItems:@[@"男",@"女"]];
    segmented.frame = CGRectMake(scrollview.bounds.size.width - 120 + 40, 10, 70, 20);
    segmented.selectedSegmentIndex = 1;
    self.SexType = [NSString stringWithFormat:@"%d",1];
    [segmented addTarget:self action:@selector(shoosesexbtn:) forControlEvents:UIControlEventValueChanged];
    [scrollview addSubview:segmented];
    
    UILabel *hospital = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 50, 20)];
    hospital.text = @"医院:";
    [scrollview addSubview:hospital];
    
    hospitaltf = [[UILabel alloc] initWithFrame:CGRectMake(60, 38, scrollview.bounds.size.width - 70, 25)];
    hospitaltf.backgroundColor = [UIColor whiteColor];
    [scrollview addSubview:hospitaltf];
    
    UILabel *Post = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 50, 20)];
    Post.text = @"职务:";
    [scrollview addSubview:Post];
    
    Posttf = [[UITextField alloc] initWithFrame:CGRectMake(60, 68, scrollview.bounds.size.width - 70, 25)];
    Posttf.backgroundColor = [UIColor whiteColor];
    Posttf.delegate = self;
    [scrollview addSubview:Posttf];
    
    
    UILabel *publicPost = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 80, 20)];
    publicPost.text = @"社会职务:";
    [scrollview addSubview:publicPost];
    
    publicPosttf = [[UITextField alloc] initWithFrame:CGRectMake(90, 98, scrollview.bounds.size.width - 100, 25)];
    publicPosttf.placeholder = @"协会或协会任职";
    publicPosttf.backgroundColor = [UIColor whiteColor];
    publicPosttf.delegate = self;
    [scrollview addSubview:publicPosttf];
    
    
    UILabel *Qualifications = [[UILabel alloc] initWithFrame:CGRectMake(15, 130, 50, 20)];
    Qualifications.text = @"资质:";
    [scrollview addSubview:Qualifications];
    
    Qualificationstf = [[UITextField alloc] initWithFrame:CGRectMake(60, 128, scrollview.bounds.size.width - 70, 25)];
    Qualificationstf.backgroundColor = [UIColor whiteColor];
    Qualificationstf.delegate = self;
    [scrollview addSubview:Qualificationstf];

    
    UILabel *Area = [[UILabel alloc] initWithFrame:CGRectMake(15, 160, 50, 20)];
    Area.text = @"地区:";
    [scrollview addSubview:Area];
    
    Areatf = [[UITextField alloc] initWithFrame:CGRectMake(60, 158, scrollview.bounds.size.width - 70, 25)];
    Areatf.backgroundColor = [UIColor whiteColor];
    Areatf.delegate = self;
    [scrollview addSubview:Areatf];
    
    UIImageView *imagelinsup = [[UIImageView alloc] initWithFrame:CGRectMake(5, 200, scrollview.bounds.size.width - 10, 1)];
    imagelinsup.image = [UIImage imageNamed:@"hengxian"];
    [scrollview addSubview:imagelinsup];
    
    UILabel *doctorproduction = [[UILabel alloc] initWithFrame:CGRectMake(15, 210, 80, 20)];
    doctorproduction.text = @"医生介绍";
    [scrollview addSubview:doctorproduction];
    
    _Introduction = [[UITextView alloc] initWithFrame:CGRectMake(5, 235, self.view.bounds.size.width - 10, 120)];
    _Introduction.font = [UIFont systemFontOfSize:17];
    _Introduction.delegate = self;
    [scrollview addSubview:_Introduction];
    
    UIImageView *imagelins = [[UIImageView alloc] initWithFrame:CGRectMake(5, 360, scrollview.bounds.size.width - 10, 1)];
    imagelins.image = [UIImage imageNamed:@"hengxian"];
    [scrollview addSubview:imagelins];
    
    UILabel *begoodat = [[UILabel alloc] initWithFrame:CGRectMake(15, 370, 80, 20)];
    begoodat.text = @"擅长项目:";
    [scrollview addSubview:begoodat];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(95, 370, 80, 20)];
    [button setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    [button setTitle:@"选择项目" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(xiangmufenleibtnclickss:) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:button];
    
    commit = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40, scrollview.bounds.size.height - 60, 100, 30)];
    [commit setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
    [commit setTitle:@"提交资料" forState:UIControlStateNormal];
    [commit addTarget:self action:@selector(commitbtnclickw) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:commit];
    
    self.numberary = [[NSMutableArray alloc] initWithCapacity:0];
    self.proSnosaryindex = [[NSMutableArray alloc] initWithCapacity:0];
    self.resut = [[NSMutableArray alloc] initWithCapacity:0];
    self.proSnos = @"";
    
    [self soaprequstWithdoctorSno:self.doctorSno];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    
    NSLog(@"deltaY--%f",deltaY);
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.endediting.frame = CGRectMake(self.view.bounds.size.width - 80, 30, 80, 20);
        self.endediting.text = @"结束编辑";
        _Introduction.frame = CGRectMake(5, self.view.bounds.size.height - deltaY - 140, self.view.bounds.size.width - 10, 140);
        [self.view addSubview:_Introduction];
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        //self.view.transform = CGAffineTransformIdentity;

        self.endediting.frame = CGRectMake(self.view.bounds.size.width - 80, 0, 0, 0);
        self.endediting.text = @"";
        _Introduction.frame = CGRectMake(5, 235, self.view.bounds.size.width - 10, 120);
        [scrollview addSubview:_Introduction];
    }];
}


-(void)shoosebuttonclick
{

}
-(void)shoosesexbtn:(UISegmentedControl *)segmen
{
    
    self.SexType = [NSString stringWithFormat:@"%ld",segmen.selectedSegmentIndex];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    return [textView resignFirstResponder];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)commitbtnclickw
{
    
    self.trueName = nametextf.text;
    self.postName = Posttf.text;
    self.societyPostName = publicPosttf.text;
    self.contents = _Introduction.text;
    self.qualification = Qualificationstf.text;
    self.district = Areatf.text;
    
    [self soaprequstWithdoctorSno:self.doctorSno trueName:self.trueName postName:self.postName societyPostName:self.societyPostName qualification:self.qualification district:self.district contents:self.contents proSnos:self.proSnos sexType:self.SexType];

    NSLog(@"self.doctorSno-%@ --self.trueName-%@ --self.postName--%@ --self.societyPostName-%@--self.qualification- %@--self.district- %@--self.contents- %@ --self.proSnos%@ ",self.doctorSno,self.trueName,self.postName,self.societyPostName,self.qualification,self.district,self.contents,self.proSnos);
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)xiangxizlbackbtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)xiangmufenleibtnclickss:(UIButton *)button
{
    if (self.isfenlei == NO) {
        
        self.Righttableview = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40, 64, self.view.bounds.size.width/2 + 40, self.view.bounds.size.height - 64)];
        self.Righttableview.delegate = self;
        self.Righttableview.dataSource = self;
        self.Righttableview.tag = 212;
        self.Righttableview.showsVerticalScrollIndicator = NO;
        self.Righttableview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.Righttableview];
        
        self.isfenlei = YES;
        
        self.shoosebackimage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40, self.view.bounds.size.height - 40, self.view.bounds.size.width/2 + 40, 40)];
        self.shoosebackimage.image = [UIImage imageNamed:@"医生主页1_022"];
        [self.view addSubview:self.shoosebackimage];
        
        self.shoosebtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 40 + (self.view.bounds.size.width/2 + 40)/2 - 40, self.view.bounds.size.height - 35, 80, 30)];
        [self.shoosebtn setBackgroundImage:[UIImage imageNamed:@"大按钮s"] forState:UIControlStateNormal];
        [self.shoosebtn setTitle:@"选择完毕" forState:UIControlStateNormal];
        [self.shoosebtn addTarget:self action:@selector(removeshoosetableviewFromSuperviews) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.shoosebtn];

    }else{

        [self removeshoosetableviewFromSuperviews];

    }
    
}
-(void)reloadviewdata
{
    
    nametextf.text = self.trueName;
    segmented.selectedSegmentIndex = [self.SexType integerValue];
    hospitaltf.text = self.hospitalName ;
    Posttf.text = self.postName;
    publicPosttf.text = self.societyPostName;
    Qualificationstf.text =self.qualification;
    Areatf.text = self.district;
    _Introduction.text = self.contents;

}
-(void)removeshoosetableviewFromSuperviews
{
    if (self.Righttableview) {
        
        [self.Righttableview removeFromSuperview];
        self.Righttableview = nil;
        
        [self.shoosebackimage removeFromSuperview];
        self.shoosebackimage = nil;
        
        [self.shoosebtn removeFromSuperview];
        self.shoosebtn = nil;
        
        self.isfenlei = NO;
    }
    
    [self.resut removeAllObjects];//清空后重新加载
    [self.proSnosaryindex removeAllObjects];
    self.proSnos = @"";
    
    for (NSInteger i = self.selectorary.count - 1; i >= 0; i --) {
        NSString *str = [self.selectorary objectAtIndex:i];
        if ([str isEqualToString:@"n"]) {
            persens *per = [self.numberary objectAtIndex:i];
            [self.resut addObject:per.Name];
            [self.proSnosaryindex addObject:[NSString stringWithFormat:@"%ld",i]];
        }
    }
    
    for (NSString * snostr in self.proSnosaryindex) {
        persens *per = [self.numberary objectAtIndex:[snostr integerValue]];
        self.proSnos = [NSString stringWithFormat:@"%@,%@",self.proSnos,per.Sno];
    }
    
    
    [self creatproject];
   
}
-(void)creatproject
{
    
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
    
    self.a = self.resut.count;
    for (int i = 0; i < self.resut.count; i ++) {
        if (x + [self NSStringwithsize:17 str:[self.resut objectAtIndex:i]] + 5 >= self.view.bounds.size.width) {
            hangshu = hangshu + 1;
            x = 10;
        }
        NSInteger yh = (5 + btnhigth) * hangshu + jianxi + 390;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, yh,10 + [self NSStringwithsize:17 str:[self.resut objectAtIndex:i]], btnhigth)];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:[self.resut objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(titleforclicks:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10 + i;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 2;
        button.backgroundColor = [UIColor whiteColor];
        [scrollview addSubview:button];
        
        self.btnyhigth = yh + btnhigth;
        x = [self NSStringwithsize:17 str:[self.resut objectAtIndex:i]] + 10 + x + jianxi;
    }
    
    if (self.btnyhigth == 0){
        self.btnyhigth = 160;
    }

    if (self.btnyhigth  > (self.view.bounds.size.height - 120)) {
        scrollview.contentSize = CGSizeMake(0, self.view.bounds.size.height + (self.btnyhigth -(self.view.bounds.size.height - 60)));
        background.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + (self.btnyhigth -(self.view.bounds.size.height - 60)));
        commit.frame = CGRectMake(self.view.bounds.size.width/2 - 50, scrollview.contentSize.height - 50 , 100, 30);
    }
    
}
-(void)titleforclicks:(UIButton *)btn
{
    self.cancelbtnindex = btn.tag;
    NSString *str =[NSString stringWithFormat:@"你确定要删除“%@”项目吗？",[btn currentTitle]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 31;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 31) {
        if (buttonIndex == 0) {
            return;
        }else{
            UIButton *btn = (UIButton *)[scrollview viewWithTag:self.cancelbtnindex];
            NSString *string = [btn currentTitle];
            [btn removeFromSuperview];
            
            for (int i = 0; i < self.selectorary.count; i++) {
                persens *per = [self.numberary objectAtIndex:i];
                
                if ([per.Name isEqualToString:string]) {
                    [self.selectorary replaceObjectAtIndex:i withObject:@"y"];
                    for (NSString *strindex in self.proSnosaryindex) {
                        if ([strindex isEqualToString:[NSString stringWithFormat:@"%d",i]]) {
                            [self.proSnosaryindex removeObject:[NSString stringWithFormat:@"%d",i]];
                            break;//一定要有break，不然会崩。
                        }
                    }
                }}
            [self removeshoosetableviewFromSuperviews];
        }

    }else{
        [self xiangxizlbackbtn];
    }
    
    
}
-(void)reloadnewdata
{
    
    for (persens *per in self.orderproject) {
        
        for (int i = 0; i < self.numberary.count; i++) {
            persens *per1 = [self.numberary objectAtIndex:i];
            if ([per1.Sno isEqualToString:per.ProSno]) {
                
                [self.selectorary replaceObjectAtIndex:i withObject:@"n"];
                [self.proSnosaryindex addObject:[NSString stringWithFormat:@"%d",i]];
                [self.resut addObject:per.ProName];
            }
        }
    }
    
    self.proSnos = @"";
    
    for (NSString * snostr in self.proSnosaryindex) {
        persens *pers = [self.numberary objectAtIndex:[snostr integerValue]];
        self.proSnos = [NSString stringWithFormat:@"%@,%@",self.proSnos,pers.Sno];
    }
    
    [self creatproject];
    
}
//计算字体长度
-(float)NSStringwithsize:(int)a str:(NSString *)string
{
    
    UIFont *font = [UIFont systemFontOfSize:a];
    
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    // 名字的H
    //CGFloat nameH = size.height;
    // 名字的W
    CGFloat strwidth = size.width;
    
    return strwidth;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numberary.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        
        static NSString *identifier = @"cell1";
        detailsTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell1) {
            cell1 = [[detailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        persens *per = [self.numberary objectAtIndex:indexPath.row];
        
        cell1.contents.frame = CGRectMake(10, 10, cell1.bounds.size.width, 20);
        cell1.contents.text = per.Name;
        
        NSString *str = [self.selectorary objectAtIndex:indexPath.row];
        if ([str isEqualToString:@"n"]) {
            cell1.contents.textColor = [UIColor redColor];
        }else{
            cell1.contents.textColor = [UIColor blackColor];
        }
        

        
        return cell1;
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        NSString *str = [self.selectorary objectAtIndex:indexPath.row];
    
        if ([str isEqualToString:@"y"]) {
            [self.selectorary replaceObjectAtIndex:indexPath.row withObject:@"n"];
            [self.proSnosaryindex addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
            
        }else{
            [self.selectorary replaceObjectAtIndex:indexPath.row withObject:@"y"];
            
            NSLog(@"self.proSnosaryindex--> %@",self.proSnosaryindex);
            
            for (NSString *strindex in self.proSnosaryindex) {
                if ([strindex isEqualToString:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                    [self.proSnosaryindex removeObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
                    break;//一定要有break，不然会崩。
                }
            }
        }
    
        NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
        NSArray *indexArray=[NSArray arrayWithObject:indexPath_1];
        [self.Righttableview reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark -- soap请求
//医生详细资料界面数据
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno
{
    
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<GetDoctorDetailInfoData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "</GetDoctorDetailInfoData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno];
    
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/GetDoctorDetailInfoData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
//提交医生详细资料界面数据
-(void)soaprequstWithdoctorSno:(NSString *)doctorSno trueName:(NSString *)trueName postName:(NSString *)postName societyPostName:(NSString *)societyPostName qualification:(NSString *)qualification district:(NSString *)district contents:(NSString *)contents proSnos:(NSString *)proSnos sexType:(NSString *)sexType
{
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<SendDoctorDetailInfoData xmlns=\"Doc\">\n"
                             "<uid>%@</uid>\n"
                             "<pwd>%@</pwd>\n"
                             "<doctorSno>%@</doctorSno>\n"
                             "<trueName>%@</trueName>\n"
                             "<postName>%@</postName>\n"
                             "<societyPostName>%@</societyPostName>\n"
                             "<qualification>%@</qualification>\n"
                             "<district>%@</district>\n"
                             "<contents>%@</contents>\n"
                             "<proSnos>%@</proSnos>\n"
                             "<sexType>%@</sexType>\n"
                             "</SendDoctorDetailInfoData>\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n",UID,PSW,doctorSno,trueName,postName,societyPostName,qualification,district,contents,proSnos,sexType];
    //NSLog(@"soapMessage");
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:HTTPREQUESTER];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"Doc/SendDoctorDetailInfoData" forHTTPHeaderField:@"SOAPAction"];
    
    
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
    
    if ((long)[urlresponse statusCode] == 400) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"链接失败，请返回上一页再回来！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
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
    NSLog(@"提交预约的数据--%@",theXML);
    
    
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
    
    if ([elementName isEqualToString:@"GetDoctorDetailInfoDataResult"]) {
        
        [_soapResults setString:@""];//把它置空，准备接收新值。
    }
    
    if ([elementName isEqualToString:@"SendDoctorDetailInfoDataResult"]) {
        
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
    
    if ([elementName isEqualToString:@"GetDoctorDetailInfoDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
         NSLog(@"医生时间表详情：dic%@",dic);
        
//        NSString *state = [dic objectForKey:@"state"];
//        
//        NSString *msg = [dic objectForKey:@"msg"];
        
        NSMutableArray *allProData = [dic objectForKey:@"allProData"];
        for (NSDictionary *alldata in allProData) {
            persens *per = [persens persensWithdictionary:alldata];
            [self.numberary addObject:per];
        }
        
        self.selectorary = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < self.numberary.count; i++) {
            [self.selectorary addObject:@"y"];
        }
        
        NSMutableArray *basicData = [dic objectForKey:@"basicData"];
        NSDictionary *basicDatadic = [basicData objectAtIndex:0];
        self.contents = [basicDatadic objectForKey:@"Contents"];
        self.district = [basicDatadic objectForKey:@"District"];
        self.postName = [basicDatadic objectForKey:@"PostName"];
        self.qualification = [basicDatadic objectForKey:@"Qualification"];
        self.SexType = [basicDatadic objectForKey:@"SexType"];
        self.proSnos = [basicDatadic objectForKey:@"Sno"];
        self.societyPostName = [basicDatadic objectForKey:@"SocietyPostName"];
        self.trueName = [basicDatadic objectForKey:@"TrueName"];
        self.hospitalName = [dic objectForKey:@"hospitalName"];
        
         [self reloadviewdata];
        
        
        NSMutableArray *extraProData = [dic objectForKey:@"myProData"];
        self.orderproject = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *diction in extraProData) {
            persens *per = [persens persensWithdictionary:diction];
            [self.orderproject addObject:per];
        }
        [self reloadnewdata];
        
       
        
    }
    
    
    if ([elementName isEqualToString:@"SendDoctorDetailInfoDataResult"]) {
        
        NSData *jsonData = [_soapResults dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        NSLog(@"医生提交资料详情：dic%@",dic);
        
        NSString *state = [dic objectForKey:@"state"];
        
        if ([state isEqualToString:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.tag = 30;
            [alert show];
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
