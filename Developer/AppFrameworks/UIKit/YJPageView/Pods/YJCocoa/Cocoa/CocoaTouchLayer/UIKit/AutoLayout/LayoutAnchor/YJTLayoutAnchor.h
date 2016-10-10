//
//  YJTLayoutAnchor.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSLayoutConstraint+YJTExtend.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTLayoutAnchor;

// 相关block，链式执行
/** NSLayoutConstraint.relation = NSLayoutRelationLessThanOrEqual*/
typedef NSLayoutConstraint * _Nonnull (^ LessThanOrEqualTo)(YJTLayoutAnchor *anchor);
/** NSLayoutConstraint.relation = NSLayoutRelationEqual*/
typedef NSLayoutConstraint * _Nonnull (^ EqualTo)(YJTLayoutAnchor *anchor);
/** NSLayoutConstraint.relation = NSLayoutRelationGreaterThanOrEqual*/
typedef NSLayoutConstraint * _Nonnull (^ GreaterThanOrEqualTo)(YJTLayoutAnchor *anchor);
/** 快速查询约束*/
typedef NSLayoutConstraint * __nullable (^ ConstraintTo)(YJTLayoutAnchor *anchor);


/** YJTLayoutAnchor对应的协议*/
@protocol YJTLayoutAnchorProtocol <NSObject>

/** use .lessThanOrEqualTo(YJTLayoutAnchor)*/
@property (nonatomic, copy, readonly) LessThanOrEqualTo lessThanOrEqualTo;
/** use .equalTo(YJTLayoutAnchor)*/
@property (nonatomic, copy, readonly) EqualTo equalTo;
/** use .greaterThanOrEqualTo(YJTLayoutAnchor)*/
@property (nonatomic, copy, readonly) GreaterThanOrEqualTo greaterThanOrEqualTo;
/** use .costraintTo(YJTLayoutAnchor)*/
@property (nonatomic, copy, readonly) ConstraintTo costraintTo;

@end


/** 仿NSLayoutAnchor*/
@interface YJTLayoutAnchor : NSObject <YJTLayoutAnchorProtocol>

@property (nonatomic, weak, readonly, nullable) id item;
@property (nonatomic, readonly) NSLayoutAttribute attribute;

- (instancetype)initWithItem:(id)item attribute:(NSLayoutAttribute)attribute;

@end

NS_ASSUME_NONNULL_END
