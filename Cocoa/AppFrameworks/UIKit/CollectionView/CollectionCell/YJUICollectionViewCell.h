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

#import <UIKit/UIKit.h>
#import "YJUICollectionReusableView.h"

NS_ASSUME_NONNULL_BEGIN

/** UICollectionViewCell扩展*/
@interface UICollectionViewCell (YJUICollectionView)

/**
 *  获取cell的显示Size。子类不实现时，会根据xib自动计算Size
 *
 *  @param delegate   YJUICollectionViewDelegate
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGSize)collectionViewDelegate:(YJUICollectionViewDelegate *)delegate sizeForCellObject:(YJUICollectionCellObject *)cellObject;

@end

/** UICollectionViewCell基类*/
@interface YJUICollectionViewCell : UICollectionViewCell

@property (nonatomic, weak, readonly) YJUICollectionCellObject *cellObject; ///< YJUICollectionCellObject
@property (nonatomic, weak, readonly) YJUICollectionViewDelegate *delegate; ///< YJUICollectionViewDelegate

@end

NS_ASSUME_NONNULL_END
