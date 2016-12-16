//
//  YJTestTableViewCell.h
//  YJTTableView
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJUITableViewManager.h"
#import "YJTestTableCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJTestTableViewCell : YJUITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *sSwitch;

@end

NS_ASSUME_NONNULL_END
