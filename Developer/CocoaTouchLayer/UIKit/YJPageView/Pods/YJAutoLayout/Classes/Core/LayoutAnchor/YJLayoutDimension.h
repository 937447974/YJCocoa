//
//  YJLayoutDimension.h
//  YJAutoLayout
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJLayoutAnchor.h"

NS_ASSUME_NONNULL_BEGIN

// 相关block，链式执行
/** NSLayoutConstraint.relation = NSLayoutRelationLessThanOrEqual and .constant = constant*/
typedef NSLayoutConstraint * _Nonnull (^ LessThanOrEqualToConstant)(CGFloat constant);
/** NSLayoutConstraint.relation = NSLayoutRelationEqual and .constant = constant*/
typedef NSLayoutConstraint * _Nonnull (^ EqualToConstant)(CGFloat constant);
/** NSLayoutConstraint.relation = NSLayoutRelationGreaterThanOrEqual and .constant = constant*/
typedef NSLayoutConstraint * _Nonnull (^ GreaterThanOrEqualToConstant)(CGFloat constant);


/** YJLayoutDimension对应的协议*/
@protocol YJLayoutDimensionProtocol <YJLayoutAnchorProtocol>

// These methods return an inactive constraint of the form thisVariable = constant.
/** use .lessThanOrEqualToConstant(CGFloat)*/
@property (nonatomic, copy, readonly) LessThanOrEqualToConstant lessThanOrEqualToConstant;
/** use .equalToConstant(CGFloat)*/
@property (nonatomic, copy, readonly) EqualToConstant equalToConstant;
/** use .greaterThanOrEqualToConstant(CGFloat)*/
@property (nonatomic, copy, readonly) GreaterThanOrEqualToConstant greaterThanOrEqualToConstant;

@end

/** 仿NSLayoutDimension*/
@interface YJLayoutDimension : YJLayoutAnchor <YJLayoutDimensionProtocol>

@end

NS_ASSUME_NONNULL_END
