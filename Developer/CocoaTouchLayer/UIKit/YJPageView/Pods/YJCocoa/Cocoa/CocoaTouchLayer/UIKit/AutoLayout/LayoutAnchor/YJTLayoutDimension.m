//
//  YJTLayoutDimension.m
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTLayoutDimension.h"

@implementation YJTLayoutDimension

#pragma mark - getter
- (LessThanOrEqualToConstant)lessThanOrEqualToConstant {    
    __weak YJTLayoutAnchor *wSelf = self;
    LessThanOrEqualToConstant lessThanOrEqualToConstant = ^ (CGFloat constant) {
        return [NSLayoutConstraint constraintWithItem:wSelf.item attribute:wSelf.attribute lessThanOrEqualToConstant:constant];
    };
    return lessThanOrEqualToConstant;
}

- (EqualToConstant)equalToConstant {
    __weak YJTLayoutAnchor *wSelf = self;
    EqualToConstant equalToConstant = ^ (CGFloat constant) {
        return [NSLayoutConstraint constraintWithItem:wSelf.item attribute:wSelf.attribute equalToConstant:constant];
    };
    return equalToConstant;
}

- (GreaterThanOrEqualToConstant)greaterThanOrEqualToConstant {
    __weak YJTLayoutAnchor *wSelf = self;
    GreaterThanOrEqualToConstant greaterThanOrEqualToConstant = ^ (CGFloat constant) {
        return [NSLayoutConstraint constraintWithItem:wSelf.item attribute:wSelf.attribute greaterThanOrEqualToConstant:constant];
    };
    return greaterThanOrEqualToConstant;
}

- (Constraint)constraint {
    __weak YJTLayoutAnchor *wSelf = self;
    Constraint block = ^ () {
        return [NSLayoutConstraint findConstraintWithItem:wSelf.item attribute:wSelf.attribute toItem:nil attribute:NSLayoutAttributeNotAnAttribute];
    };
    return block;
}

@end
