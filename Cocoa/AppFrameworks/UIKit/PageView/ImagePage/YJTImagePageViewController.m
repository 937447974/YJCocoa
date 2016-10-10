//
//  YJTImagePageViewController.m
//  YJTPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/7.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTImagePageViewController.h"

@interface YJTImagePageViewController ()

@end

@implementation YJTImagePageViewController

#pragma mark - IBAction 点击图片
- (IBAction)onClickImageView:(id)sender {
    self.pageView.pageViewDidSelect(self);
}

#pragma mark - YJTPageView
- (void)reloadDataAsyncWithPageViewObject:(YJTPageViewObject *)pageViewObject pageView:(YJTPageView *)pageView {
    [super reloadDataAsyncWithPageViewObject:pageViewObject pageView:pageView];
    YJTImagePageModel *model = pageViewObject.pageModel;
    self.imageView.image = [UIImage imageNamed:model.imageNamed];
    self.imageView.userInteractionEnabled = model.isOnClick;
}

@end
