//
//  UIViewController+YJTLayoutSupport.h
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTLayoutSupport.h"

NS_ASSUME_NONNULL_BEGIN

/** 仿UILayoutSupport扩展UIViewController*/
@interface UIViewController (YJTLayoutSupport)

@property (nonatomic, readonly) YJTLayoutSupport *topLayoutSupport NS_AVAILABLE_IOS(7_0); ///< 替代topLayoutGuide
@property (nonatomic, readonly) YJTLayoutSupport *bottomLayoutSupport NS_AVAILABLE_IOS(7_0); ///< 替代bottomLayoutGuide

@end

NS_ASSUME_NONNULL_END
