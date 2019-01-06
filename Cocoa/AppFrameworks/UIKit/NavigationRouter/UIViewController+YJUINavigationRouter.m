//
//  UIViewController+YJUINavigationRouter.m
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "UIViewController+YJUINavigationRouter.h"

@implementation UIViewController (YJUINavigationRouter)

#pragma mark - YJNSURLRouterProtocol
+ (instancetype)routerWithURL:(NSString *)url {
    UIViewController *vc = self.new;
    vc.view.backgroundColor = UIColor.whiteColor;
    return vc;
}

- (void)routerOpen {
    UIViewController *vc = UIApplication.sharedApplication.keyWindow.rootViewController;
    UINavigationController *nc = [vc isKindOfClass:[UINavigationController class]] ? (UINavigationController *)vc : vc.navigationController;
    [nc pushViewController:self animated:YES];
}

@end
