//
//  YJTestTableViewCell2.m
//  YJTableView
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTestTableViewCell2.h"

@implementation YJTestTableViewCell2

+ (YJUITableViewCellCreate)cellCreate {
    return YJUITableViewCellCreateClass;
}

+ (CGFloat)tableViewManager:(YJUITableViewManager *)tableViewManager heightForCellObject:(YJUITableCellObject *)cellObject {
    return 2*cellObject.indexPath.row+40;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

- (void)reloadDataSyncWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager {
    [super reloadDataSyncWithCellObject:cellObject tableViewManager:tableViewManager];
    YJTestTableCellModel *celModel = cellObject.cellModel;
    self.label.text = celModel.userName;
}

@end
