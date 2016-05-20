//
//  UIView+YJViewLayoutConstraintCreation.m
//  YJAutoLayout
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "UIView+YJViewLayoutConstraintCreation.h"

@implementation UIView (YJViewLayoutConstraintCreation)

#pragma mark - base
- (YJLayoutXAxisAnchor *)leftLayout {
    return [[YJLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeLeft];    
}

- (YJLayoutXAxisAnchor *)rightLayout {
    return [[YJLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeRight];
}

- (YJLayoutYAxisAnchor *)topLayout {
    return [[YJLayoutYAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeTop];
}

- (YJLayoutYAxisAnchor *)bottomLayout {
    return [[YJLayoutYAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeBottom];
}

- (YJLayoutXAxisAnchor *)leadingLayout {
    return [[YJLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeLeading];
}

- (YJLayoutXAxisAnchor *)trailingLayout {
    return [[YJLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeTrailing];
}

- (YJLayoutDimension *)widthLayout {
    return [[YJLayoutDimension alloc] initWithItem:self attribute:NSLayoutAttributeWidth];
}

- (YJLayoutDimension *)heightLayout {
    return [[YJLayoutDimension alloc] initWithItem:self attribute:NSLayoutAttributeHeight];
}

- (YJLayoutXAxisAnchor *)centerXLayout {
    return [[YJLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeCenterX];
}

- (YJLayoutYAxisAnchor *)centerYLayout {
    return [[YJLayoutYAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeCenterY];
}

#pragma mark - SpaceToSuper
- (SpaceToSuper)topSpaceToSuper {
    
    __kindof __weak UIView *wSelf = self;
    SpaceToSuper block = ^ (CGFloat constant) {
        [NSLayoutConstraint constraintWithItem:wSelf attribute:NSLayoutAttributeTop equalToItem:wSelf.superview attribute:NSLayoutAttributeTop constant:constant];
        return wSelf;
    };
    return block;
    
}

- (SpaceToSuper)bottomSpaceToSuper {
    
    __kindof __weak UIView *wSelf = self;
    SpaceToSuper block = ^ (CGFloat constant) {
        [NSLayoutConstraint constraintWithItem:wSelf.superview attribute:NSLayoutAttributeBottom equalToItem:wSelf attribute:NSLayoutAttributeBottom constant:constant];
        return wSelf;
    };
    return block;
    
}

- (SpaceToSuper)leadingSpaceToSuper {
    
    __kindof __weak UIView *wSelf = self;
    SpaceToSuper block = ^ (CGFloat constant) {
        [NSLayoutConstraint constraintWithItem:wSelf attribute:NSLayoutAttributeLeading equalToItem:wSelf.superview attribute:NSLayoutAttributeLeading constant:constant];
        return wSelf;
    };
    return block;
    
}

- (SpaceToSuper)trailingSpaceToSuper {
    
    __kindof __weak UIView *wSelf = self;
    SpaceToSuper block = ^ (CGFloat constant) {
        [NSLayoutConstraint constraintWithItem:wSelf.superview attribute:NSLayoutAttributeTrailing equalToItem:wSelf attribute:NSLayoutAttributeTrailing constant:constant];
        return wSelf;
    };
    return block;
    
}

#pragma mark - CombinativeLayout
- (CombinativeLayout)sizeLayoutTo {
    
    __weak UIView *wSelf = self;
    CombinativeLayout block = ^ (UIView *view) {
        [NSLayoutConstraint constraintWithItem:wSelf attribute:NSLayoutAttributeWidth equalToItem:view attribute:NSLayoutAttributeWidth];
        [NSLayoutConstraint constraintWithItem:wSelf attribute:NSLayoutAttributeHeight equalToItem:view attribute:NSLayoutAttributeHeight];
    };
    return block;
    
}

- (CombinativeLayout)centerLayoutTo {
    
    __weak UIView *wSelf = self;
    CombinativeLayout block = ^ (UIView *view) {
        [NSLayoutConstraint constraintWithItem:wSelf attribute:NSLayoutAttributeCenterX equalToItem:view attribute:NSLayoutAttributeCenterX];
        [NSLayoutConstraint constraintWithItem:wSelf attribute:NSLayoutAttributeCenterY equalToItem:view attribute:NSLayoutAttributeCenterY];
    };
    return block;
    
}

- (CombinativeLayout)boundsLayoutTo {
    
    __weak UIView *wSelf = self;
    CombinativeLayout block = ^ (UIView *view) {
        wSelf.sizeLayoutTo(view);
        wSelf.centerLayoutTo(view);
    };
    return block;
    
}


@end
