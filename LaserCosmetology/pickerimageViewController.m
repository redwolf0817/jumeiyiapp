//
//  pickerimageViewController.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/13.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "pickerimageViewController.h"
#import "TopBarView.h"
@interface pickerimageViewController ()

@end

@implementation pickerimageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];

        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0,64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        image.image = [UIImage imageNamed:@"huisebeijing"];
        [self.view addSubview:image];
    
    TopBarView *topbar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    [self.view addSubview:topbar];
    
    UILabel *titilelable = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 120, 25)];
    titilelable.text = @"选取照片";
    titilelable.textColor = [UIColor whiteColor];
    titilelable.font = [UIFont systemFontOfSize:22];
    titilelable.center = CGPointMake(self.view.bounds.size.width/2, 40);
    titilelable.textAlignment = NSTextAlignmentCenter;
    [topbar addSubview:titilelable];
   
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 27, 40, 30)];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"gaoback"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backbuttonclicks) forControlEvents:UIControlEventTouchUpInside];
    [topbar addSubview:backbtn];
    
    
    UIButton *takenewimagebtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 74, (self.view.bounds.size.width - 30)/2, (self.view.bounds.size.width - 30)/2 - 20)];
    [takenewimagebtn setBackgroundImage:[UIImage imageNamed:@"选择上传_03"] forState:UIControlStateNormal];
    [takenewimagebtn addTarget:self action:@selector(takeNewPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takenewimagebtn];
    
    
    UIButton *shooseimage = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - (self.view.bounds.size.width - 30)/2 - 10, 74, (self.view.bounds.size.width - 30)/2, (self.view.bounds.size.width - 30)/2 - 20)];
    [shooseimage setBackgroundImage:[UIImage imageNamed:@"选择上传_05"] forState:UIControlStateNormal];
    [shooseimage addTarget:self action:@selector(shooseimage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shooseimage];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    if (self.a == 1) {
        [self backbuttonclicks];
    }
    
    self.a = 0;
    self.a++;
}
-(void)backbuttonclicks
{

    //NSLog(@"---self.imageview.image--%@",self.imageview.image);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendimage:(UIImage *)imagess{

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)takeNewPhoto:(UIButton *)sender{
    
    //创建图片选择器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //指定源类型前，检查图片源是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //指定源的类型
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
        imagePicker.allowsEditing = YES;
        
        //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
        imagePicker.delegate = self;
        
        
        //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
        [self presentModalViewController:imagePicker animated:YES];
       
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
    }
    
}
- (void)shooseimage:(UIButton *)sender{
    
    
    //创建图片选择器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //指定源类型前，检查图片源是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        //指定源的类型
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
        imagePicker.allowsEditing = YES;
        //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
        imagePicker.delegate = self;
        //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
        [self presentModalViewController:imagePicker animated:YES];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
    }
}

//- (IBAction)shooseimage2:(id)sender {
//    
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
////判断是否有摄像头
//    
//    
//    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
//    {
//        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;// 设置委托
//    imagePickerController.sourceType = sourceType;
//    imagePickerController.allowsEditing = YES;
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//    
//}

#pragma  mark -
#pragma  mark UIImagePickerControllerDelegate协议的方法

//用户点击图像选取器中的“cancel”按钮时被调用，这说明用户想要中止选取图像的操作
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

//用户点击选取器中的“choose”按钮时被调用，告知委托对象，选取操作已经完成，同时将返回选取图片的实例
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //noticeLabel.hidden = YES;
    [self.delegate1 sendimage:image];
   // [self.imageview setImage:image];
    [picker dismissModalViewControllerAnimated:YES];
    
}

////完成拍照
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    if (image == nil)
//        image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    [self performSelector:@selector(saveImage:) withObject:image];
//    
//}

//
////将照片保存到disk上
//-(void)saveImage:(UIImage *)image
//{
////    
////    NSData *imageData = UIImagePNGRepresentation(image);
////    if(imageData == nil)
////    {
////        imageData = UIImageJPEGRepresentation(image, 1.0);
////    }
////    
////    NSDate *date = [NSDate date];
////    
////    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
////    [formatter setDateFormat:@"yyyyMMddHHmmss"];
////    _fileName = [[[formatter stringFromDate:date] stringByAppendingPathExtension:@"png"] retain];
////    
////    
////    NSURL *saveURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:_fileName];
////    
////    [imageData writeToURL:saveURL atomically:YES];
//    
//    
//}

@end
