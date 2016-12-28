//
//  YJOtherViewController.m
//  YJUINavigationRouter
//
//  Created by admin on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJOtherViewController.h"
#import "YJRouteHeader.h"

@interface YJOtherViewController ()

@end

@implementation YJOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self openRouterURL:[NSString stringWithFormat:@"%@?name=阳君", YJRouterURLMain]];
}

@end
