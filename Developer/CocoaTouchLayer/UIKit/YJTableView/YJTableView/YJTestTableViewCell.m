//
//  YJTestTableViewCell.m
//  YJTableView
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

- (void)reloadDataSyncWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate {
    [super reloadDataSyncWithCellObject:cellObject tableViewDelegate:tableViewDelegate];
    YJTestTableCellModel *celModel = cellObject.cellModel;
    self.label.text = celModel.userName;
    self.sSwitch.on = celModel.switchOn;
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
