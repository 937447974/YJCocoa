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
#import "YJNSHttp.h"

@interface YJMainViewController () <YJNSURLRouterProtocol>

@end

@implementation YJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    NSLog(@"viewDidLoad--------%@", self);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *url = [YJNSHttpAssembly assemblyHttpEncode:YJRouterURLOther params:@{@"1":@"3"}];
    [YJNSURLRouterS openURL:url];
}

- (IBAction)onClickSend:(id)sender {
    NSLog(@"%@发送消息--------", self);
    [YJNSURLRouterS sendData:@"test" options:@{@"name": @"YJCocoa"}];
}

- (IBAction)onClickOnceJump:(id)sender {
    [YJNSURLRouterS openURL:@"https://github.com/937447974/YJCocoa"];
}

#pragma mark - YJNSURLRouterProtocol
+ (void)loadRouter {
    [YJNSURLRouterS registerNodeConfig:[[YJNSRouterNodeConfig alloc] initWithRouterURL:YJRouterURLMain cache:YES cls:self]];
}

+ (instancetype)newWithRouterURL:(YJNSRouterURL)url {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"YJMainViewController"];
}

- (void)reloadDataWithRouterOptions:(NSDictionary *)options {
    NSLog(@"%@ %@", self, options);
}

@end
