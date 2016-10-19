//
//  UIView+YJUIViewGeometry.m
//  YJViewGeometry
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/31.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "UIView+YJUIViewGeometry.h"

@implementation UIView (YJUIViewGeometry)


#pragma mark .frame.origin.y
- (CGFloat)topFrame {
    return self.frame.origin.y;
}

- (void)setTopFrame:(CGFloat)topFrame {
    CGRect frame = self.frame;
    frame.origin.y = topFrame;
    self.frame = frame;
}

#pragma mark .topFrame + .heightFrame
- (CGFloat)bottomFrame {
    return self.topFrame + self.heightFrame;
}

- (void)setBottomFrame:(CGFloat)bottomFrame {
    self.topFrame = bottomFrame - self.heightFrame;
}

#pragma mark .frame.origin.x
- (CGFloat)leadingFrame {
    return self.frame.origin.x;
}

- (void)setLeadingFrame:(CGFloat)leadingFrame {
    CGRect frame = self.frame;
    frame.origin.x = leadingFrame;
    self.frame = frame;
}

#pragma mark .leadingFrame + .widthFrame
- (CGFloat)trailingFrame {
    return self.leadingFrame + self.widthFrame;
}

- (void)setTrailingFrame:(CGFloat)trailingFrame {
    self.leadingFrame = trailingFrame - self.widthFrame;
}

#pragma mark - .frame.size.width
- (CGFloat)widthFrame {
    return self.frame.size.width;
}

- (void)setWidthFrame:(CGFloat)widthFrame {
    CGRect frame = self.frame;
    frame.size.width = widthFrame;
    self.frame = frame;
}

#pragma mark .frame.size.height
- (CGFloat)heightFrame {
    return self.frame.size.height;
}

- (void)setHeightFrame:(CGFloat)heightFrame {
    CGRect frame = self.frame;
    frame.size.height = heightFrame;
    self.frame = frame;
}

#pragma mark - .frame.origin
- (CGPoint)originFrame {
    return self.frame.origin;
}

- (void)setOriginFrame:(CGPoint)originFrame {
    CGRect frame = self.frame;
    frame.origin = originFrame;
    self.frame = frame;
}

#pragma mark .frame.szie
- (CGSize)sizeFrame {
    return self.frame.size;
}

- (void)setSizeFrame:(CGSize)sizeFrame {
    CGRect frame = self.frame;
    frame.size = sizeFrame;
    self.frame = frame;
}

#pragma mark - Window
#pragma mark .frame.origin in Window
- (CGPoint)originFrameInWindow {
    CGPoint origin = self.originFrame;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *superview = self.superview;
    while (superview && ![superview isEqual:window]) {
        origin.x += superview.originFrame.x;
        origin.y += superview.originFrame.y;
        if ([superview isKindOfClass:[UIScrollView class]]) {
            CGPoint contentOffset = ((UIScrollView *)superview).contentOffset;
            origin.x -= contentOffset.x;
            origin.y -= contentOffset.y;
        }
        superview = superview.superview;
    }
    return origin;
}

#pragma mark - bounds
#pragma mark .bounds.origin.y
- (CGFloat)topBounds {
    return self.bounds.origin.y;
}

- (void)setTopBounds:(CGFloat)topBounds {
    CGRect bounds = self.bounds;
    bounds.origin.y = topBounds;
    self.bounds = bounds;
}

#pragma mark .bounds.origin.x
- (CGFloat)leadingBounds {
    return self.bounds.origin.x;
}

- (void)setLeadingBounds:(CGFloat)leadingBounds {
    CGRect bounds = self.bounds;
    bounds.origin.x = leadingBounds;
    self.bounds = bounds;
}

#pragma mark .bounds.size.width
- (CGFloat)widthBounds {
    return self.bounds.size.width;
}

- (void)setWidthBounds:(CGFloat)widthBounds {
    CGRect bounds = self.bounds;
    bounds.size.width = widthBounds;
    self.bounds = bounds;
}

#pragma mark bounds.size.height
- (CGFloat)heightBounds {
    return self.bounds.size.height;
}

- (void)setHeightBounds:(CGFloat)heightBounds {
    CGRect bounds = self.bounds;
    bounds.size.height = heightBounds;
    self.bounds = bounds;
}

#pragma mark - center
#pragma mark .center.x
- (CGFloat)centerXFrame {
    return self.center.x;
}

- (void)setCenterXFrame:(CGFloat)centerXFrame {
    CGPoint center = self.center;
    center.x = centerXFrame;
    self.center = center;
}

#pragma mark .center.y
- (CGFloat)centerYFrame {
    return self.center.y;
}

- (void)setCenterYFrame:(CGFloat)centerYFrame {
    CGPoint center = self.center;
    center.y = centerYFrame;
    self.center = center;
}

@end
