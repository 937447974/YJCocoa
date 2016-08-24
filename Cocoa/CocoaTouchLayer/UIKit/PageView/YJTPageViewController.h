//
//  YJTPageViewController.h
//  YJTPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJTPageViewObject, YJTPageView;

/** PageView的item基类*/
@interface YJTPageViewController : UIViewController

@property (nonatomic, weak, readonly) YJTPageViewObject *pageViewObject; ///< 封装的模型
@property (nonatomic, weak, readonly) YJTPageView *pageView;             ///< YJTPageView

/**
 *  获取YJTPageViewObject
 *
 *  @return YJTPageViewObject
 */
+ (YJTPageViewObject *)pageViewObject;

/**
 *  刷新page（同步&异步，子类请勿重写）
 *
 *  @param pageViewObject page封装的对象
 *  @param pageView       YJTPageView
 *
 *  @return void
 */
- (void)reloadDataWithPageViewObject:(YJTPageViewObject *)pageViewObject pageView:(YJTPageView *)pageView;

/**
 *  刷新page(同步)
 *
 *  @param pageViewObject page封装的对象
 *  @param pageView       YJTPageView
 *
 *  @return void
 */
- (void)reloadDataSyncWithPageViewObject:(YJTPageViewObject *)pageViewObject pageView:(YJTPageView *)pageView;

/**
 *  刷新page(异步)
 *
 *  @param pageViewObject page封装的对象
 *  @param pageView       YJTPageView
 *
 *  @return void
 */
- (void)reloadDataAsyncWithPageViewObject:(YJTPageViewObject *)pageViewObject pageView:(YJTPageView *)pageView;

@end

NS_ASSUME_NONNULL_END
