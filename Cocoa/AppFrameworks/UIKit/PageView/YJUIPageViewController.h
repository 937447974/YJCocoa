//
//  YJUIPageViewController.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/6/10.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUIPageViewManager.h"

@interface YJUIPageViewController : UIPageViewController

@property (nonatomic, strong) YJUIPageViewManager *manager; ///< 管理器
@property (nonatomic, strong) NSMutableArray<YJUIPageViewCellObject *> *dataSourcePlain; ///< 数据源

/**
 *  @abstract 刷新pageVC
 */
- (void)reloadData;

@end
