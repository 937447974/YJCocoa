//
//  UIView+YJUIViewLayoutConstraintCreation.m
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "UIView+YJUIViewLayoutConstraintCreation.h"

@implementation UIView (YJUIViewLayoutConstraintCreation)

#pragma mark - base
- (YJNSLayoutXAxisAnchor *)leftLayout {
    return [[YJNSLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeLeft];    
}

- (YJNSLayoutXAxisAnchor *)rightLayout {
    return [[YJNSLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeRight];
}

- (YJNSLayoutYAxisAnchor *)topLayout {
    return [[YJNSLayoutYAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeTop];
}

- (YJNSLayoutYAxisAnchor *)bottomLayout {
    return [[YJNSLayoutYAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeBottom];
}

- (YJNSLayoutXAxisAnchor *)leadingLayout {
    return [[YJNSLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeLeading];
}

- (YJNSLayoutXAxisAnchor *)trailingLayout {
    return [[YJNSLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeTrailing];
}

- (YJNSLayoutDimension *)widthLayout {
    return [[YJNSLayoutDimension alloc] initWithItem:self attribute:NSLayoutAttributeWidth];
}

- (YJNSLayoutDimension *)heightLayout {
    return [[YJNSLayoutDimension alloc] initWithItem:self attribute:NSLayoutAttributeHeight];
}

- (YJNSLayoutXAxisAnchor *)centerXLayout {
    return [[YJNSLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeCenterX];
}

- (YJNSLayoutYAxisAnchor *)centerYLayout {
    return [[YJNSLayoutYAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeCenterY];
}

#pragma mark - ToSuper
#pragma mark 生成到superview的约束
- (SpaceToSuper)topSpaceToSuper {
    __kindof __weak UIView *wSelf = self;
    SpaceToSuper block = ^ (CGFloat constant) {
        wSelf.topLayout.equalTo(wSelf.superview.topLayout).constants(constant);
        return wSelf;
    };
    return block;
}

- (SpaceToSuper)bottomSpaceToSuper {
    __kindof __weak UIView *wSelf = self;
    SpaceToSuper block = ^ (CGFloat constant) {
        wSelf.superview.bottomLayout.equalTo(wSelf.bottomLayout).constants(constant);
        return wSelf;
    };
    return block;
}

- (SpaceToSuper)leadingSpaceToSuper {
    __kindof __weak UIView *wSelf = self;
    SpaceToSuper block = ^ (CGFloat constant) {
        wSelf.leadingLayout.equalTo(wSelf.superview.leadingLayout).constants(constant);
        return wSelf;
    };
    return block;
    
}

- (SpaceToSuper)trailingSpaceToSuper {
    __kindof __weak UIView *wSelf = self;
    SpaceToSuper block = ^ (CGFloat constant) {
        wSelf.superview.trailingLayout.equalTo(wSelf.trailingLayout).constants(constant);
        return wSelf;
    };
    return block;
}

#pragma mark 查找到superview的约束
- (Constraint)topConstraintToSuper {
    __weak UIView *wSelf = self;
    Constraint block = ^ () {
        return wSelf.topLayout.costraintTo(wSelf.superview.topLayout);
    };
    return block;
}

- (Constraint)bottomConstraintToSuper {
    __weak UIView *wSelf = self;
    Constraint block = ^ () {
        return wSelf.superview.bottomLayout.costraintTo(wSelf.bottomLayout);
    };
    return block;
}

- (Constraint)leadingConstraintToSuper {
    __weak UIView *wSelf = self;
    Constraint block = ^ () {
        return wSelf.leadingLayout.costraintTo(wSelf.superview.leadingLayout);
    };
    return block;
}

- (Constraint)trailingConstraintToSuper {
    __weak UIView *wSelf = self;
    Constraint block = ^ () {
        return wSelf.superview.trailingLayout.costraintTo(wSelf.trailingLayout);
    };
    return block;
}

#pragma mark - CombinativeLayout
- (CombinativeLayout)sizeLayoutTo {
    __weak UIView *wSelf = self;
    CombinativeLayout block = ^ (UIView *view) {
        wSelf.widthLayout.equalTo(view.widthLayout);
        wSelf.heightLayout.equalTo(view.heightLayout);
    };
    return block;
}

- (CombinativeLayout)centerLayoutTo {
    __weak UIView *wSelf = self;
    CombinativeLayout block = ^ (UIView *view) {
        wSelf.centerXLayout.equalTo(view.centerXLayout);
        wSelf.centerYLayout.equalTo(view.centerYLayout);
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
