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

NS_ASSUME_NONNULL_BEGIN

@class YJUICollectionViewManager;

/** cell的协议*/
@protocol YJUICollectionViewCellProtocol <NSObject>

@optional

/**
 *  用户点击Cell中的某个控件，如按钮
 *
 *  @param UICollectionViewCell 用户操作的cell
 *  @param cellObject           cell携带的数据源
 *
 *  @return void
 */
- (void)collectionCell:(__kindof UICollectionViewCell *)cell sendWithCellObject:(YJUICollectionCellObject *)cellObject;

@end

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
 *  @param collectionViewManager YJUICollectionViewManager
 *  @param kind                  UICollectionElementKindSectionHeader | UICollectionElementKindSectionFooter
 *  @param cellObject            cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGSize)collectionViewManager:(YJUICollectionViewManager *)collectionViewManager viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJUICollectionCellObject *)cellObject;

/**
 *  刷新UICollectionReusableView（同步&异步，子类请勿重写）
 *
 *  @param cellObject            YJUICollectionCellObject
 *  @param collectionViewManager YJUICollectionViewManager
 *
 *  @return void
 */
- (void)reloadDataWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager;

/**
 *  刷新UICollectionReusableView（同步）
 *
 *  @param cellObject            YJUICollectionCellObject
 *  @param collectionViewManager YJUICollectionViewManager
 *
 *  @return void
 */
- (void)reloadDataSyncWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager;

/**
 *  刷新UICollectionReusableView（异步）
 *
 *  @param cellObject            YJUICollectionCellObject
 *  @param collectionViewManager YJUICollectionViewManager
 *
 *  @return void
 */
- (void)reloadDataAsyncWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager;

@end

/** 头部|尾部*/
@interface YJUICollectionReusableView : UICollectionReusableView

@property (nonatomic, weak, readonly) YJUICollectionCellObject *cellObject;             ///< YJUICollectionCellObject
@property (nonatomic, weak, readonly) YJUICollectionViewManager *collectionViewManager; ///< YJUICollectionViewManager

@end

NS_ASSUME_NONNULL_END
