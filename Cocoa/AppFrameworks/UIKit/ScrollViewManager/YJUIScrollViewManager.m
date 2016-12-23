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
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat spacing = contentOffsetY - _contentOffset.y;
    if (contentOffsetY <= 0) {
        self.verticalScroll = YJUIScrollViewScrollEndTop;
    } else if (self.edgeInset.top && contentOffsetY <= self.edgeInset.top) {
        self.verticalScroll = YJUIScrollViewScrollEdgeTop;
    } else if (contentOffsetY + scrollView.heightFrame >= scrollView.contentSize.height) {
        self.verticalScroll = YJUIScrollViewScrollEndBottom;
    } else if (self.edgeInset.bottom && contentOffsetY + scrollView.heightFrame >= scrollView.contentSize.height - self.edgeInset.bottom) {
        self.verticalScroll = YJUIScrollViewScrollEdgeBottom;
    } else if (spacing <= -self.scrollSpacingDid) {
        self.verticalScroll = YJUIScrollViewScrollDidTop;
        _contentOffset.y = contentOffsetY;
    } else if (spacing >= self.scrollSpacingDid) {
        _contentOffset.y = contentOffsetY;
        self.verticalScroll = YJUIScrollViewScrollDidBottom;
    }
}

- (void)scrollViewDidHorizontalScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat spacing = contentOffsetX - _contentOffset.x;
    if (contentOffsetX <= 0) {
        self.horizontalScroll = YJUIScrollViewScrollEndLeft;
    }  else if (self.edgeInset.left && contentOffsetX <= self.edgeInset.left) {
        self.horizontalScroll = YJUIScrollViewScrollEdgeLeft;
    } else if (contentOffsetX+ scrollView.widthFrame >= scrollView.contentSize.width) {
        self.horizontalScroll = YJUIScrollViewScrollEndRight;
    } else if (self.edgeInset.right && contentOffsetX + scrollView.widthFrame >= scrollView.contentSize.width - self.edgeInset.right) {
        self.horizontalScroll = YJUIScrollViewScrollEdgeRight;
    } else if (spacing <= -self.scrollSpacingDid) {
        self.horizontalScroll = YJUIScrollViewScrollDidLeft;
        _contentOffset.x = contentOffsetX;
    } else if (spacing >= self.scrollSpacingDid) {
        self.horizontalScroll = YJUIScrollViewScrollDidRight;
        _contentOffset.x = contentOffsetX;
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
