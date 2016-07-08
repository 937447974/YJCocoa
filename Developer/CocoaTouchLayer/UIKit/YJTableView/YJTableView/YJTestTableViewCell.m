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
    YJTestTableCellModel *celModel = cellObject.cellModel;
    self.label.text = celModel.userName;
}

- (IBAction)onClick:(id)sender {

    self.tag = 1;
    [self.tableViewDelegate sendVCWithCellObject:self.cellObject tableViewCell:self];
    
}

@end
