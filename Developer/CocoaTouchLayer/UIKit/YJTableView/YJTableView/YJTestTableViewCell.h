//
//  YJTestTableViewCell.h
//  YJTableView
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTableView.h"

@interface YJTestTableCellModel : NSObject <YJTableCellModelProtocol>

@property (nonatomic, copy) NSString *userName; ///< 用户名
@property (nonatomic)       BOOL switchOn;      ///< 是否选中

@end


@interface YJTestTableCellObject : YJTableCellObject

@end


@interface YJTestTableViewCell : YJTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *sSwitch;

@end
