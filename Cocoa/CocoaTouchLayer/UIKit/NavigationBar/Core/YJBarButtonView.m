//
//  YJBarButtonView.m
//  YJNavigationBar
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJBarButtonView.h"
#import "UIView+YJViewGeometry.h"

@implementation YJBarButtonView

+ (instancetype)appearance {
    YJBarButtonView *bbView = [super appearance];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bbView.titleColor = [UIColor blackColor];
        bbView.titleFont = [UIFont systemFontOfSize:14];
        bbView.highlightedAlpha = 0.5;
        bbView.spacing = 5;
    });
    return bbView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        YJBarButtonView *bbView = [YJBarButtonView appearance];
        _titleColor = bbView.titleColor;
        _titleFont = bbView.titleFont;
        _highlightedAlpha = bbView.highlightedAlpha;
        _spacing = bbView.spacing;
    }
    return self;
}

- (void)setBarButtonItem:(YJBarButtonItem *)barButtonItem {
    _barButtonItem = barButtonItem;
    self.barButtonItems = @[barButtonItem];
}

- (void)setBarButtonItems:(NSArray<YJBarButtonItem *> *)barButtonItems {
    _barButtonItems = barButtonItems;
    [self reloadData];
}

#pragma mark -
- (void)reloadData {
    // 界面渲染
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    CGFloat y = (self.heightFrame - 30) / 2;
    CGFloat x = -self.spacing;
    for (YJBarButtonItem *item in self.barButtonItems) {
        x += self.spacing;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 30, 30)];
        [self addSubview:button];
        button.tag = item.tag;
        // 标题
        button.titleLabel.font = [UIFont systemFontOfSize:100];
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:[self.titleColor colorWithAlphaComponent:self.highlightedAlpha] forState:UIControlStateHighlighted];
        // 图片
        [button setImage:item.image forState:UIControlStateNormal];
        [button setImage:[self imageWithAlpha:self.highlightedAlpha image:item.image] forState:UIControlStateHighlighted];
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
