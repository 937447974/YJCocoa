//
//  YJUICollectionReusableView.h
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUICollectionCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUICollectionViewManager;

/** cell的协议*/
@protocol YJUICollectionViewCellProtocol <NSObject>

@optional

/**
 *  @abstract 用户点击Cell中的某个控件，如按钮
 *
 *  @param cell       用户操作的cell
 *  @param cellObject cell携带的数据源
 */
- (void)collectionCell:(__kindof UICollectionReusableView *)cell sendWithCellObject:(YJUICollectionCellObject *)cellObject;

@end

/** UICollectionReusableView扩展*/
@interface UICollectionReusableView (YJUICollectionView)

@property (nonatomic, class, readonly) YJUICollectionCellCreate cellCreate; ///< 获取初始化cell的方式

@property (nonatomic, class, readonly, weak) __kindof YJUICollectionCellObject *cellObject; ///< 获取YJUICollectionCellObject

/**
 *  @abstract 获取YJUICollectionCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJUICollectionCellObject
 */
+ (__kindof YJUICollectionCellObject *)cellObjectWithCellModel:(id<YJUICollectionCellModel>)cellModel;

/**
 *  @abstract 获取cell的显示Size。子类不实现时，会根据xib自动计算Size
 *
 *  @param collectionViewManager YJUICollectionViewManager
 *  @param kind                  UICollectionElementKindSectionHeader | UICollectionElementKindSectionFooter
 *  @param cellObject            cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGSize)collectionViewManager:(YJUICollectionViewManager *)collectionViewManager viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJUICollectionCellObject *)cellObject;

/**
 *  @abstract 刷新UICollectionReusableView
 *
 *  @param cellObject            YJUICollectionCellObject
 *  @param collectionViewManager YJUICollectionViewManager
 */
- (void)reloadDataWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager;

@end

/** 头部|尾部*/
@interface YJUICollectionReusableView : UICollectionReusableView

@property (nonatomic, weak, readonly) YJUICollectionCellObject *cellObject;             ///< YJUICollectionCellObject
@property (nonatomic, weak, readonly) YJUICollectionViewManager *collectionViewManager; ///< YJUICollectionViewManager

@end

NS_ASSUME_NONNULL_END
