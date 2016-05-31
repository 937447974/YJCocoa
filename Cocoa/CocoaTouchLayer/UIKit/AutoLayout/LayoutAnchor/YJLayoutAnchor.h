//
//  YJLayoutAnchor.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSLayoutConstraint+YJExtend.h"

NS_ASSUME_NONNULL_BEGIN

@class YJLayoutAnchor;

// 相关block，链式执行
/** NSLayoutConstraint.relation = NSLayoutRelationLessThanOrEqual*/
typedef NSLayoutConstraint * _Nonnull (^ LessThanOrEqualTo)(YJLayoutAnchor *anchor);
/** NSLayoutConstraint.relation = NSLayoutRelationEqual*/
typedef NSLayoutConstraint * _Nonnull (^ EqualTo)(YJLayoutAnchor *anchor);
/** NSLayoutConstraint.relation = NSLayoutRelationGreaterThanOrEqual*/
typedef NSLayoutConstraint * _Nonnull (^ GreaterThanOrEqualTo)(YJLayoutAnchor *anchor);
/** 快速查询约束*/
typedef NSLayoutConstraint * __nullable (^ ConstraintTo)(YJLayoutAnchor *anchor);


/** YJLayoutAnchor对应的协议*/
@protocol YJLayoutAnchorProtocol <NSObject>

/** use .lessThanOrEqualTo(YJLayoutAnchor)*/
@property (nonatomic, copy, readonly) LessThanOrEqualTo lessThanOrEqualTo;
/** use .equalTo(YJLayoutAnchor)*/
@property (nonatomic, copy, readonly) EqualTo equalTo;
/** use .greaterThanOrEqualTo(YJLayoutAnchor)*/
@property (nonatomic, copy, readonly) GreaterThanOrEqualTo greaterThanOrEqualTo;
/** use .costraintTo(YJLayoutAnchor)*/
@property (nonatomic, copy, readonly) ConstraintTo costraintTo;

@end


/** 仿NSLayoutAnchor*/
@interface YJLayoutAnchor : NSObject <YJLayoutAnchorProtocol>

@property (nonatomic, weak, readonly, nullable) id item;
@property (nonatomic, readonly) NSLayoutAttribute attribute;

- (instancetype)initWithItem:(id)item attribute:(NSLayoutAttribute)attribute;

@end

NS_ASSUME_NONNULL_END
