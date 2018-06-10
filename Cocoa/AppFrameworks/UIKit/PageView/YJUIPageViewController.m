//
//  YJUIPageViewController.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/6/10.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import "YJUIPageViewController.h"

@interface YJUIPageViewController ()

@end

@implementation YJUIPageViewController

- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options {
    self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    if (self) {
        self.manager = [[YJUIPageViewManager alloc] initWithPageViewController:self];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.manager = [[YJUIPageViewManager alloc] initWithPageViewController:self];
}

- (void)reloadData {
    [self.manager reloadData];
}

#pragma mark - getter & setter
- (NSMutableArray<YJUIPageViewCellObject *> *)dataSourcePlain {
    return self.manager.dataSourcePlain;
}

- (void)setDataSourcePlain:(NSMutableArray<YJUIPageViewCellObject *> *)dataSourcePlain {
    self.manager.dataSourcePlain = dataSourcePlain;
}

@end
