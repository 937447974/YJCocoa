//
//  YJMainViewController.m
//  YJUINavigationRouter
//
//  Created by admin on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJMainViewController.h"
#import "YJRouteHeader.h"

@interface YJMainViewController () <YJURLRouterProtocol>
@end

@implementation YJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YJMainViewController";
    YJLogDebug(@"初始化 YJMainViewController");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [YJURLRouter.shared openURLWithUrl:YJRouterURLOther options:@{@"1":@"阳君"} completion:nil];
}

#pragma mark - YJNSURLRouterProtocol
- (void)routerReloadDataWith:(NSDictionary<NSString *,id> *)options completion:(void (^)(NSDictionary<NSString *,id> * _Nonnull))handler {
    YJLogDebug(@"YJMainViewController 接收数据：%@", options);
}

@end
