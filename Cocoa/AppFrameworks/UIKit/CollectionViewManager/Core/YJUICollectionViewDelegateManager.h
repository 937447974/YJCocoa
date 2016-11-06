//
//  YJUICollectionViewDelegateManager.h
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUICollectionViewCell.h"

@class YJUICollectionViewManager;

/** UICollectionView滚动*/
typedef NS_OPTIONS(NSUInteger, YJUICollectionViewScroll) {
    // 上方出现
    YJUICollectionViewScrollEndTop,     ///< 滚动到顶部
    YJUICollectionViewScrollDidTop,     ///< 向上滚动
    YJUICollectionViewScrollWillTop,    ///< 将要向上滚动
    // 用户触摸
    YJUICollectionViewScrollNone,       ///< 用户触摸，将要滚动
    // 下方出现
    YJUICollectionViewScrollWillBottom, ///< 将要向下滚动
    YJUICollectionViewScrollDidBottom,  ///< 向下滚动
    YJUICollectionViewScrollEndBottom   ///< 滚动到底部
};

/** UICollectionViewDelegate管理器*/
@interface YJUICollectionViewDelegateManager : NSObject <UICollectionViewDelegate>

@property (nonatomic) CGFloat scrollSpacingWill; ///< 将要滚动间隔，默认15
@property (nonatomic) CGFloat scrollSpacingDid;  ///< 已经滚动间隔，默认30

@property (nonatomic, weak, readonly) YJUICollectionViewManager *manager; ///< YJUICollectionViewManager

/**
 *  初始化
 *
 *  @param manager YJUICollectionViewManager
 *
 *  @return YJUICollectionViewDelegateManager
 */
- (instancetype)initWithManager:(YJUICollectionViewManager *)manager;

@end
