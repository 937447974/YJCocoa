//
//  YJUIPageViewController.h
//  YJUIPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJUIPageViewObject, YJUIPageView;

/** PageView的item基类*/
@interface YJUIPageViewController : UIViewController

@property (nonatomic, weak, readonly) YJUIPageViewObject *pageViewObject; ///< 封装的模型
@property (nonatomic, weak, readonly) YJUIPageView *pageView;             ///< YJUIPageView

/**
 *  获取YJUIPageViewObject
 *
 *  @return YJUIPageViewObject
 */
+ (YJUIPageViewObject *)pageViewObject;

/**
 *  刷新page（同步&异步，子类请勿重写）
 *
 *  @param pageViewObject page封装的对象
 *  @param pageView       YJUIPageView
 *
 *  @return void
 */
- (void)reloadDataWithPageViewObject:(YJUIPageViewObject *)pageViewObject pageView:(YJUIPageView *)pageView;

/**
 *  刷新page(同步)
 *
 *  @param pageViewObject page封装的对象
 *  @param pageView       YJUIPageView
 *
 *  @return void
 */
- (void)reloadDataSyncWithPageViewObject:(YJUIPageViewObject *)pageViewObject pageView:(YJUIPageView *)pageView;

/**
 *  刷新page(异步)
 *
 *  @param pageViewObject page封装的对象
 *  @param pageView       YJUIPageView
 *
 *  @return void
 */
- (void)reloadDataAsyncWithPageViewObject:(YJUIPageViewObject *)pageViewObject pageView:(YJUIPageView *)pageView;

@end

NS_ASSUME_NONNULL_END
