//
//  YJUITableViewDelegateManager.h
//  YJTableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/17.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUITableViewManager;

/** 缓存高的策略*/
typedef NS_ENUM(NSInteger, YJUITableViewCacheHeight) {
    YJUITableViewCacheHeightDefault,          ///< 根据相同的UITableViewCell类缓存高度
    YJUITableViewCacheHeightIndexPath,        ///< 根据NSIndexPath对应的位置缓存高度
    YJUITableViewCacheHeightClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存高度
};

/** UITableViewDelegate管理器*/
@interface YJUITableViewDelegateManager : NSObject<UITableViewDelegate>

@property (nonatomic, weak, readonly) YJUITableViewManager *manager; ///< YJUITableViewManager

@property (nonatomic) BOOL isCacheHeight;                           ///< 是否缓存高，默认YES缓存，NO不缓存
@property (nonatomic) YJUITableViewCacheHeight cacheHeightStrategy; ///< 缓存高的策略

/**
 *  @abstract 初始化
 *
 *  @param manager YJUITableViewManager
 *
 *  @return YJUITableViewDelegateManager
 */
- (instancetype)initWithManager:(YJUITableViewManager *)manager;

/**
 *  @abstract 清除所有缓存高
 */
- (void)clearAllCacheHeight;

/**
 *  @abstract 根据cellObject清楚缓存高
 *
 *  @param cellObject YJUITableCellObject
 */
- (void)clearCacheHeightWithCellObject:(YJUITableCellObject *)cellObject;

/**
 *  @abstract 根据多个cellObject清楚缓存高
 *
 *  @param cellObjects YJUITableCellObject
 */
- (void)clearCacheHeightWithCellObjects:(NSArray<YJUITableCellObject *> *)cellObjects;

@end

NS_ASSUME_NONNULL_END
