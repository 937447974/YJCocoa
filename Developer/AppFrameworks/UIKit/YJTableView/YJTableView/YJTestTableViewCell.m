//
//  YJTestTableViewCell.m
//  YJUITableView
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTestTableViewCell.h"

@implementation YJTestTableCellModel

@end

@implementation YJTestTableCellObject

@end

@implementation YJTestTableViewCell

+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJUITableCellObject *)cellObject {
    return 2*cellObject.indexPath.row+40;
}

- (void)reloadDataSyncWithCellObject:(YJUITableCellObject *)cellObject tableViewDelegate:(YJUITableViewDelegate *)tableViewDelegate {
    [super reloadDataSyncWithCellObject:cellObject tableViewDelegate:tableViewDelegate];
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

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)onClick:(id)sender {
    self.tag = 1;
    YJTestTableCellModel *celModel = self.cellObject.cellModel;
    celModel.switchOn = self.sSwitch.on;
    [self.tableViewDelegate sendVCWithCellObject:self.cellObject tableViewCell:self];
}

@end
