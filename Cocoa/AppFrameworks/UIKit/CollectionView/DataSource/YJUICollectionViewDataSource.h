//
//  YJUICollectionViewDataSource.h
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUICollectionCellObject.h"
#import "YJUICollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUICollectionViewDelegate;

/** 缓存Cell的策略*/
typedef NS_ENUM(NSInteger, YJUICollectionViewCacheCell) {
    YJUICollectionViewCacheCellDefault,          ///< 根据相同的UITableViewCell类名缓存Cell
    YJUICollectionViewCacheCellIndexPath,        ///< 根据NSIndexPath对应的位置缓存Cell
    YJUICollectionViewCacheCellClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存Cell
};

/** UICollectionViewDataSource抽象接口*/
@interface YJUICollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic) YJUICollectionViewCacheCell cacheCellStrategy; ///< 缓存Cell的策略
@property (nonatomic, strong) NSMutableArray<YJUICollectionCellObject *> *dataSource; ///< 数据源单一数组
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray<YJUICollectionCellObject *> *> *dataSourceGrouped; ///< 数据源多数组

@property (nonatomic, weak, readonly) UICollectionView *collectionView;       ///< UICollectionView
@property (nonatomic, weak, readonly) UICollectionViewFlowLayout *flowLayout; ///< 布局Layout
@property (nonatomic, strong, readonly) YJUICollectionViewDelegate *delegate;  ///< YJUICollectionViewDelegate

@property (nonatomic, strong, nullable, readonly) UICollectionReusableView *collectionHeaderView; ///< 头部View
@property (nonatomic, strong, nullable, readonly) UICollectionReusableView *collectionFooterView; ///< 尾部View
@property (nonatomic, strong) NSMutableArray<YJUICollectionCellObject *> *headerDataSource; ///< UICollectionElementKindSectionHeader数据源
@property (nonatomic, strong) NSMutableArray<YJUICollectionCellObject *> *footerDataSource; ///< UICollectionElementKindSectionFooter数据源

/**
 *  抽象的初始化接口,会自动填充设置collectionView.dataSource = self;collectionView.delegate = self.tableViewDelegate;
 *
 *  @param collectionView UICollectionView
 *
 *  @return YJUICollectionViewDataSource
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

/**
 *  根据cellObject创建UICollectionViewCell
 *
 *  @param cellObject YJUICollectionCellObject
 *
 *  @return UICollectionViewCell
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithCellObject:(YJUICollectionCellObject *)cellObject;

/**
 *  快速刷新已加载cell
 *
 *  @param cellObjects NSArray<YJUICollectionCellObject *>
 *
 *  @return void
 */
- (void)reloadItemsAtCellObjects:(NSArray<YJUICollectionCellObject *> *)cellObjects;

@end

NS_ASSUME_NONNULL_END
