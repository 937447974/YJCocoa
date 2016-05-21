//
//  YJCollectionViewCell.h
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

NS_ASSUME_NONNULL_BEGIN

@class YJCollectionViewDelegate;

/** UICollectionViewCell扩展*/
@interface UICollectionViewCell (YJCollectionView)

/**
 *  获取YJCollectionCellObject,子类重写可获取YJCollectionCellObject子类。
 *
 *  @return YJCollectionCellObject
 */
+ (id)cellObject;

/**
 *  获取YJCollectionCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJCollectionCellObject
 */
+ (id)cellObjectWithCellModel:(id<YJCollectionCellModel>)cellModel;

/**
 *  获取cell的显示Size。子类不实现时，会根据xib自动计算Size
 *
 *  @param delegate   YJCollectionViewDelegate
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGSize)collectionViewDelegate:(YJCollectionViewDelegate *)delegate sizeForCellObject:(YJCollectionCellObject *)cellObject;

/**
 *  刷新UITableViewCell（同步&异步）
 *
 *  @param cellObject YJCollectionCellObject
 *  @param delegate   YJCollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate;

/**
 *  刷新UITableViewCell（同步）
 *
 *  @param cellObject YJCollectionCellObject
 *  @param delegate   YJCollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataSyncWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate;

/**
 *  刷新UITableViewCell（异步）
 *
 *  @param cellObject YJCollectionCellObject
 *  @param delegate   YJCollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataAsyncWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate;

@end

/** UICollectionViewCell基类*/
@interface YJCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak, readonly) YJCollectionCellObject *cellObject; ///< YJCollectionCellObject
@property (nonatomic, weak, readonly) YJCollectionViewDelegate *delegate; ///< YJCollectionViewDelegate

@end

NS_ASSUME_NONNULL_END
