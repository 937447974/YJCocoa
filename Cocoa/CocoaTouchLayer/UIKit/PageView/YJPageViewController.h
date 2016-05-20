//
//  YJPageViewController.h
//  YJPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJPageViewObject, YJPageView;

/** PageView的item基类*/
@interface YJPageViewController : UIViewController

@property (nonatomic, weak) YJPageViewObject *pageViewObject; ///< 封装的模型
@property (nonatomic, weak) YJPageView *pageView;             ///< YJPageView

/**
 *  获取YJPageViewObject
 *
 *  @return YJPageViewObject
 */
+ (YJPageViewObject *)pageViewObject;

/**
 *  根据模型刷新page(同步)
 *
 *  @param pageViewObject page封装的对象
 *  @param pageView       YJPageView
 *
 *  @return void
 */
- (void)reloadPageSyncWithPageViewObject:(YJPageViewObject *)pageViewObject pageView:(YJPageView *)pageView;

/**
 *  根据模型刷新page(异步)
 *
 *  @param pageViewObject page封装的对象
 *  @param pageView       YJPageView
 *
 *  @return void
 */
- (void)reloadPageAsyncWithPageViewObject:(YJPageViewObject *)pageViewObject pageView:(YJPageView *)pageView;

@end

NS_ASSUME_NONNULL_END
