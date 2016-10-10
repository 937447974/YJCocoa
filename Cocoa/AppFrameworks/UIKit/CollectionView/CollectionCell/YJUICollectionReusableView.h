//
//  YJUICollectionReusableView.h
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUICollectionCellObject.h"
#import "YJUICollectionViewDelegate.h"
#import "YJUICollectionViewDataSource.h"
#import "YJNSFoundationOther.h"
#import "YJCSystem.h"

@class YJUICollectionViewDelegate;

/** UICollectionReusableView扩展*/
@interface UICollectionReusableView (YJUICollectionView)

/**
 *  获取初始化cell的方式
 *
 *  @return YJUICollectionCellCreate
 */
+ (YJUICollectionCellCreate)cellCreate;

/**
 *  获取YJUICollectionCellObject
 *
 *  @return YJUICollectionCellObject
 */
+ (id)cellObject;

/**
 *  获取YJUICollectionCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJUICollectionCellObject
 */
+ (id)cellObjectWithCellModel:(id<YJUICollectionCellModel>)cellModel;

/**
 *  获取cell的显示Size。子类不实现时，会根据xib自动计算Size
 *
 *  @param delegate   YJUICollectionViewDelegate
 *  @param kind       UICollectionElementKindSectionHeader | UICollectionElementKindSectionFooter
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGSize)collectionViewDelegate:(YJUICollectionViewDelegate *)delegate viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJUICollectionCellObject *)cellObject;

/**
 *  刷新UICollectionReusableView（同步&异步，子类请勿重写）
 *
 *  @param cellObject YJUICollectionCellObject
 *  @param delegate   YJUICollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataWithCellObject:(YJUICollectionCellObject *)cellObject delegate:(YJUICollectionViewDelegate *)delegate;

/**
 *  刷新UICollectionReusableView（同步）
 *
 *  @param cellObject YJUICollectionCellObject
 *  @param delegate   YJUICollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataSyncWithCellObject:(YJUICollectionCellObject *)cellObject delegate:(YJUICollectionViewDelegate *)delegate;

/**
 *  刷新UICollectionReusableView（异步）
 *
 *  @param cellObject YJUICollectionCellObject
 *  @param delegate   YJUICollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataAsyncWithCellObject:(YJUICollectionCellObject *)cellObject delegate:(YJUICollectionViewDelegate *)delegate;

@end

/** 头部|尾部*/
@interface YJUICollectionReusableView : UICollectionReusableView

@property (nonatomic, weak, readonly) YJUICollectionCellObject *cellObject; ///< YJUICollectionCellObject
@property (nonatomic, weak, readonly) YJUICollectionViewDelegate *delegate; ///< YJUICollectionViewDelegate

@end
