//
//  pickerimageViewController.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/3/13.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendvaluedelegate <NSObject>

@required
-(void)sendimage:(UIImage *)imagess;

@end

@interface pickerimageViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,sendvaluedelegate>
- (void)takeNewPhoto:(UIButton *)sender;
- (void)shooseimage:(UIButton *)sender;

@property(nonatomic,assign)id<sendvaluedelegate>delegate1;

//@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property(nonatomic,assign)NSInteger a;

@end
