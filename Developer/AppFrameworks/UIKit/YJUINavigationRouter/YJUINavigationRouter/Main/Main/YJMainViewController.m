//
//  YJMainViewController.m
//  YJUINavigationRouter
//
//  Created by admin on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJMainViewController.h"
#import "YJRouteHeader.h"

@interface YJMainViewController () <YJNSRouterDelegate>

@end

@implementation YJMainViewController

- (instancetype)initWithRouterURL:(YJNSRouterURL)routerURL {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"YJMainViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    NSLog(@"%@", self);
    NSLog(@"%@发送消息--------", self);
    [self sendSourceRouter:@"test" options:@{@"name":@"YJCocoa"}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self openRouterURL:@"2" options:@{@"1":@"3"}];
    [self openRouterURL:YJRouterURLOther options:@{@"1":@"3"}];
}

#pragma mark - YJNSRouterDelegate
- (BOOL)receiveTargetRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey,id> *)options sender:(YJNSRouter *)sender {
    if ([@"test" isEqualToString:fID]) {
        NSLog(@"%@处理消息-%@", self, options);
    }
    return NO; // 不拦截，联动发送信息
}

@end
