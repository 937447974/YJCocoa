//
//  YJUICollectionViewDataSourceManager.h
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUICollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUICollectionViewManager;

@interface YJUICollectionViewDataSourceManager : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong, nullable, readonly) UICollectionReusableView *collectionHeaderView; ///< 头部View
@property (nonatomic, strong, nullable, readonly) UICollectionReusableView *collectionFooterView; ///< 尾部View
@property (nonatomic, strong) NSMutableArray<YJUICollectionCellObject *> *headerDataSource; ///< UICollectionElementKindSectionHeader数据源
@property (nonatomic, strong) NSMutableArray<YJUICollectionCellObject *> *footerDataSource; ///< UICollectionElementKindSectionFooter数据源

@property (nonatomic, weak, readonly) YJUICollectionViewManager *manager; ///< YJUICollectionViewManager

/**
 *  初始化
 *
 *  @param manager YJUICollectionViewManager
 *
 *  @return YJUICollectionViewDataSourceManager
 */
- (instancetype)initWithManager:(YJUICollectionViewManager *)manager;

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
