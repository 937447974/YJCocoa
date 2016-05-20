//
//  YJImagePageViewController.m
//  YJPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/7.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJImagePageViewController.h"

@interface YJImagePageViewController ()

@end

@implementation YJImagePageViewController

#pragma mark - IBAction 点击图片
- (IBAction)onClickImageView:(id)sender {
    self.pageView.pageViewDidSelect(self);
}

#pragma mark - YJPageView
- (void)reloadPageAsyncWithPageViewObject:(YJPageViewObject *)pageViewObject pageView:(YJPageView *)pageView {
    [super reloadPageAsyncWithPageViewObject:pageViewObject pageView:pageView];
    YJImagePageModel *model = pageViewObject.pageModel;
    self.imageView.image = [UIImage imageNamed:model.imageNamed];
    self.imageView.userInteractionEnabled = model.isOnClick;
}

@end
