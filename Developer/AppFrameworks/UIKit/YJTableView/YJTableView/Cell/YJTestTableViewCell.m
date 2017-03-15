//
//  YJTestTableViewCell.m
//  YJUITableView
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTestTableViewCell.h"

@implementation YJTestTableViewCell

+ (YJUITableViewCellCreate)cellCreate {
    return YJUITableViewCellCreateXib;
}

+ (CGFloat)tableViewManager:(YJUITableViewManager *)tableViewManager heightForCellObject:(YJUITableCellObject *)cellObject {
    CGFloat height = 2*cellObject.indexPath.row+40;
    return height <= 200 ? height : 200;
}

- (void)reloadDataSyncWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager {
    [super reloadDataSyncWithCellObject:cellObject tableViewManager:tableViewManager];
    YJTestTableCellModel *celModel = cellObject.cellModel;
    self.label.text = celModel.userName;
    self.sSwitch.on = celModel.switchOn;
    switch (cellObject.indexPath.row%3) {
        case 0:
            self.backgroundColor = [UIColor greenColor];
            break;
        case 1:
            self.backgroundColor = [UIColor yellowColor];
            break;
        case 2:
            self.backgroundColor = [UIColor redColor];
            break;
    }
}

- (IBAction)onClick:(id)sender {
    self.tag = 1;
    YJTestTableCellModel *celModel = self.cellObject.cellModel;
    celModel.switchOn = self.sSwitch.on;
    [self.tableViewManager.delegate tableViewCell:self sendWithCellObject:self.cellObject];
}

@end
