//
//  YJNSLayoutDimension.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSLayoutAnchor.h"

NS_ASSUME_NONNULL_BEGIN

// 相关block，链式执行
/** NSLayoutConstraint.relation = NSLayoutRelationLessThanOrEqual and .constant = constant*/
typedef NSLayoutConstraint * _Nonnull (^ LessThanOrEqualToConstant)(CGFloat constant);
/** NSLayoutConstraint.relation = NSLayoutRelationEqual and .constant = constant*/
typedef NSLayoutConstraint * _Nonnull (^ EqualToConstant)(CGFloat constant);
/** NSLayoutConstraint.relation = NSLayoutRelationGreaterThanOrEqual and .constant = constant*/
typedef NSLayoutConstraint * _Nonnull (^ GreaterThanOrEqualToConstant)(CGFloat constant);
/** 快速查询约束*/
typedef NSLayoutConstraint * __nullable (^ Constraint)();

/** YJNSLayoutDimension对应的协议*/
@protocol YJNSLayoutDimensionProtocol <YJNSLayoutAnchorProtocol>

// These methods return an inactive constraint of the form thisVariable = constant.
/** use .lessThanOrEqualToConstant(CGFloat)*/
@property (nonatomic, copy, readonly) LessThanOrEqualToConstant lessThanOrEqualToConstant;
/** use .equalToConstant(CGFloat)*/
@property (nonatomic, copy, readonly) EqualToConstant equalToConstant;
/** use .greaterThanOrEqualToConstant(CGFloat)*/
@property (nonatomic, copy, readonly) GreaterThanOrEqualToConstant greaterThanOrEqualToConstant;
/** use .constraint()*/
@property (nonatomic, copy, readonly) Constraint constraint;

@end


/** 仿NSLayoutDimension*/
@interface YJNSLayoutDimension : YJNSLayoutAnchor <YJNSLayoutDimensionProtocol>

@end

NS_ASSUME_NONNULL_END
