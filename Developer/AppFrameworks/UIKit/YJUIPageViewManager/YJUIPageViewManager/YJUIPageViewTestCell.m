//
//  YJUIPageViewTestCell.m
//  YJUIPageViewManager
//
//  Created by admin on 2017/5/4.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJUIPageViewTestCell.h"

@interface YJUIPageViewTestCell ()

@end

@implementation YJUIPageViewTestCell

- (void)reloadDataWithPageViewCellObject:(YJUIPageViewCellObject *)cellObject pageViewManager:(YJUIPageViewManager *)pageViewManager {
    [super reloadDataWithPageViewCellObject:cellObject pageViewManager:pageViewManager];
    if (cellObject.pageIndex % 2) {
        self.view.backgroundColor = [UIColor redColor];
    } else {
        self.view.backgroundColor = [UIColor greenColor];
    }
}

@end
