//
//  YJTestTableViewCell.h
//  YJTableView
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTableViewCell.m"

@interface YJTableViewCellModel : NSObject <YJTableCellModelProtocol>

@property (nonatomic, copy) NSString *userName; ///< 用户名

@end

@interface YJTestTableViewCell : YJTableViewCell

@end
