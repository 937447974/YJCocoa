//
//  YJNavigationBar.h
//  YJNavigationBar
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by admin on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJBarButtonItem.h"

NS_ASSUME_NONNULL_BEGIN

/*使用方法
 
 */

/** 替换UINavigationItem.titleView*/
@interface YJNavigationBar : UIView

@property (nullable, nonatomic, copy)   NSString *title;   ///< 标题
@property (nullable, nonatomic, strong) UIView *titleView; ///< 自定义titleView

@property (nullable, nonatomic, strong) YJBarButtonItem *leftBarButtonItem;  ///< 左按钮
@property (nullable, nonatomic, strong) YJBarButtonItem *rightBarButtonItem; ///< 右按钮

@property (nullable, nonatomic, strong) NSArray<YJBarButtonItem *> *leftBarButtonItems;  ///< 左按钮集合
@property (nullable, nonatomic, strong) NSArray<YJBarButtonItem *> *rightBarButtonItems; ///< 右按钮集合

@end

NS_ASSUME_NONNULL_END
