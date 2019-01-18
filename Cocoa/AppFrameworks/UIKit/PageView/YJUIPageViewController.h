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

NS_ASSUME_NONNULL_BEGIN

@class YJUIPageViewController;
@protocol YJUIPageViewControllerDelegate <NSObject>

/**
 *  @abstract 页面滑动
 *
 *  @param controller YJUIPageViewController
 *  @param offset 偏移量[-1, 1]
 */
- (void)pageViewController:(YJUIPageViewController *)controller didScrollOffset:(CGFloat)offset;

@end


/** UIPageViewController*/
@interface YJUIPageViewController : UIPageViewController

@property (nonatomic, strong) YJUIPageViewManager *manager; ///< 管理器
@property (nonatomic, strong) NSMutableArray<YJUIPageViewCellObject *> *dataSourcePlain; ///< 数据源

@property (nonatomic, weak) id<YJUIPageViewControllerDelegate> pageDelegate; ///< YJUIPageViewControllerDelegate

/**
 *  @abstract 刷新pageVC
 */
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
