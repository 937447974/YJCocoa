//
//  YJTestTableCellModel.h
//  YJTableView
//
//  Created by 阳君 on 2016/12/15.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJUITableViewManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJTestTableCellModel : NSObject <YJUITableCellModelProtocol>

@property (nonatomic, copy) NSString *userName; ///< 用户名
@property (nonatomic)       BOOL switchOn;      ///< 是否选中

@end

NS_ASSUME_NONNULL_END
