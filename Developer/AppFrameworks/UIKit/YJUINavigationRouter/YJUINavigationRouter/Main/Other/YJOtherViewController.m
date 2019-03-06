//
//  YJOtherViewController.m
//  YJUINavigationRouter
//
//  Created by admin on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJOtherViewController.h"
#import "YJRouteHeader.h"

@interface YJOtherViewController () <YJNSURLRouterProtocol>

@end

@implementation YJOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [YJNSURLRouterS openURL:YJRouterURLMain options:@{@"name":@"阳君"}completionHandler:^(NSDictionary *options) {
        NSLog(@"接受数据%@", options);
    }];
}

#pragma mark - YJNSURLRouter
YJNSURLROUTER_LOAD(^{
    [YJNSURLRouterS registerRouter:[[YJNSRouterRegister alloc] initWithURL:YJRouterURLOther handler:^(NSString *url, NSDictionary *options, YJRCompletionHandler handler) {
        [YJOtherViewController.new routerOpen];
    }]];
})

@end
