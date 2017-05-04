//
//  YJUIPageViewTestCell2.m
//  YJUIPageViewManager
//
//  Created by admin on 2017/5/4.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJUIPageViewTestCell2.h"

@interface YJUIPageViewTestCell2 ()

@end

@implementation YJUIPageViewTestCell2

- (void)reloadDataWithPageViewCellObject:(YJUIPageViewCellObject *)cellObject pageViewManager:(YJUIPageViewManager *)pageViewManager {
    [super reloadDataWithPageViewCellObject:cellObject pageViewManager:pageViewManager];
    if (cellObject.pageIndex % 2) {
        self.view.backgroundColor = [UIColor redColor];
    } else {
        self.view.backgroundColor = [UIColor greenColor];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%ld", self.cellObject.pageIndex);
}

@end
