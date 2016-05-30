//
//  YJCollectionViewDataSource.h
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCollectionCellObject.h"
#import "YJCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class YJCollectionViewDelegate;

/** 缓存Cell的策略*/
typedef NS_ENUM(NSInteger, YJCollectionViewCacheCell) {
    YJCollectionViewCacheCellDefault,          ///< 根据相同的UITableViewCell类名缓存Cell
    YJCollectionViewCacheCellIndexPath,        ///< 根据NSIndexPath对应的位置缓存Cell
    YJCollectionViewCacheCellClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存Cell
};

/** UICollectionViewDataSource抽象接口*/
@interface YJCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic) YJCollectionViewCacheCell cacheCellStrategy; ///< 缓存Cell的策略
@property (nonatomic, strong, readonly) NSMutableArray<YJCollectionCellObject *> *dataSource; ///< 数据源单一数组
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray<YJCollectionCellObject *> *> *dataSourceGrouped; ///< 数据源多数组

@property (nonatomic, weak, readonly) UICollectionView *collectionView;       ///< UICollectionView
@property (nonatomic, weak, readonly) UICollectionViewFlowLayout *flowLayout; ///< 布局Layout
@property (nonatomic, strong, readonly) YJCollectionViewDelegate *delegate;   ///< YJCollectionViewDelegate


/**
 *  抽象的初始化接口,会自动填充设置collectionView.dataSource = self;collectionView.delegate = self.tableViewDelegate;
 *
 *  @param collectionView UICollectionView
 *
 *  @return YJCollectionViewDataSource
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

/**
 *  根据cellObject创建UICollectionViewCell
 *
 *  @param cellObject YJCollectionCellObject
 *
 *  @return UICollectionViewCell
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithCellObject:(YJCollectionCellObject *)cellObject;

/**
 *  快速刷新已加载cell
 *
 *  @param cellObjects NSArray<YJCollectionCellObject *>
 *
 *  @return void
 */
- (void)reloadItemsAtCellObjects:(NSArray<YJCollectionCellObject *> *)cellObjects;

@end

NS_ASSUME_NONNULL_END
