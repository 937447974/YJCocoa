//
//  YJUICollectionViewDelegateFlowLayoutManager.h
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionViewDelegateManager.h"

/** 缓存Size的策略*/
typedef NS_ENUM(NSInteger, YJUICollectionViewCacheSize) {
    YJUICollectionViewCacheSizeDefault,          ///< 根据相同的UITableViewCell类缓存高度
    YJUICollectionViewCacheSizeIndexPath,        ///< 根据NSIndexPath对应的位置缓存高度
    YJUICollectionViewCacheSizeClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存高度
};

@interface YJUICollectionViewDelegateFlowLayoutManager : YJUICollectionViewDelegateManager <UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak, readonly) UICollectionViewFlowLayout *flowLayout; ///< 布局Layout

@property (nonatomic) BOOL isCacheSize;      ///< 是否缓存size，默认YES缓存，NO不缓存
@property (nonatomic) CGFloat lineItems;     ///< 一行显示多少个item
@property (nonatomic) BOOL itemHeightLayout; ///< item的高度是否根据宽度自适应（lineItems>0）
@property (nonatomic) YJUICollectionViewCacheSize cacheSizeStrategy; ///< 缓存size的策略。无须赋值，YJUICollectionViewDataSource抽象接口会根据cacheCellStrategy自动赋值

/**
 *  清除所有缓存Size
 */
- (void)clearAllCacheSize;

@end
