//
//  YJTestTableViewCell.h
//  YJTTableView
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTTableView.h"

@interface YJTestTableCellModel : NSObject <YJTTableCellModelProtocol>

@property (nonatomic, copy) NSString *userName; ///< 用户名
@property (nonatomic)       BOOL switchOn;      ///< 是否选中

@end


@interface YJTestTableCellObject : YJTTableCellObject

@end


@interface YJTestTableViewCell : YJTTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *sSwitch;

@end
