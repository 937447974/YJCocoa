//
//  YJLayoutConstraintAnimate.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/30.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 约束动画携带的参数*/
@interface YJLayoutConstraintAnimate : NSObject

@property (nonatomic) CGFloat toConstant;           ///< 目标值
@property (nonatomic) CGFloat intervalConstant;     ///< 每一次变化值
@property (nonatomic) NSTimeInterval intervalDelay; ///< 变化时间间隔

@end

NS_ASSUME_NONNULL_END
