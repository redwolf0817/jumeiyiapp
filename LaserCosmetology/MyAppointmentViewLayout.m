//
//  MyAppointmentViewLayout.m
//  LaserCosmetology
//
//  Created by fenghuang on 15/4/30.
//  Copyright (c) 2015年 huqijing. All rights reserved.
//

#import "MyAppointmentViewLayout.h"

/**
 * 默认的 “列数”
 */
static NSUInteger const JKDefaultColumns   = 1;
/**
 * 默认 "行" 间距
 */
static CGFloat const JKDefaultRowMargin    = 5;
/**
 * 默认 "列" 间距
 */
static CGFloat const JKDefaultColumnMargin = 5.0;
/**
 * 默认 "边" 间距
 */
static UIEdgeInsets const JKDefaultInsets  = {5,5,5,5};

@interface MyAppointmentViewLayout()

/**
 * 定义数组记录所有列最大的Y值，以便以后比较找出最短的列
 */
@property (nonatomic,strong)NSMutableArray *maxColmnYs;

@property (nonatomic,strong)NSMutableArray *attrsArray;

@end

@implementation MyAppointmentViewLayout
- (NSMutableArray *)maxColmnYs
{
    if (!_maxColmnYs) {
        _maxColmnYs = [NSMutableArray array];
        //初始化所有列的默认值
        for (int i = 0; i<JKDefaultColumns; i++) {
            _maxColmnYs[i] = @(JKDefaultInsets.top);
        }
    }
    return _maxColmnYs;
}
//一般情况下调用UICollectionView的reloadData刷新布局时调用
- (void)prepareLayout
{
    [super prepareLayout];
    // 每次计算之前重置保存每一列最大Y值得数据
    [self.maxColmnYs removeAllObjects];
    for ( int i=0; i < JKDefaultColumns; i++) {
        _maxColmnYs[i] = @(JKDefaultInsets.top);
    }
    // 1.获取当前UICollectionView中有多少个子控件
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    NSMutableArray *arrM = [NSMutableArray array];
    // 2.利用循环创建所有子控件对象的属性对象
    for (int i = 0; i < count; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:path];
        // 3.利将属性对象添加到数组中
        [arrM addObject:attr];
    }
    self.attrsArray = arrM;
    
}

// 该方法用于返回collectionView上所有子控件的排布,返回的数组中存放这个所有子控件对象的UICollectionViewLayoutAttributes对象
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

// 用于返回指定位子的子控件的布局属性对象,一个UICollectionViewLayoutAttributes对象就对应一个子控件的排布
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //1.创建对应位置的布局属性对象
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 计算frame
    // 总共间隙 = 左边间隙 + 中间间隙 + 右边间隙
    CGFloat totalMarginH = JKDefaultInsets.left + JKDefaultInsets.right +(JKDefaultColumns -1)*JKDefaultColumnMargin;
    // 宽度 = UICollectionView的宽度 - 左边间隙 - 右边间隙 - 中间的间隙
    CGFloat width = (self.collectionView.frame.size.width - totalMarginH)/JKDefaultColumns;
    // 高度
    //CGFloat height= 50+ arc4random_uniform(200);
    
    CGFloat height= 165;
    //[[self.layouhighary objectAtIndex:indexPath.row] floatValue] + 120;//每个单元格文字内容的整个高度,160+20图片和姓名高度和
    
    // 找到最短列的列号和最短列的最大Y值
    CGFloat destY = [self.maxColmnYs[0]doubleValue];
    NSUInteger destIndex = 0;
    for (int i = 1; i < JKDefaultColumns; i++) {
        // 取出没的最大Y值
        CGFloat tempY = [self.maxColmnYs[i] doubleValue];
        if (destY >tempY) {
            destY = tempY;
            destIndex = i;
        }
    }
    // X = 左边边距 + （item的宽度 + 间隙）*列号
    CGFloat x = JKDefaultInsets.left +(width +JKDefaultColumnMargin)*destIndex;
    // Y = 最短列最大Y + 间隙
    CGFloat y = destY + JKDefaultRowMargin;
    
    //2.设置子控件的位置
    attr.frame = CGRectMake(x, y, width, height);
    
    //更新当前列的最小Y值
    self.maxColmnYs[destIndex] = @(CGRectGetMaxY(attr.frame));
    
    return attr;
}

- (CGSize)collectionViewContentSize
{
    // 取出最大列的Y值作为滚动的高度+底部间隙
    CGFloat destY = [self.maxColmnYs[0]doubleValue];
    for (int i = 1; i < JKDefaultColumns; i++) {
        CGFloat tempY = [self.maxColmnYs[i] doubleValue];
        if (destY <tempY) {
            destY = tempY;
        }
    }
    return CGSizeMake(0, destY+JKDefaultInsets.bottom);
}

@end
