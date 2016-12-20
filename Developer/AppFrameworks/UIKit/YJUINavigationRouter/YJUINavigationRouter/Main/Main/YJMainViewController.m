//
//  YJMainViewController.m
//  YJUINavigationRouter
//
//  Created by admin on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJMainViewController.h"
#import "YJRouteHeader.h"

@interface YJMainViewController ()

@end

@implementation YJMainViewController

- (instancetype)initWithRouterURL:(YJNSRouterURL)routerURL {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"YJMainViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    YJNSRouter *router = self.router;
    router.completionHandler = ^ BOOL(YJNSRouterFoundationID fID, NSDictionary<YJNSRouterOptionsKey, id> *options, YJNSRouter *sender) {
        if ([@"test" isEqualToString:fID]) {
            NSLog(@"%@", options);
        }
        return NO; // 不拦截，联动发送信息
    };
    [self sendSourceRouter:@"test" options:@{@"name":@"阳君"}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self openRouterURL:YJRouterURLOther options:@{} completionHandler:nil];
}

@end
