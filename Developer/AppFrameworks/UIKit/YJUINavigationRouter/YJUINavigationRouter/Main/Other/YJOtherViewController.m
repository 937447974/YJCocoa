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
    NSLog(@"%@", self);
}

- (void)dealloc {
    NSLog(@"%@-%@", NSStringFromSelector(_cmd), self);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [YJNSURLRouterS openURL:YJRouterURLMain options:@{@"name":@"阳君"} completionHandler:^{
        NSLog(@"打开 YJRouterURLMain completionHandler");
    }];
}

#pragma mark - YJNSURLRouterProtocol
+ (void)loadRouter {
    YJNSRouterNodeConfig *config = [[YJNSRouterNodeConfig alloc] initWithRouterURL:YJRouterURLOther handler:^id<YJNSURLRouterProtocol>(NSDictionary *options, dispatch_block_t completion) {
        YJOtherViewController *vc = YJOtherViewController.new;
        vc.view.backgroundColor = UIColor.whiteColor;
        [vc openRouterCompletionHandler:completion];
        !completion?:completion();
        return vc;
    }];
    [YJNSURLRouterS registerNodeConfig:config];
}

- (BOOL)receiveRouterData:(YJNSRouterDataID)dID options:(NSDictionary *)options {
    if ([dID isEqualToString:@"test"]) {
        NSLog(@"接受数据%@", options);
        return YES;
    }
    return NO;
}

@end
