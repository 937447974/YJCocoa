//
//  YJTImagePageModel.h
//  YJTPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/7.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTPageView.h"

/** YJTImagePageViewController对应的model*/
@interface YJTImagePageModel : NSObject <YJTPageViewModelProtocol>

@property (nonatomic) BOOL isOnClick;             ///< 能否点击
@property (nonatomic, copy) NSString *imageNamed; ///< 图片名

@end
