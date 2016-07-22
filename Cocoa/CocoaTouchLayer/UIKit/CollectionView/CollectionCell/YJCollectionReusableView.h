//
//  YJCollectionReusableView.h
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCollectionCellObject.h"
#import "YJCollectionViewDelegate.h"
#import "YJCollectionViewDataSource.h"
#import "YJFoundationOther.h"
#import "YJSystem.h"

@class YJCollectionViewDelegate;

/** UICollectionReusableView扩展*/
@interface UICollectionReusableView (YJCollectionView)

/**
 *  获取初始化cell的方式
 *
 *  @return YJCollectionCellCreate
 */
+ (YJCollectionCellCreate)cellCreate;

/**
 *  获取YJCollectionCellObject
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
 *  @param kind       UICollectionElementKindSectionHeader | UICollectionElementKindSectionFooter
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGSize)collectionViewDelegate:(YJCollectionViewDelegate *)delegate viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJCollectionCellObject *)cellObject;

/**
 *  刷新UICollectionReusableView（同步&异步，子类请勿重写）
 *
 *  @param cellObject YJCollectionCellObject
 *  @param delegate   YJCollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate;

/**
 *  刷新UICollectionReusableView（同步）
 *
 *  @param cellObject YJCollectionCellObject
 *  @param delegate   YJCollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataSyncWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate;

/**
 *  刷新UICollectionReusableView（异步）
 *
 *  @param cellObject YJCollectionCellObject
 *  @param delegate   YJCollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataAsyncWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate;

@end

/** 头部|尾部*/
@interface YJCollectionReusableView : UICollectionReusableView

@property (nonatomic, weak, readonly) YJCollectionCellObject *cellObject; ///< YJCollectionCellObject
@property (nonatomic, weak, readonly) YJCollectionViewDelegate *delegate; ///< YJCollectionViewDelegate

@end
