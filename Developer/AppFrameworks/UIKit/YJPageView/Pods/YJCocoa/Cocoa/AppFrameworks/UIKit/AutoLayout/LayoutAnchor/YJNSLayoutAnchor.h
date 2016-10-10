//
//  YJNSLayoutAnchor.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSLayoutConstraint+YJAutoLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class YJNSLayoutAnchor;

// 相关block，链式执行
/** NSLayoutConstraint.relation = NSLayoutRelationLessThanOrEqual*/
typedef NSLayoutConstraint * _Nonnull (^ LessThanOrEqualTo)(YJNSLayoutAnchor *anchor);
/** NSLayoutConstraint.relation = NSLayoutRelationEqual*/
typedef NSLayoutConstraint * _Nonnull (^ EqualTo)(YJNSLayoutAnchor *anchor);
/** NSLayoutConstraint.relation = NSLayoutRelationGreaterThanOrEqual*/
typedef NSLayoutConstraint * _Nonnull (^ GreaterThanOrEqualTo)(YJNSLayoutAnchor *anchor);
/** 快速查询约束*/
typedef NSLayoutConstraint * __nullable (^ ConstraintTo)(YJNSLayoutAnchor *anchor);


/** YJNSLayoutAnchor对应的协议*/
@protocol YJNSLayoutAnchorProtocol <NSObject>

/** use .lessThanOrEqualTo(YJNSLayoutAnchor)*/
@property (nonatomic, copy, readonly) LessThanOrEqualTo lessThanOrEqualTo;
/** use .equalTo(YJNSLayoutAnchor)*/
@property (nonatomic, copy, readonly) EqualTo equalTo;
/** use .greaterThanOrEqualTo(YJNSLayoutAnchor)*/
@property (nonatomic, copy, readonly) GreaterThanOrEqualTo greaterThanOrEqualTo;
/** use .costraintTo(YJNSLayoutAnchor)*/
@property (nonatomic, copy, readonly) ConstraintTo costraintTo;

@end


/** 仿NSLayoutAnchor*/
@interface YJNSLayoutAnchor : NSObject <YJNSLayoutAnchorProtocol>

@property (nonatomic, weak, readonly, nullable) id item;
@property (nonatomic, readonly) NSLayoutAttribute attribute;

- (instancetype)initWithItem:(id)item attribute:(NSLayoutAttribute)attribute;

@end

NS_ASSUME_NONNULL_END
