//
//  YJUIPushPopVCTransitioning.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUIViewControllerAnimatedTransitioning.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJUIPushPopVCTransitioning : NSObject <UINavigationControllerDelegate>

@property (nonatomic, strong) YJUIViewControllerAnimatedTransitioning *pushAT;

@property (nonatomic, strong) YJUIViewControllerAnimatedTransitioning *popAT;
@property (nonatomic, weak) UIViewController *popVC;

@end

NS_ASSUME_NONNULL_END
