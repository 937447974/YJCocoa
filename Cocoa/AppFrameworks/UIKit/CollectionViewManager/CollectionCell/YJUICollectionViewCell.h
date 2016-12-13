//
//  YJUICollectionViewCell.h
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionReusableView.h"

NS_ASSUME_NONNULL_BEGIN

/** UICollectionViewCell扩展*/
@interface UICollectionViewCell (YJUICollectionView)

@property (nonatomic, class, readonly) BOOL customCacheCell; ///< 是否使用自定义缓存Cell

/**
 *  获取cell的显示Size。子类不实现时，会根据xib自动计算Size
 *
 *  @param delegate   YJUICollectionViewDelegate
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGSize)collectionViewManager:(YJUICollectionViewManager *)collectionViewManager sizeForCellObject:(YJUICollectionCellObject *)cellObject;

/**
 *  刷新UICollectionReusableView（从自定义缓存获取Cell）
 *
 *  @param cellObject            YJUICollectionCellObject
 *  @param collectionViewManager YJUICollectionViewManager
 *
 *  @return void
 */
- (void)reloadDataCacheWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager;

@end

/** UICollectionViewCell基类*/
@interface YJUICollectionViewCell : UICollectionViewCell

@property (nonatomic, weak, readonly) YJUICollectionCellObject *cellObject;             ///< YJUICollectionCellObject
@property (nonatomic, weak, readonly) YJUICollectionViewManager *collectionViewManager; ///< YJUICollectionViewManager

@end

NS_ASSUME_NONNULL_END
