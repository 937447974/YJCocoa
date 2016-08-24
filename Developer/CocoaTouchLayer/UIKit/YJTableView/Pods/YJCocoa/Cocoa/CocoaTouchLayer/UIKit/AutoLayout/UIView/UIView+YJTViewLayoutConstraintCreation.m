//
//  UIView+YJTViewLayoutConstraintCreation.m
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "UIView+YJTViewLayoutConstraintCreation.h"

@implementation UIView (YJTViewLayoutConstraintCreation)

#pragma mark - base
- (YJTLayoutXAxisAnchor *)leftLayout {
    return [[YJTLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeLeft];    
}

- (YJTLayoutXAxisAnchor *)rightLayout {
    return [[YJTLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeRight];
}

- (YJTLayoutYAxisAnchor *)topLayout {
    return [[YJTLayoutYAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeTop];
}

- (YJTLayoutYAxisAnchor *)bottomLayout {
    return [[YJTLayoutYAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeBottom];
}

- (YJTLayoutXAxisAnchor *)leadingLayout {
    return [[YJTLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeLeading];
}

- (YJTLayoutXAxisAnchor *)trailingLayout {
    return [[YJTLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeTrailing];
}

- (YJTLayoutDimension *)widthLayout {
    return [[YJTLayoutDimension alloc] initWithItem:self attribute:NSLayoutAttributeWidth];
}

- (YJTLayoutDimension *)heightLayout {
    return [[YJTLayoutDimension alloc] initWithItem:self attribute:NSLayoutAttributeHeight];
}

- (YJTLayoutXAxisAnchor *)centerXLayout {
    return [[YJTLayoutXAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeCenterX];
}

- (YJTLayoutYAxisAnchor *)centerYLayout {
    return [[YJTLayoutYAxisAnchor alloc] initWithItem:self attribute:NSLayoutAttributeCenterY];
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
