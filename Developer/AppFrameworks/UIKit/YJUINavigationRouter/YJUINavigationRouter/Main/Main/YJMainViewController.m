//
//  YJMainViewController.m
//  YJUINavigationRouter
//
//  Created by admin on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJMainViewController.h"
#import "YJRouteHeader.h"
#import "YJNSLog.h"

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
    NSLog(@"viewDidLoad--------%@", self);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear--------%@", self);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self openRouterURL:YJRouterURLOther options:@{@"1":@"3"}];
}

- (IBAction)onClickSend:(id)sender {
    NSLog(@"%@发送消息--------", self);
    [self sendSourceRouter:@"test" options:@{@"name": @"YJCocoa"}];
}

- (IBAction)onClickOnceJump:(id)sender {
    [self openRouterURL:YJRouterURLMain options:@{}];
}

#pragma mark - YJNSRouterDelegate
- (void)reloadRouterData {
    NSLog(@"reloadRouterData----%@:%@", self, self.router.sourceOptions);
}

- (BOOL)receiveTargetRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey,id> *)options sender:(YJNSRouter *)sender {
    if ([@"test" isEqualToString:fID]) {
        NSLog(@"%@处理消息----%@", self, options);
    }
    return [super receiveTargetRouter:fID options:options sender:sender]; // 不拦截，联动发送信息
}

@end
