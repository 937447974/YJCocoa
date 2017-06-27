//
//  YJUIPageViewManager.h
//  YJUIPageViewManager
//
//  Created by admin on 2017/5/3.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJUIPageViewCell.h"

NS_ASSUME_NONNULL_BEGIN

/** 缓存 cell 的策略*/
typedef NS_ENUM(NSInteger, YJUIPageViewCellCache) {
    YJUIPageViewCellCacheDefault,///< 根据类缓存
    YJUIPageViewCellCacheIndex,  ///< 根据位置缓存
};

@protocol YJUIPageViewManagerDelegate <NSObject>
@end

/** UIPageViewController 管理器*/
@interface YJUIPageViewManager : NSObject <UIPageViewControllerDataSource>

@property (nonatomic) BOOL isLoop;           ///< 是否循环展示、默认YES循环
@property (nonatomic) BOOL isDisableBounces; ///< 是否取消阻力效果（YES时，isLoop自动设为NO）

@property (nonatomic) NSTimeInterval timeInterval;     ///< 轮播转动时间间隔（0停止；>0时开启，自动设置isLoop=YES,isDisableBounces=NO）
@property (nonatomic) YJUIPageViewCellCache cellCache; ///< 缓存策略

@property (nonatomic, weak) id<YJUIPageViewManagerDelegate> delegate; ///< YJUIPageViewManagerDelegate

@property (nonatomic, strong) NSMutableArray<YJUIPageViewCellObject *> *dataSource; ///< 数据源


/**
 *  @abstract 初始化
 *
 *  @param pageVC UIPageViewController
 *
 *  @return YJUIPageViewManager
 */
- (instancetype)initWithPageViewController:(UIPageViewController *)pageVC;

/**
 *  @abstract 刷新pageVC
 */
- (void)reloadPage;

/**
 *  @abstract 前往指定界面
 *
 *  @param pageIndex  页码[0...]
 *  @param animated   是否动画
 *  @param completion 回调
 */
- (void)gotoPageWithIndex:(NSInteger)pageIndex animated:(BOOL)animated completion:(void (^ __nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
