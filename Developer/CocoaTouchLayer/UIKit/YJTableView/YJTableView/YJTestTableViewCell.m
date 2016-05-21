//
//  YJTestTableViewCell.m
//  YJTableView
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTestTableViewCell.h"

@implementation YJTestTableViewCell

- (void)reloadCellWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate {
    
    YJTableViewCellModel *celModel = cellObject.cellModel;
    self.label.text = celModel.userName;
    
}

@end
