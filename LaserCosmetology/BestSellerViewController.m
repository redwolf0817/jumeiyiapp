//
//  BestSellerViewController.m
//  PinkLife
//
//  Created by zy on 14-12-29.
//  Copyright (c) 2014年 段亚飞. All rights reserved.
//

#import "BestSellerViewController.h"

//#import "RequestManage.h"
#import "MyCollectionViewCell.h"//
//#import "Item.h"
#import "UIImageView+WebCache.h"//
//#import "WebViewController.h"

#define KCellIdentifier @"identifier"
#define CELL_WIDTH 150.0f
// 设置列数的宏定义
#define CELL_COLCount  2;

@interface BestSellerViewController ()

@end

@implementation BestSellerViewController

//- (void)dealloc
//{
//    [_collectionView release];
//    [_array release];
//    [_dataArray release];
//    [super dealloc];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _number = 1;
    
    UICollectionViewWaterfallLayout *layout =[[UICollectionViewWaterfallLayout alloc] init];
    layout.delegate = self;
    layout.itemWidth = CELL_WIDTH;
    layout.columnCount = CELL_COLCount;
    
    // UICollectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:KCellIdentifier];
    [self.view addSubview:_collectionView];
    
//    // 请求
//    [RequestManage bestSellerRequestWith:[NSString stringWithFormat:@"%d",_number] withBlock:^(NSMutableArray *array)
//    {
//        self.array = array;
//        [_collectionView reloadData];
//    }];
    
    

}

- (void)footer
{
    NSLog(@"bbbb");
    
    __unsafe_unretained typeof(self) vc = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        _number ++;
      
//        [RequestManage bestSellerRequestWith:[NSString stringWithFormat:@"%d",_number] withBlock:^(NSMutableArray *array)
//         {
//             [self.dataArray removeAllObjects];
//             self.dataArray = array;
//             for (Item *item in self.dataArray)
//             {
//                 [self.array addObject:item];
//             }
//             [_collectionView reloadData];
//         }];
        
        
    });
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = KCellIdentifier;
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.imageView.backgroundColor = [UIColor grayColor];
//    Item *item = [self.array objectAtIndex:indexPath.row];
//    [cell.imageView setImageWithURL:[NSURL URLWithString:item.pic_url]];
//    cell.label.text = [NSString stringWithFormat:@"¥ %@",item.price];
    
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    Item *item = [self.array objectAtIndex:indexPath.row];
//    float width = [item.width floatValue];
//    float height = [item.height floatValue];
//    height = height*CELL_WIDTH/width;
//    return height;
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    Item *item = [self.array objectAtIndex:indexPath.row];
//    WebViewController *webView = [[[WebViewController alloc] init] autorelease];
//    webView.urlString = item.detail_url;
//    [self.navigationController pushViewController:webView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
