//
//  YJUITableViewDelegateManager.h
//  YJTableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUITableViewCell.h"
#import "YJUISuspensionCellView.h"
#import "YJUITableCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUITableViewManager;

/** 缓存高的策略*/
typedef NS_ENUM(NSInteger, YJUITableViewCacheHeight) {
    YJUITableViewCacheHeightDefault,          ///< 根据相同的UITableViewCell类缓存高度
    YJUITableViewCacheHeightIndexPath,        ///< 根据NSIndexPath对应的位置缓存高度
    YJUITableViewCacheHeightClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存高度
};

/** UITableView滚动*/
typedef NS_OPTIONS(NSUInteger, YJUITableViewScroll) {
    YJUITableViewScrollEndTop,     ///< 滚动到顶部
    YJUITableViewScrollDidTop,     ///< 向上滚动
    YJUITableViewScrollWillTop,    ///< 将要向上滚动
    YJUITableViewScrollNone,       ///< 用户触摸，将要滚动
    YJUITableViewScrollWillBottom, ///< 将要向下滚动
    YJUITableViewScrollDidBottom,  ///< 向下滚动
    YJUITableViewScrollEndBottom   ///< 滚动到底部
};

/** UITableViewDelegate管理器*/
@interface YJUITableViewDelegateManager : NSObject<UITableViewDelegate>

@property (nonatomic, weak, readonly) YJUITableViewManager *manager; ///< YJUITableViewManager

@property (nonatomic) CGFloat scrollSpacingWill; ///< 将要滚动间隔，默认15
@property (nonatomic) CGFloat scrollSpacingDid;  ///< 已经滚动间隔，默认30

@property (nonatomic) BOOL isCacheHeight;                           ///< 是否缓存高，默认YES缓存，NO不缓存
@property (nonatomic) YJUITableViewCacheHeight cacheHeightStrategy; ///< 缓存高的策略

@property (nonatomic, strong) YJUISuspensionCellView *suspensionCellView; ///< 悬浮的cell层

/**
 *  初始化
 *
 *  @param manager YJUITableViewManager
 *
 *  @return YJUITableViewDelegateManager
 */
- (instancetype)initWithManager:(YJUITableViewManager *)manager;

/**
 *  清除所有缓存高
 *
 *  @return void
 */
- (void)clearAllCacheHeight;

/**
 *  根据cellObject清楚缓存高
 *
 *  @param cellObject YJUITableCellObject
 *
 *  @return void
 */
- (void)clearCacheHeightWithCellObject:(YJUITableCellObject *)cellObject;

/**
 *  根据多个cellObject清楚缓存高
 *
 *  @param cellObject YJUITableCellObject
 *
 *  @return void
 */
- (void)clearCacheHeightWithCellObjects:(NSArray<YJUITableCellObject *> *)cellObjects;

@end

NS_ASSUME_NONNULL_END
