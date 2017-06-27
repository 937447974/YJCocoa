//
//  YJUIScrollViewManager.h
//  ScrollViewManager
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/22.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJUIScrollViewManager;

/** UIScrollView滚动*/
typedef NS_OPTIONS(NSInteger, YJUIScrollViewScroll) {
    // 上方出现[0,2]
    YJUIScrollViewScrollEndTop,  ///< 滚动到顶部
    YJUIScrollViewScrollEdgeTop, ///< 滚动到边缘顶部
    YJUIScrollViewScrollDidTop,  ///< 向上滚动
    // 左方出现[3,5]
    YJUIScrollViewScrollEndLeft,  ///< 滚动到最左
    YJUIScrollViewScrollEdgeLeft, ///< 滚动到边缘左
    YJUIScrollViewScrollDidLeft,  ///< 向左滚动
    // 用户触摸[6]
    YJUIScrollViewScrollNone, ///< 用户触摸，将要滚动
    // 右方出现[7,9]
    YJUIScrollViewScrollDidRight,  ///< 向右滚动
    YJUIScrollViewScrollEdgeRight, ///< 滚动到边缘右
    YJUIScrollViewScrollEndRight,  ///< 滚动到最右
    // 下方出现[10,12]
    YJUIScrollViewScrollDidBottom,  ///< 向下滚动
    YJUIScrollViewScrollEdgeBottom, ///< 滚动到边缘底部
    YJUIScrollViewScrollEndBottom   ///< 滚动到底部
};


/** UIScrollView滚动的协议*/
@protocol YJUIScrollViewManagerDelegate <NSObject>

@optional

/**
 *  @abstract  用户垂直滚动UIScrollView
 *
 *  @param manager YJUIScrollViewManager
 *  @param scroll  YJUIScrollViewScroll
 */
- (void)scrollViewManager:(YJUIScrollViewManager *)manager didVerticalScroll:(YJUIScrollViewScroll)scroll;

/**
 *  @abstract  用户水平滚动UIScrollView
 *
 *  @param manager YJUIScrollViewManager
 *  @param scroll  YJUIScrollViewScroll
 */
- (void)scrollViewManager:(YJUIScrollViewManager *)manager didHorizontalScroll:(YJUIScrollViewScroll)scroll;

@end


/** UIScrollView管理器*/
@interface YJUIScrollViewManager : NSObject

@property (nonatomic) CGFloat didSpacing;     ///< 已经滚动间隔,控制.Did...枚举提示间隔
@property (nonatomic) UIEdgeInsets endInset;  ///< 边界距离,控制.End...枚举提示区域
@property (nonatomic) UIEdgeInsets edgeInset; ///< 边缘距离,控制.Edge...枚举提示区域,需edgeInset内值>endInset内值

@property (nonatomic, weak) id<YJUIScrollViewManagerDelegate> delegate; ///< 滑动代理监听

@property (nonatomic, weak, readonly) UIScrollView *scrollView; ///< UIScrollView

/**
 *  @abstract 初始化
 *
 *  @param scrollView UIScrollView
 *
 *  @return YJUIScrollViewManager
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

/**
 *  @abstract 添加UIScrollView的AOP代理
 *  @discusstion VC想实现UIScrollViewDelegate时，又不想替换框架中的方法，可通过此方法添加
 *
 *  @param delegate id<UIScrollViewDelegate>
 */
- (void)addScrollViewAOPDelegate:(id<UIScrollViewDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
