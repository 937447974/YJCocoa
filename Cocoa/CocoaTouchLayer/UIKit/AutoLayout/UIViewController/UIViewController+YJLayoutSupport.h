//
//  UIViewController+YJLayoutSupport.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJLayoutSupport.h"

NS_ASSUME_NONNULL_BEGIN

/** 仿UILayoutSupport扩展UIViewController*/
@interface UIViewController (YJLayoutSupport)

@property (nonatomic, readonly) YJLayoutSupport *topLayoutSupport NS_AVAILABLE_IOS(7_0); ///< 替代topLayoutGuide
@property (nonatomic, readonly) YJLayoutSupport *bottomLayoutSupport NS_AVAILABLE_IOS(7_0); ///< 替代bottomLayoutGuide

@end

NS_ASSUME_NONNULL_END
