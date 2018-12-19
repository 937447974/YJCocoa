//
//  YJUITableViewHeaderFooterView.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/7/18.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import "YJUITableViewHeaderFooterView.h"
#import "YJUITableViewManager.h"
#import "YJNSFoundationOther.h"

@implementation UITableViewHeaderFooterView (YJUITableView)

+ (CGFloat)tableViewManager:(YJUITableViewManager *)tableViewManager heightForCellObject:(YJUITableCellObject *)cellObject {
    switch (cellObject.createCell) {
        case YJUITableViewCellCreateClass:
            return tableViewManager.tableView.sectionHeaderHeight;
        case YJUITableViewCellCreateXib: {
            NSArray<UITableView *> *array = [[NSBundle mainBundle] loadNibNamed:cellObject.cellName owner:nil options:nil];
            return CGRectGetHeight(array.firstObject.frame);
        }
        case YJUITableViewCellCreateSoryboard: {
            UITableViewCell *cell = [tableViewManager.tableView dequeueReusableCellWithIdentifier:cellObject.cellName];
            return CGRectGetHeight(cell.frame);
        }
    }
}

@end

@implementation YJUITableViewHeaderFooterView

#pragma mark - getter & setter
- (NSString *)reuseIdentifier {
    NSString *reuseIdentifier = [super reuseIdentifier];
    if (reuseIdentifier) return reuseIdentifier;
    return YJNSStringFromClass(self.class);
}

#pragma mark - YJUITableView
+ (YJUITableViewCellCreate)cellCreate {
    return YJUITableViewCellCreateClass;
}

+ (CGFloat)tableViewManager:(YJUITableViewManager *)tableViewManager heightForCellObject:(YJUITableCellObject *)cellObject {
    if ([self.class isEqual:YJUITableViewHeaderFooterView.class]) {
        return 0;
    }
    return [super tableViewManager:tableViewManager heightForCellObject:cellObject];
}

- (void)reloadDataWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager {
    _cellObject = cellObject;
    _tableViewManager = tableViewManager;
}

@end
