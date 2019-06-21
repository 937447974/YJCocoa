//
//  YJOtherViewController.m
//  YJUINavigationRouter
//
//  Created by admin on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJOtherViewController.h"
#import "YJRouteHeader.h"

@interface YJOtherViewController () <YJURLRouterProtocol>

@end

@implementation YJOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor greenColor];
    @weakSelf
    YJUIBarButtonItem *backItem = [[YJUIBarButtonItem alloc] initWithTouchUpInside:^(UIButton *button) {
        @strongSelf
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [backItem.button setImage:[UIImage imageNamed:@"nav_back"] highlightedImage:nil];
    self.navigationItem.leftBarButtonItem = [backItem buildBackBarButtonItem];
    YJUIBarButtonItem *rightItem = [[YJUIBarButtonItem alloc] initWithTouchUpInside:^(UIButton *button) {
        [YJURLRouter.shared openURLWithUrl:@"/main?1=3" options:@{@"name":@"阳君"} completion:^(NSDictionary<NSString *,id> * options) {
            YJLogDebug(@"接收回调数据：%@", options);
        }];
    }];
    [rightItem setTitle:@"跳转" font:nil color:nil highlightedColor:nil];
    self.navigationItem.rightBarButtonItem = [rightItem buildBackBarButtonItem];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [YJURLRouter.shared openURLWithUrl:@"https://www.baidu.com/s?wd=swift&rsv_spt=1&issp=1&f=8&rsv_bp=1&rsv_idx=2&ie=utf-8&tn=baiduhome_pg" options:@{@"name":@"阳君"} completion:^(NSDictionary<NSString *,id> * options) {
        NSLog(@"接受数据%@", options);
    }];
    
}

#pragma mark - YJNSURLRouter
- (void)routerReloadDataWith:(NSDictionary<NSString *,id> *)options completion:(void (^)(NSDictionary<NSString *,id> * _Nonnull))handler {
    YJLogDebug(@"YJOtherViewController 接收数据：%@", options);
    if (handler != nil) {
        handler(@{@"回调数据":@"操作完成"});
    }
}


@end
