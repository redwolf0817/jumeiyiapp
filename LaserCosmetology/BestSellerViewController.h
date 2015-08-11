//
//  BestSellerViewController.h
//  PinkLife
//
//  Created by zy on 14-12-29.
//  Copyright (c) 2014年 段亚飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewWaterfallLayout.h"//


@interface BestSellerViewController : UIViewController<UICollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UICollectionViewDelegate>
{
    int                 _number;
    UICollectionView   *_collectionView;
}

@property (nonatomic,retain)NSMutableArray *array;
@property (nonatomic,retain)NSMutableArray *dataArray;

@end
