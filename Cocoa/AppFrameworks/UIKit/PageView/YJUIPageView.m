//
//  YJUIPageView.m
//  YJUIPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUIPageView.h"
#import "YJAutoLayout.h"
#import "YJNSFoundationOther.h"
#import "YJNSTimer.h"

@interface YJUIPageView () <UIPageViewControllerDataSource> {
    UIPageViewController *_pageVC; ///< pageVC的备份
    NSInteger _appearWillIndex;    ///< 页面将要显示
    NSInteger _appearDidIndex;     ///< 当前页面
}

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) YJNSTimer *timer;   ///< 轮转图的时间触发器

@end

@implementation YJUIPageView

#pragma mark - 设置UIPageViewController
- (void)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options {
    if (_pageVC) {
        [_pageVC.view removeFromSuperview];
        [_pageVC removeFromParentViewController];
    }
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    _pageVC.dataSource = self;
    [self insertSubview:_pageVC.view atIndex:0];
    _pageVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    _pageVC.view.boundsLayoutTo(self);
    [[self superViewController:self.nextResponder] addChildViewController:_pageVC];
}

#pragma mark 刷新PageVC
- (void)reloadPage {
    [self gotoPageWithIndex:0 animated:NO completion:nil];
}

#pragma mark 前往指定界面
- (void)gotoPageWithIndex:(NSInteger)pageIndex animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    NSMutableArray<YJUIPageViewCell *> *array = [NSMutableArray array];
    YJUIPageViewCell *pvc = [self pageViewControllerAtIndex:pageIndex];
    if (!pvc) {
        return;
    }
    [array addObject:pvc];
    if (self.pageVC.spineLocation == UIPageViewControllerSpineLocationMid) { // 双页面显示
        pvc = [self pageViewControllerAtIndex:pageIndex+1];
        if (pvc) {
            [array addObject:pvc];
        } else {
            pvc = [self pageViewControllerAtIndex:pageIndex-1];
            if (!pvc) {
                return;
            }
            [array insertObject:pvc atIndex:0];
        }
    }
    UIPageViewControllerNavigationDirection direction =  pageIndex >= _appearDidIndex ?UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    [self.pageVC setViewControllers:array direction:direction animated:animated completion:completion];
}

#pragma mark - 辅助方法
#pragma mark 获取当前UIViewController
- (UIViewController *)superViewController:(UIResponder *)nextResponder {
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]])  {
        return [self superViewController:nextResponder.nextResponder];
    }
    return nil;
}

#pragma mark 自动轮播
- (void)timeLoop {
    [self gotoPageWithIndex:_appearDidIndex+1 animated:!self.isTimeLoopAnimatedStop completion:nil];
}

#pragma mark 获取指定位置的YJUIPageViewCell
- (YJUIPageViewCell *)pageViewControllerAtIndex:(NSInteger)pageIndex {
    // 数据校验
    if (self.dataSource.count == 0) {
        return nil;
    }
    if (!self.isLoop && (pageIndex < 0 || self.dataSource.count <= pageIndex )) {// 不轮循过滤
        return nil;
    }
    // 循环显示
    if (pageIndex < 0) {
        pageIndex = self.dataSource.count - 1;
    } else if (pageIndex == self.dataSource.count){
        pageIndex = 0;
    }
    YJUIPageViewCellObject *cellObject = self.dataSource[pageIndex];
    cellObject.pageIndex = pageIndex;
    // 页面缓存
    NSNumber *cacheKey = [NSNumber numberWithInteger:pageIndex];
    YJUIPageViewCell *pageVC = [self.pageCache objectForKey:cacheKey];
    if (!pageVC) { // 未缓存，则初始化
        pageVC = [[cellObject.pageClass alloc] initPageView];
        [self.pageCache setObject:pageVC forKey:cacheKey];
        if (!pageVC.view.backgroundColor) {
            pageVC.view.backgroundColor = [UIColor whiteColor];
        }
    }
    // 刷新page
    [pageVC reloadDataWithPageViewCellObject:cellObject pageView:self];
    return pageVC;
}

#pragma mark - KOV
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"] && _isDisableBounces && (_appearDidIndex == 0 || _appearDidIndex == self.dataSource.count-1)) {
        CGPoint contentOffset = self.scrollView.contentOffset;
        if (_appearDidIndex == 0) { // 首页
            switch (self.pageVC.navigationOrientation) {
                case UIPageViewControllerNavigationOrientationHorizontal:
                    if (contentOffset.x < self.frame.size.width) {
                        contentOffset.x = self.frame.size.width;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
                case UIPageViewControllerNavigationOrientationVertical:
                    if (contentOffset.y<self.frame.size.height) {
                        contentOffset.y = self.frame.size.height;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
            }
        }
        if (_appearDidIndex == self.dataSource.count-1) { // 尾页
            switch (self.pageVC.navigationOrientation) {
                case UIPageViewControllerNavigationOrientationHorizontal:
                    if (contentOffset.x > self.frame.size.width) {
                        contentOffset.x = self.frame.size.width;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
                case UIPageViewControllerNavigationOrientationVertical:
                    if (contentOffset.y>self.frame.size.height) {
                        contentOffset.y = self.frame.size.height;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
            }
        }
    }
}

#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    YJUIPageViewCell *pageVC = (YJUIPageViewCell *)viewController;
    return [self pageViewControllerAtIndex:pageVC.cellObject.pageIndex - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    YJUIPageViewCell *pageVC = (YJUIPageViewCell *)viewController;
    return [self pageViewControllerAtIndex:pageVC.cellObject.pageIndex + 1];
}

#pragma mark - getter and setter
- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        [self initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    }
    return _pageVC;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        for (UIView *v in self.pageVC.view.subviews) {
            if ([v isKindOfClass:[UIScrollView class]]) {
                _scrollView = (UIScrollView *)v;
            }
        }
    }
    return _scrollView;
}

- (NSMutableArray<YJUIPageViewCellObject *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableDictionary<NSNumber *,YJUIPageViewCell *> *)pageCache {
    if (!_pageCache) {
        _pageCache = [NSMutableDictionary dictionary];
    }
    return _pageCache;
}

- (void)setIsLoop:(BOOL)isLoop {
    _isLoop = isLoop;
    if (isLoop) {
        self.isDisableBounces = NO;
    }
}

- (void)setIsDisableScrool:(BOOL)isDisableScrool {
    _isDisableScrool = isDisableScrool;
    self.scrollView.scrollEnabled = !_isDisableScrool;
}

- (void)setIsDisableBounces:(BOOL)isDisableBounces {
    _isDisableBounces = isDisableBounces;
    if (_isDisableBounces) {
        _isLoop = NO;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    } else {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (YJNSTimer *)timer {
    if (!_timer) {
        _timer = [YJNSTimer]
    }
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    if (timeInterval > 0) {
        self.isLoop = YES;
        self.timer = [YJNSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timeLoop) userInfo:nil repeats:YES];
        // [self.timer setFireDate:[NSDate date]];// 继续
    } else {
        [self.timer setFireDate:[NSDate distantFuture]];// 暂停
    }    
}



@end
