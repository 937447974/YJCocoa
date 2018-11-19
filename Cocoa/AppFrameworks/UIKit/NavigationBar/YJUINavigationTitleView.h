//
//  YJUINavigationTitleView.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/19.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** UINavigationItem.titleView*/
@interface YJUINavigationTitleView : UIView

@property (nonatomic) BOOL middle; ///< 是否居中显示, 默认YES

@property (nonatomic, strong) UILabel *titleLabel; ///< 标题label

@end

NS_ASSUME_NONNULL_END
