//
//  YJUIImagePageViewController.h
//  YJUIPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/7.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUIImagePageModel.h"

/** UIImageView样式*/
@interface YJUIImagePageViewController : YJUIPageViewController

// 可通过imageView.topSpaceToSuper(0).bottomSpaceToSuper(0).leadingSpaceToSuper(0).trailingSpaceToSuper(0)修改位置
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
