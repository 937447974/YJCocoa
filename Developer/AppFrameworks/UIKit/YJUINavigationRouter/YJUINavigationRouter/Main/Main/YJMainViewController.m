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

@property (nonatomic, copy) YJRCompletionHandler completionHandler;

@end

@implementation YJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    NSLog(@"viewDidLoad--------%@", self);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [YJNSURLRouterS openURL:YJRouterURLOther options:@{@"1":@"3"} completionHandler:nil];
}

- (IBAction)onClickSend:(id)sender {
    !self.completionHandler?:self.completionHandler(@{@"name": @"YJCocoa"});
}

- (IBAction)onClickOnceJump:(id)sender {
    [YJNSURLRouterS openURL:@"https://github.com/937447974/YJCocoa" options:nil completionHandler:nil];
}

#pragma mark - YJNSURLRouterProtocol
+ (void)routerLoad {
    [YJNSURLRouterS registerRouter:[[YJNSRouterRegister alloc] initWithURL:YJRouterURLMain cache:YES cls:self]];
}

+ (instancetype)routerWithURL:(NSString *)url {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:@"YJMainViewController"];
}

- (void)routerReloadDataWithOptions:(NSDictionary *)options completionHandler:(YJRCompletionHandler)completionHandler {
    self.completionHandler = completionHandler;
}

@end
