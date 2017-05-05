//
//  YJUIPageViewManager.m
//  YJUIPageViewManager
//
//  Created by admin on 2017/5/3.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJUIPageViewManager.h"
#import "YJNSTimer.h"
#import "YJDispatch.h"

#pragma mark - YJUIPageViewCellPrivateProperty
@protocol YJUIPageViewCellPrivateProperty <NSObject>

@optional
@property (nonatomic, copy) void (^ viewDidAppearBlock)(YJUIPageViewCell *cell); ///< cell显示, 框架使用

@end

@interface YJUIPageViewCell (YJPrivateProperty)<YJUIPageViewCellPrivateProperty>
@end

#pragma mark - YJUIPageViewManager
@interface YJUIPageViewManager ()

@property (nonatomic) NSInteger currentPageIndex;

@property (nonatomic, weak) UIPageViewController *pageVC;
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableDictionary<NSString *, YJUIPageViewCell*> *pageCache;
@property (nonatomic, strong) YJNSTimer *timer;

@end

@implementation YJUIPageViewManager

- (instancetype)initWithPageViewController:(UIPageViewController *)pageVC {
    self = [super init];
    if (self) {
        pageVC.dataSource = self;
        self.pageVC = pageVC;
        self.dataSource = [NSMutableArray array];
        self.pageCache = [NSMutableDictionary dictionary];
        @weakSelf
        self.timer = [YJNSTimer timerIdentifier:nil target:self completionHandler:^(YJNSTimer * _Nonnull timer) {
            @strongSelf
            [self gotoPageWithIndex:self.currentPageIndex+1 animated:YES completion:nil];
        }];
    }
    return self;
}

- (void)reloadPage {
    [self gotoPageWithIndex:0 animated:NO completion:nil];
}

- (void)gotoPageWithIndex:(NSInteger)pageIndex animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    NSMutableArray<YJUIPageViewCell *> *array = [NSMutableArray array];
    YJUIPageViewCell *pvc = [self pageViewCellAtIndex:pageIndex];
    if (!pvc) {
        return;
    }
    [array addObject:pvc];
    if (self.pageVC.spineLocation == UIPageViewControllerSpineLocationMid) { // 双页面显示
        pvc = [self pageViewCellAtIndex:pageIndex+1];
        if (pvc) {
            [array addObject:pvc];
        } else {
            pvc = [self pageViewCellAtIndex:pageIndex-1];
            if (!pvc) {
                return;
            }
            [array insertObject:pvc atIndex:0];
        }
    }
    UIPageViewControllerNavigationDirection direction = pageIndex >= self.currentPageIndex ?UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    [self.pageVC setViewControllers:array direction:direction animated:animated completion:completion];
}

#pragma mark - private
- (nullable YJUIPageViewCell *)pageViewCellAtIndex:(NSInteger)pageIndex {
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
    NSString *cacheKey;
    if (self.cellCache == YJUIPageViewCellCacheDefault) {
        cacheKey = [NSString stringWithFormat:@"%@-%ld", NSStringFromClass(cellObject.class), (long)pageIndex%3];
    } else {
        cacheKey = [NSString stringWithFormat:@"%ld", (long)pageIndex];
    }
    YJUIPageViewCell *pageVC = [self.pageCache objectForKey:cacheKey];
    if (!pageVC) { // 未缓存，则初始化
        pageVC = [[cellObject.pageClass alloc] initPageView];
        [self.pageCache setObject:pageVC forKey:cacheKey];
        if (!pageVC.view.backgroundColor) {
            pageVC.view.backgroundColor = [UIColor whiteColor];
        }
        @weakSelf
        pageVC.viewDidAppearBlock = ^ (YJUIPageViewCell *cell) {
            @strongSelf
            self.currentPageIndex = cell.cellObject.pageIndex;
        };
    }
    // 刷新page
    [pageVC reloadDataWithPageViewCellObject:cellObject pageViewManager:self];
    return pageVC;
}


#pragma mark - UIPageViewControllerDataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    YJUIPageViewCell *pageVC = (YJUIPageViewCell *)viewController;
    return [self pageViewCellAtIndex:pageVC.cellObject.pageIndex - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    YJUIPageViewCell *pageVC = (YJUIPageViewCell *)viewController;
    return [self pageViewCellAtIndex:pageVC.cellObject.pageIndex + 1];
}

#pragma mark - KOV
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = self.scrollView.contentOffset;
        if (self.currentPageIndex == 0) { // 首页
            switch (self.pageVC.navigationOrientation) {
                case UIPageViewControllerNavigationOrientationHorizontal:
                    if (contentOffset.x < self.scrollView.frame.size.width) {
                        contentOffset.x = self.scrollView.frame.size.width;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
                case UIPageViewControllerNavigationOrientationVertical:
                    if (contentOffset.y < self.scrollView.frame.size.height) {
                        contentOffset.y = self.scrollView.frame.size.height;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
            }
        }
        if (self.currentPageIndex == self.dataSource.count - 1) { // 尾页
            switch (self.pageVC.navigationOrientation) {
                case UIPageViewControllerNavigationOrientationHorizontal:
                    if (contentOffset.x > self.scrollView.frame.size.width) {
                        contentOffset.x = self.scrollView.frame.size.width;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
                case UIPageViewControllerNavigationOrientationVertical:
                    if (contentOffset.y>self.scrollView.frame.size.height) {
                        contentOffset.y = self.scrollView.frame.size.height;
                        [self.scrollView setContentOffset:contentOffset animated:NO];
                    }
                    break;
            }
        }
    }
}

#pragma mark - getter & setter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        for (UIView *v in self.pageVC.view.subviews) {
            if ([v isKindOfClass:[UIScrollView class]]) {
                _scrollView = (UIScrollView *)v;
                return _scrollView;
            }
        }
    }
    return _scrollView;
}

- (void)setIsLoop:(BOOL)isLoop {
    _isLoop = isLoop;
    if (isLoop) {
        self.isDisableBounces = NO;
    }
}

- (void)setIsDisableBounces:(BOOL)isDisableBounces {
    if (isDisableBounces) {
        _isLoop = NO;
        if (!_isDisableBounces)
            [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    } else if (_isDisableBounces) {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _isDisableBounces = isDisableBounces;
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    if (timeInterval > 0) {
        self.isLoop = YES;
        self.timer.timeInterval = timeInterval;
        [self.timer run];
    } else {
        [self.timer invalidate];
    }
}

@end
