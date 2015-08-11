//
//  BeautyExpert.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/2/13.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "BeautyExpert.h"

@implementation BeautyExpert

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView *backgroudimage = [[UIImageView alloc] initWithFrame:self.bounds];
        backgroudimage.image = [UIImage imageNamed:@"meirongzhuanjia_0304"];
        backgroudimage.userInteractionEnabled = YES;
        [self addSubview:backgroudimage];
        
                UIImageView *heard = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 110)];
                heard.image = [UIImage imageNamed:@"touxiang"];
                heard.layer.cornerRadius = 55;
                heard.layer.masksToBounds = YES;
                [backgroudimage addSubview:heard];
        
        UILabel *namelable = [[UILabel alloc] initWithFrame:CGRectMake(125, 10, 80, 20)];
        namelable.text = @"刘晓庆";
        [backgroudimage addSubview:namelable];
        
        UILabel *fuwu = [[UILabel alloc] initWithFrame:CGRectMake(205, 10, 60, 20)];
        fuwu.text = @"服务:";
        [backgroudimage addSubview:fuwu];
        
        float width =[self NSStringwithsize:17 str:fuwu.text];
        
        UILabel *fuwunumber = [[UILabel alloc] initWithFrame:CGRectMake(205 + width, 10, 60, 20)];
        fuwunumber.text = @"100";
        fuwunumber.textColor = [UIColor redColor];
        fuwunumber.font = [UIFont systemFontOfSize:15];
        [backgroudimage addSubview:fuwunumber];
        
        float width1 =[self NSStringwithsize:15 str:fuwunumber.text];
        
        UILabel *peoplenumber = [[UILabel alloc] initWithFrame:CGRectMake(205 + width + width1, 10, 60, 20)];
        peoplenumber.text = @"人";
        peoplenumber.textColor = [UIColor blackColor];
        peoplenumber.font = [UIFont systemFontOfSize:15];
        [backgroudimage addSubview:peoplenumber];
        
        
        UILabel *begoodat = [[UILabel alloc] initWithFrame:CGRectMake(125, 35, 60, 20)];
        begoodat.text = @"擅长:";
        [backgroudimage addSubview:begoodat];
        
        float width2 =[self NSStringwithsize:17 str:begoodat.text];
        float textlong =[self NSStringwithsize:15 str:@"脸部整形，美容"];
        
        UILabel *begoodto = [[UILabel alloc] initWithFrame:CGRectMake(125 + width2 + 3, 35, textlong, 20)];
        begoodto.text = @"脸部整形，美容";
        begoodto.textColor = [UIColor blackColor];
        begoodto.font = [UIFont systemFontOfSize:15];
        [backgroudimage addSubview:begoodto];
        
        UILabel *cost = [[UILabel alloc] initWithFrame:CGRectMake(125, 60, 60, 20)];
        cost.text = @"费用:";
        [backgroudimage addSubview:cost];
        
        float width3 =[self NSStringwithsize:17 str:cost.text];
        
        UILabel *costnumber = [[UILabel alloc] initWithFrame:CGRectMake(125 + width3 + 3, 60, 120, 20)];
        costnumber.text = @"6000~7000";
        costnumber.textColor = [UIColor redColor];
        costnumber.font = [UIFont systemFontOfSize:15];
        [backgroudimage addSubview:costnumber];
        
        float width4 =[self NSStringwithsize:15 str:costnumber.text];
        
        UILabel *yuan = [[UILabel alloc] initWithFrame:CGRectMake(125 + width3 + 3 + width4, 60, 60, 20)];
        yuan.text = @"元";
        yuan.font = [UIFont systemFontOfSize:15];
        [backgroudimage addSubview:yuan];
        
        UILabel *judge = [[UILabel alloc] initWithFrame:CGRectMake(125, 85, 60, 20)];
        judge.text = @"评价:";
        [backgroudimage addSubview:judge];
        
        float width5 =[self NSStringwithsize:15 str:judge.text];
        
        for (int i = 0; i < 5; i ++) {
            UIImageView *imagejudge = [[UIImageView alloc] initWithFrame:CGRectMake(125 +width5 + 10 +(i * 22), 85, 18, 18)];
            imagejudge.image = [UIImage imageNamed:@"meirongzhuanjia_0302"];
            [backgroudimage addSubview:imagejudge];
        }
        
        UILabel *hospital = [[UILabel alloc] initWithFrame:CGRectMake(125, 110, 120, 20)];
        hospital.text = @"医院名称:";
        [backgroudimage addSubview:hospital];
        
        float width6 =[self NSStringwithsize:15 str:costnumber.text];
        
        UILabel *hospitalname = [[UILabel alloc] initWithFrame:CGRectMake(125 + width6 + 3, 110, 150, 20)];
        hospitalname.text = @"武汉爱美美容医院";
        hospitalname.textColor = [UIColor blackColor];
        hospitalname.font = [UIFont systemFontOfSize:15];
        [backgroudimage addSubview:hospitalname];
        
        
    }
    return self;
}
-(void)choosebuttonclick:(mybutton *)btn{
   
    mybutton *button = (mybutton *)[self viewWithTag:10];
    if (btn.isclick == YES) {
        [button setBackgroundImage:[UIImage imageNamed:@"duigouh"] forState:UIControlStateNormal];
        btn.isclick = NO;
    }else{
    [button setBackgroundImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateNormal];
    
        btn.isclick = YES;
    }

}

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
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
