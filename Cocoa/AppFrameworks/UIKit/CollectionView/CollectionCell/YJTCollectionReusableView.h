//
//  YJTCollectionReusableView.h
//  YJTCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTCollectionCellObject.h"
#import "YJTCollectionViewDelegate.h"
#import "YJTCollectionViewDataSource.h"
#import "YJSFoundationOther.h"
#import "YJCSystem.h"

@class YJTCollectionViewDelegate;

/** UICollectionReusableView扩展*/
@interface UICollectionReusableView (YJTCollectionView)

/**
 *  获取初始化cell的方式
 *
 *  @return YJTCollectionCellCreate
 */
+ (YJTCollectionCellCreate)cellCreate;

/**
 *  获取YJTCollectionCellObject
 *
 *  @return YJTCollectionCellObject
 */
+ (id)cellObject;

/**
 *  获取YJTCollectionCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJTCollectionCellObject
 */
+ (id)cellObjectWithCellModel:(id<YJTCollectionCellModel>)cellModel;

/**
 *  获取cell的显示Size。子类不实现时，会根据xib自动计算Size
 *
 *  @param delegate   YJTCollectionViewDelegate
 *  @param kind       UICollectionElementKindSectionHeader | UICollectionElementKindSectionFooter
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGSize)collectionViewDelegate:(YJTCollectionViewDelegate *)delegate viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJTCollectionCellObject *)cellObject;

/**
 *  刷新UICollectionReusableView（同步&异步，子类请勿重写）
 *
 *  @param cellObject YJTCollectionCellObject
 *  @param delegate   YJTCollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataWithCellObject:(YJTCollectionCellObject *)cellObject delegate:(YJTCollectionViewDelegate *)delegate;

/**
 *  刷新UICollectionReusableView（同步）
 *
 *  @param cellObject YJTCollectionCellObject
 *  @param delegate   YJTCollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataSyncWithCellObject:(YJTCollectionCellObject *)cellObject delegate:(YJTCollectionViewDelegate *)delegate;

/**
 *  刷新UICollectionReusableView（异步）
 *
 *  @param cellObject YJTCollectionCellObject
 *  @param delegate   YJTCollectionViewDelegate
 *
 *  @return void
 */
- (void)reloadDataAsyncWithCellObject:(YJTCollectionCellObject *)cellObject delegate:(YJTCollectionViewDelegate *)delegate;

@end

/** 头部|尾部*/
@interface YJTCollectionReusableView : UICollectionReusableView

@property (nonatomic, weak, readonly) YJTCollectionCellObject *cellObject; ///< YJTCollectionCellObject
@property (nonatomic, weak, readonly) YJTCollectionViewDelegate *delegate; ///< YJTCollectionViewDelegate

@end
