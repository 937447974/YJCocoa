//
//  NSLayoutConstraint+YJExtend.m
//  YJAutoLayout
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "NSLayoutConstraint+YJExtend.h"

@implementation NSLayoutConstraint (YJExtend)

#pragma mark - (+)
#pragma mark 搜索NSLayoutConstraint
+ (nullable instancetype)findConstraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 {
    
    UIView *superView = [self findRootView:view1 toItem:view2];
    return [self findConstraintWithView:superView Item:view1 attribute:attr1 toItem:view2 attribute:attr2];
    
}

#pragma mark NSLayoutRelationEqual
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 equalToConstant:(CGFloat)c {
    
    return [self constraintWithItem:view1 attribute:attr1 equalToItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:c];
    
}

+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 equalToItem:(id)view2 attribute:(NSLayoutAttribute)attr2 {
    
    return [self constraintWithItem:view1 attribute:attr1 equalToItem:view2 attribute:attr2 multiplier:1 constant:0];
    
}

+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 equalToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c {
    
    return [self constraintWithItem:view1 attribute:attr1 equalToItem:view2 attribute:attr2 multiplier:1 constant:c];
    
}

+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 equalToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c {
    
    return [self constraintWithItem:view1 attribute:attr1 relationBy:NSLayoutRelationEqual toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
    
}

#pragma mark NSLayoutRelationLessThanOrEqual
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 lessThanOrEqualToConstant:(CGFloat)c {
    
    return [self constraintWithItem:view1 attribute:attr1 lessThanOrEqualToItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:c];
    
}

+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 lessThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 {
    
    return [self constraintWithItem:view1 attribute:attr1 lessThanOrEqualToItem:view2 attribute:attr2 multiplier:1 constant:0];
    
}

+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 lessThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c {
    
    return [self constraintWithItem:view1 attribute:attr1 lessThanOrEqualToItem:view2 attribute:attr2 multiplier:1 constant:c];
    
}

+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 lessThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c {
    
    return [self constraintWithItem:view1 attribute:attr1 relationBy:NSLayoutRelationLessThanOrEqual toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
    
}

#pragma mark NSLayoutRelationGreaterThanOrEqual
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 greaterThanOrEqualToConstant:(CGFloat)c {
    
    return [self constraintWithItem:view1 attribute:attr1 greaterThanOrEqualToItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:c];
    
}

+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 greaterThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 {
    
    return [self constraintWithItem:view1 attribute:attr1 greaterThanOrEqualToItem:view2 attribute:attr2 multiplier:1 constant:0];
    
}

+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 greaterThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c {
    
    return [self constraintWithItem:view1 attribute:attr1 greaterThanOrEqualToItem:view2 attribute:attr2 multiplier:1 constant:c];
    
}

+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 greaterThanOrEqualToItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c{
    
    return [self constraintWithItem:view1 attribute:attr1 relationBy:NSLayoutRelationGreaterThanOrEqual toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
    
}

#pragma mark base
// 生产NSLayoutConstraint
+ (instancetype)constraintWithItem:(id)view1 attribute:(NSLayoutAttribute)attr1 relationBy:(NSLayoutRelation)relation toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c {
    
    UIView *viewTemp1 = (UIView *)view1;
    UIView *viewTemp2 = (UIView *)view2;
    UIView *superView = [self findRootView:viewTemp1 toItem:viewTemp2];
    NSLayoutConstraint *lc = [self findConstraintWithView:superView Item:view1 attribute:attr1 toItem:view2 attribute:attr2];
    if (!lc) { // 首次创建
        viewTemp1.translatesAutoresizingMaskIntoConstraints = NO;
        viewTemp2.translatesAutoresizingMaskIntoConstraints = NO;
        lc = [self constraintWithItem:view1 attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];
        if ([lc respondsToSelector:@selector(setActive:)]) { // IOS8才支持active属性
            [lc setActive:YES];
        } else { // IOS8以下添加到相同父节点
            [superView addConstraint:lc];
        }
    }
    return lc;
    
}

// 从view中搜索NSLayoutConstraint
+ (nullable instancetype)findConstraintWithView:(UIView *)view Item:(id)view1 attribute:(NSLayoutAttribute)attr1 toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 {
    
    if (view2) {
        for (NSLayoutConstraint *c in view.constraints) {
            if (c.firstAttribute == attr1 && c.secondAttribute == attr2 && [c.firstItem isEqual:view1] && [c.secondItem isEqual:view2]) {
                return c;
            }
        }
    } else {
        for (NSLayoutConstraint *c in view.constraints) {
            if (c.firstAttribute == attr1 && [c.firstItem isEqual:view1]) {
                return c;
            }
        }
    }
    return nil;
    
}

// 寻找两个view的共同父节点
+ (UIView *)findRootView:(UIView *)view1 toItem:(nullable UIView *)view2 {
    
    // 算法运行时间O(n)
    if (view2 == nil) {
        return view1;
    }
    // 添加数据源
    NSMutableArray<UIView *> *superviews1 = [NSMutableArray array];
    NSMutableArray<UIView *> *superviews2 = [NSMutableArray array];
    while (view1) {
        [superviews1 addObject:view1];
        view1 = view1.superview;
    }
    while (view2) {
        [superviews2 addObject:view2];
        view2 = view2.superview;
    }
    // 去掉多余header
    NSInteger length = superviews1.count - superviews2.count;
    if (length > 0) {
        [superviews1 removeObjectsInRange:NSMakeRange(0, length)];
    } else if (length < 0) {
        [superviews2 removeObjectsInRange:NSMakeRange(0, -length)];
    }
    // 搜索共同父类
    for (int i = 0; i < superviews1.count; i++) {
        view1 = superviews1[i];
        if ([view1 isEqual:superviews2[i]]) {
            return view1;
        }
    }
    return view1;
    
}

#pragma mark - getter
- (Constant)constants {
    
    __weak NSLayoutConstraint *lcWeak = self;
    Constant constants = ^(CGFloat constant) {
        lcWeak.constant = constant;
        return lcWeak;
    };
    return constants;
    
}

- (Multiplier)multipliers {
    
    __block __weak NSLayoutConstraint *lcWeak = self;
    Multiplier multipliers = ^(CGFloat multiplier) {
        UIView *viewTemp1 = (UIView *)lcWeak.firstItem;
        UIView *viewTemp2 = (UIView *)lcWeak.secondItem;
        UIView *superView = [NSLayoutConstraint findRootView:viewTemp1 toItem:viewTemp2];
        [superView removeConstraint:lcWeak];
        lcWeak = [NSLayoutConstraint constraintWithItem:lcWeak.firstItem attribute:lcWeak.firstAttribute relatedBy:lcWeak.relation toItem:lcWeak.secondItem attribute:lcWeak.secondAttribute multiplier:multiplier constant:lcWeak.constant];
        if ([lcWeak respondsToSelector:@selector(setActive:)]) { // IOS8才支持active属性
            [lcWeak setActive:YES];
        } else { // IOS8以下添加到相同父节点
            [superView addConstraint:lcWeak];
        }
        return lcWeak;
    };
    return multipliers;
    
}

@end
