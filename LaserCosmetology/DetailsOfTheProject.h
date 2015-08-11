//
//  DetailsOfTheProject.h
//  LaserCosmetology
//
//  Created by fenghuang on 15/5/12.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsOfTheProject : UIViewController<NSXMLParserDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableData *webData;
    NSMutableString *_soapResults;
    NSXMLParser *xmlParser;
    
    NSMutableArray *_itemsary;
    NSMutableArray *_productTypeDataarray;
    NSMutableArray *_itemsarray;//保存项目类别小数组的大数组
    
    UIView *_viewbtn;
    
    UILabel *_titilelable;
    
    
}

@property(nonatomic,retain)NSString *strstr;
@property(nonatomic,retain)NSString *beautyEnumNo;

@property(nonatomic,retain)UITableView *fenleitableview;
@property(nonatomic,retain)UITableView *Righttableview;
@property(nonatomic,retain)UIImageView *imahe;
@property(nonatomic,assign)BOOL  isfenlei;
@property(nonatomic,assign)NSInteger SelectRowAtIndexPath;
@property(nonatomic,retain)NSString *itemesID;

@property(nonatomic,retain)UICollectionView *collectionView;
@property(nonatomic,retain)NSString *titlename;

@end
