//
//  YJTestTableViewCell.h
//  YJTTableView
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJUITableView.h"

@interface YJTestTableCellModel : NSObject <YJUITableCellModelProtocol>

@property (nonatomic, copy) NSString *userName; ///< 用户名
@property (nonatomic)       BOOL switchOn;      ///< 是否选中

@end


@interface YJTestTableViewCell : YJUITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *sSwitch;

@end
