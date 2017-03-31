//
//  YJUIScrollViewManager.m
//  ScrollViewManager
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/22.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUIScrollViewManager.h"
#import "YJNSAspectOrientProgramming.h"
#import "UIView+YJUIViewGeometry.h"

@interface YJUIScrollViewManager () <UIScrollViewDelegate> {
    BOOL _verticalScrollEnable;   ///< 垂直开关
    BOOL _horizontalScrollEnable; ///< 水平开关
    CGPoint _contentOffset; ///< 起点
}

@property (nonatomic, strong) YJNSAspectOrientProgramming *aopDelegate; ///< 切面代理
@property (nonatomic) YJUIScrollViewScroll verticalScroll;   ///< 垂直滚动
@property (nonatomic) YJUIScrollViewScroll horizontalScroll; ///< 水平滚动

@end

@implementation YJUIScrollViewManager

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    self = [self init];
    if (self) {
        _scrollView = scrollView;
        self.didSpacing = 30;
        self.edgeInset = UIEdgeInsetsZero;
        self.endInset = UIEdgeInsetsZero;
        _scrollView.delegate = self;
    }
    return self;
}

- (void)addScrollViewAOPDelegate:(id<UIScrollViewDelegate>)delegate {
    if (!_aopDelegate) {
        _aopDelegate = [[YJNSAspectOrientProgramming alloc] init];
        [_aopDelegate addTarget:self];
    }
    [_aopDelegate addTarget:delegate];
    self.scrollView.delegate = (id<UIScrollViewDelegate>)self.aopDelegate;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _contentOffset = scrollView.contentOffset;
    if (_verticalScrollEnable)   self.verticalScroll = YJUIScrollViewScrollNone;
    if (_horizontalScrollEnable) self.horizontalScroll = YJUIScrollViewScrollNone;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_verticalScrollEnable)   [self scrollViewDidVerticalScroll:scrollView];
    if (_horizontalScrollEnable) [self scrollViewDidHorizontalScroll:scrollView];
}

#pragma mark - private
- (void)scrollViewDidVerticalScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    if (y <= self.endInset.top) {
        self.verticalScroll = YJUIScrollViewScrollEndTop;
    } else if (y <= self.edgeInset.top) {
        self.verticalScroll = YJUIScrollViewScrollEdgeTop;
    } else {
        CGFloat scrollHeight = scrollView.heightFrame > scrollView.contentSize.height ? scrollView.heightFrame : scrollView.contentSize.height;
        CGFloat bottom = y + scrollView.heightFrame;
        if (bottom >= scrollHeight - self.endInset.bottom) {
            self.verticalScroll = YJUIScrollViewScrollEndBottom;
        } else if (bottom >= scrollHeight - self.edgeInset.bottom) {
            self.verticalScroll = YJUIScrollViewScrollEdgeBottom;
        } else {
            CGFloat spacing = y - _contentOffset.y;
            if (spacing <= -self.didSpacing) {
                self.verticalScroll = YJUIScrollViewScrollDidTop;
                _contentOffset.y = y;
            } else if (spacing >= self.didSpacing) {
                self.verticalScroll = YJUIScrollViewScrollDidBottom;
                _contentOffset.y = y;
            }
        }
    }
}

- (void)scrollViewDidHorizontalScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    if (x <= self.endInset.left) {
        self.horizontalScroll = YJUIScrollViewScrollEndLeft;
    } else if (x <= self.edgeInset.left) {
        self.horizontalScroll = YJUIScrollViewScrollEdgeLeft;
    } else {
        CGFloat scrollWidth = scrollView.widthFrame > scrollView.contentSize.width ? scrollView.widthFrame : scrollView.contentSize.width;
        CGFloat right = x + scrollView.widthFrame;
        if (right >= scrollWidth - self.endInset.right) {
            self.horizontalScroll = YJUIScrollViewScrollEndRight;
        } else if (right >= scrollWidth - self.edgeInset.right) {
            self.horizontalScroll = YJUIScrollViewScrollEdgeRight;
        } else {
            CGFloat spacing = x - _contentOffset.x;
            if (spacing <= -self.didSpacing) {
                self.horizontalScroll = YJUIScrollViewScrollDidLeft;
                _contentOffset.x = x;
            } else if (spacing >= self.didSpacing) {
                self.horizontalScroll = YJUIScrollViewScrollDidRight;
                _contentOffset.x = x;
            }
        }
    }
}

#pragma mark - getter & setter
- (void)setDelegate:(id<YJUIScrollViewManagerDelegate>)delegate {
    _delegate = delegate;
    _verticalScrollEnable = [delegate respondsToSelector:@selector(scrollViewManager:didVerticalScroll:)];
    _horizontalScrollEnable = [delegate respondsToSelector:@selector(scrollViewManager:didHorizontalScroll:)];
}

- (void)setVerticalScroll:(YJUIScrollViewScroll)verticalScroll {
    if (_verticalScroll == YJUIScrollViewScrollNone || _verticalScroll != verticalScroll) {
        _verticalScroll = verticalScroll;
        [self.delegate scrollViewManager:self didVerticalScroll:verticalScroll];
    }
}

- (void)setHorizontalScroll:(YJUIScrollViewScroll)horizontalScroll {
    if (_horizontalScroll == YJUIScrollViewScrollNone || _horizontalScroll != horizontalScroll) {
        _horizontalScroll = horizontalScroll;
        [self.delegate scrollViewManager:self didHorizontalScroll:horizontalScroll];
    }
}

@end
