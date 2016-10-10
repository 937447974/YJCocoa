//
//  UIView+YJTViewLayoutConstraintCreation.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTLayoutDimension.h"
#import "YJTLayoutXAxisAnchor.h"
#import "YJTLayoutYAxisAnchor.h"

NS_ASSUME_NONNULL_BEGIN
/** 到superview的距离约束*/
typedef UIView __kindof * _Nonnull (^ SpaceToSuper)(CGFloat constant);
/** 组合布局*/
typedef void (^ CombinativeLayout)(UIView *view);


/** 仿UIViewLayoutConstraintCreation扩展UIView*/
@interface UIView (YJTViewLayoutConstraintCreation)

@property (nonatomic, readonly) YJTLayoutXAxisAnchor *leftLayout;     ///< 替换leftAnchor
@property (nonatomic, readonly) YJTLayoutXAxisAnchor *rightLayout;    ///< 替换rightAnchor
@property (nonatomic, readonly) YJTLayoutYAxisAnchor *topLayout;      ///< 替换topAnchor
@property (nonatomic, readonly) YJTLayoutYAxisAnchor *bottomLayout;   ///< 替换bottomAnchor
@property (nonatomic, readonly) YJTLayoutXAxisAnchor *leadingLayout;  ///< 替换leadingAnchor
@property (nonatomic, readonly) YJTLayoutXAxisAnchor *trailingLayout; ///< 替换trailingAnchor
@property (nonatomic, readonly) YJTLayoutDimension *widthLayout;      ///< 替换widthAnchor
@property (nonatomic, readonly) YJTLayoutDimension *heightLayout;     ///< 替换heightAnchor
@property (nonatomic, readonly) YJTLayoutXAxisAnchor *centerXLayout;  ///< 替换centerXAnchor
@property (nonatomic, readonly) YJTLayoutYAxisAnchor *centerYLayout;  ///< 替换centerYAnchor

#pragma mark - ToSuper
// 需先添加到superview，约束才能生效
@property (nonatomic, readonly) SpaceToSuper topSpaceToSuper;      ///< use .topSpaceToSuper(CGFloat)
@property (nonatomic, readonly) SpaceToSuper bottomSpaceToSuper;   ///< use .bottomSpaceToSuper(CGFloat)
@property (nonatomic, readonly) SpaceToSuper leadingSpaceToSuper;  ///< use .leadingSpaceToSuper(CGFloat)
@property (nonatomic, readonly) SpaceToSuper trailingSpaceToSuper; ///< use .trailingToSuper(CGFloat)
// 到superview的约束查找
@property (nonatomic, readonly) Constraint topConstraintToSuper;      ///< use .topConstraintToSuper()
@property (nonatomic, readonly) Constraint bottomConstraintToSuper;   ///< use .bottomConstraintToSuper()
@property (nonatomic, readonly) Constraint leadingConstraintToSuper;  ///< use .leadingConstraintToSuper()
@property (nonatomic, readonly) Constraint trailingConstraintToSuper; ///< use .trailingConstraintToSuper()

#pragma mark - CombinativeLayout
@property (nonatomic, readonly) CombinativeLayout sizeLayoutTo;   ///< 等宽高 use .sizeLayoutTo(UIView)
@property (nonatomic, readonly) CombinativeLayout centerLayoutTo; ///< 中心点对齐 use .centerLayoutTo(UIView)
@property (nonatomic, readonly) CombinativeLayout boundsLayoutTo; ///< 等宽高+中心点对齐 use .boundsLayoutTo(UIView)

@end

NS_ASSUME_NONNULL_END
