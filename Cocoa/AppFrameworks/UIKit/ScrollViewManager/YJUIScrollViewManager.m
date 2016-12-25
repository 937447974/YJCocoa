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
        self.scrollSpacingDid = 30;
        self.edgeInset = UIEdgeInsetsZero;
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
    CGFloat top = scrollView.contentOffset.y;
    if (top <= 0 || top <= self.edgeInset.top) {
        if ( self.edgeInset.top < 0 && top <= self.edgeInset.top) {
            self.verticalScroll = YJUIScrollViewScrollEdgeTop;
        } else if (top <= 0) {
            self.verticalScroll = YJUIScrollViewScrollEndTop;
        } else {
            self.verticalScroll = YJUIScrollViewScrollEdgeTop;
        }
        return;
    }
    CGFloat bottom = top + scrollView.heightFrame;
    CGFloat edgeHeight = scrollView.contentSize.height - self.edgeInset.bottom;
    if (bottom >= scrollView.contentSize.height || bottom >= edgeHeight) {
        if (self.edgeInset.bottom < 0 && bottom >= edgeHeight) {
            self.verticalScroll = YJUIScrollViewScrollEdgeBottom;
        } else if (bottom >= scrollView.contentSize.height) {
            self.verticalScroll = YJUIScrollViewScrollEndBottom;
        } else {
            self.verticalScroll = YJUIScrollViewScrollEdgeBottom;
        }
        return;
    }
    CGFloat spacing = top - _contentOffset.y;
    if (spacing <= -self.scrollSpacingDid) {
        self.verticalScroll = YJUIScrollViewScrollDidTop;
        _contentOffset.y = top;
    } else if (spacing >= self.scrollSpacingDid) {
        _contentOffset.y = top;
        self.verticalScroll = YJUIScrollViewScrollDidBottom;
    }
}

- (void)scrollViewDidHorizontalScroll:(UIScrollView *)scrollView {
    CGFloat left = scrollView.contentOffset.x;
    if (left <= 0 || left <= self.edgeInset.left) {
        if (self.edgeInset.left < 0 && left <= self.edgeInset.left) {
            self.horizontalScroll = YJUIScrollViewScrollEdgeLeft;
        } else if (left <= 0) {
            self.horizontalScroll = YJUIScrollViewScrollEndLeft;
        } else {
            self.horizontalScroll = YJUIScrollViewScrollEdgeLeft;
        }
        return;
    }
    CGFloat right = left + scrollView.widthFrame;
    CGFloat edgeWidth = scrollView.contentSize.width - self.edgeInset.right;
    if (right >= scrollView.contentSize.width || right >= edgeWidth) {
        if (self.edgeInset.left < 0 && right >= edgeWidth) {
            self.horizontalScroll = YJUIScrollViewScrollEdgeRight;
        } else if (right >= scrollView.contentSize.width) {
            self.horizontalScroll = YJUIScrollViewScrollEndRight;
        } else {
            self.horizontalScroll = YJUIScrollViewScrollEdgeRight;
        }
        return;
    }
    CGFloat spacing = left - _contentOffset.x;
    if (spacing <= -self.scrollSpacingDid) {
        self.horizontalScroll = YJUIScrollViewScrollDidLeft;
        _contentOffset.x = left;
    } else if (spacing >= self.scrollSpacingDid) {
        self.horizontalScroll = YJUIScrollViewScrollDidRight;
        _contentOffset.x = left;
    }
}

#pragma mark - getter & setter
- (void)setDelegate:(id<YJUIScrollViewManagerDelegate>)delegate {
    _delegate = delegate;
    _verticalScrollEnable = [delegate respondsToSelector:@selector(scrollViewManager:didVerticalScroll:)];
    _horizontalScrollEnable = [delegate respondsToSelector:@selector(scrollViewManager:didHorizontalScroll:)];
    if (!self.aopDelegate) {
        _scrollView.delegate = self;
    }
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
