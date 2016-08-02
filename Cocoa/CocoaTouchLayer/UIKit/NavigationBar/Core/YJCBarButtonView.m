//
//  YJBarButtonView.m
//  YJNavigationBar
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJCBarButtonView.h"
#import "UIView+YJViewGeometry.h"

@implementation YJCBarButtonView

#pragma mark - 共享
+ (instancetype)appearance {
    static YJCBarButtonView *bbView;
    if (!bbView) {
        bbView = [[YJCBarButtonView alloc] initWithAppearance];
    }
    return bbView;
}

- (instancetype)initWithAppearance {
    self = [super initWithFrame:CGRectZero];
    if (self) { // 默认共享
        self.titleColor = [UIColor blackColor];
        self.titleFont = [UIFont systemFontOfSize:14];
        self.highlightedAlpha = 0.5;
        self.spacing = 5;
    }
    return self;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        YJCBarButtonView *bbView = [YJCBarButtonView appearance];
        _titleColor = bbView.titleColor;
        _titleFont = bbView.titleFont;
        _highlightedAlpha = bbView.highlightedAlpha;
        _spacing = bbView.spacing;
    }
    return self;
}

#pragma mark setter & getter
- (void)setBarButtonItem:(YJCBarButtonItem *)barButtonItem {
    _barButtonItem = barButtonItem;
    self.barButtonItems = @[barButtonItem];
}

- (void)setBarButtonItems:(NSArray<YJCBarButtonItem *> *)barButtonItems {
    _barButtonItems = barButtonItems;
    [self reloadData];
}

#pragma mark - 刷新UI
- (void)reloadData {
    // 界面渲染
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    CGFloat y = (self.heightFrame - 30) / 2;
    CGFloat x = -self.spacing;
    for (YJCBarButtonItem *item in self.barButtonItems) {
        x += self.spacing;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 30, 30)];
        [self addSubview:button];
        button.tag = item.tag;
        // 标题
        if (item.title) {
            button.titleLabel.font = self.titleFont;
            [button setTitle:item.title forState:UIControlStateNormal];
            [button setTitleColor:self.titleColor forState:UIControlStateNormal];
            [button setTitleColor:[self.titleColor colorWithAlphaComponent:self.highlightedAlpha] forState:UIControlStateHighlighted];
        }        
        // 图片
        if (item.image) {
            [button setImage:item.image forState:UIControlStateNormal];
            [button setImage:[self imageWithAlpha:self.highlightedAlpha image:item.image] forState:UIControlStateHighlighted];
        }
        // 事件
        [button addTarget:item.target action:item.action forControlEvents:UIControlEventTouchUpInside];
        // 位置
        CGSize size = [button systemLayoutSizeFittingSize:CGSizeMake(300, 30)];
        if (size.width > 30) {
            button.widthFrame = size.width;
        }
        x = button.trailingFrame;
    }
    self.widthFrame = x > 0 ? x : 0;
    // 回调
    if (self.reloadDataBlock) {
        self.reloadDataBlock(NO);
    }
}

#pragma mark - 图片透明度
- (UIImage *)imageWithAlpha:(CGFloat)alpha image:(UIImage*)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
