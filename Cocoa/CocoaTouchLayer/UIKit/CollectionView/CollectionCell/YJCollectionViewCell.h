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
#import "YJCollectionReusableView.h"

NS_ASSUME_NONNULL_BEGIN

/** UICollectionViewCell扩展*/
@interface UICollectionViewCell (YJCollectionView)

/**
 *  获取cell的显示Size。子类不实现时，会根据xib自动计算Size
 *
 *  @param delegate   YJCollectionViewDelegate
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGSize)collectionViewDelegate:(YJCollectionViewDelegate *)delegate sizeForCellObject:(YJCollectionCellObject *)cellObject;

@end

/** UICollectionViewCell基类*/
@interface YJCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak, readonly) YJCollectionCellObject *cellObject; ///< YJCollectionCellObject
@property (nonatomic, weak, readonly) YJCollectionViewDelegate *delegate; ///< YJCollectionViewDelegate

@end

NS_ASSUME_NONNULL_END
