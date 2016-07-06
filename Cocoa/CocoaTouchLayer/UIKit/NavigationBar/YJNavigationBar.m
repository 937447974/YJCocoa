//
//  YJNavigationBar.m
//  YJNavigationBar
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJNavigationBar.h"
#import "YJSingletonMCenter.h"
#import "UIView+YJViewGeometry.h"

@interface YJNavigationBar ()

@property (nonatomic, strong) UILabel *titleLabel; ///< 标题label

@end

@implementation YJNavigationBar

+ (instancetype)appearance {
    YJNavigationBar *nb = [YJSingletonMC registerStrongSingleton:[YJNavigationBar class]];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nb.titleColor = [UIColor blackColor];
        nb.titleFont = [UIFont systemFontOfSize:14];
        nb.spacing = 10;
    });
    return nb;
}

- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, 9999, 44);
    self = [super initWithFrame:frame];
    if (self) {
        YJNavigationBar *nb = [YJNavigationBar appearance];
        _titleColor = nb.titleColor;
        _titleFont = nb.titleFont;
        _spacing = nb.spacing;
        self.leftBarButtonView = [[YJBarButtonView alloc] initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        self.rightBarButtonView = [[YJBarButtonView alloc] initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat centerYFrame = self.heightFrame / 2;
    // 水平
    self.rightBarButtonView.leadingFrame = self.widthFrame - self.rightBarButtonView.widthFrame;
    UIView *middleView = self.titleView ? self.titleView : self.titleLabel;
    middleView.leadingFrame = self.leftBarButtonView.trailingFrame + self.spacing;
    middleView.widthFrame = self.rightBarButtonView.leadingFrame - middleView.leadingFrame - self.spacing;
    // 竖直
    self.leftBarButtonView.centerYFrame = centerYFrame;
    middleView.centerYFrame = centerYFrame;
    self.rightBarButtonView.centerYFrame = centerYFrame;
}

#pragma mark - getter and setter
- (void)setLeftBarButtonView:(YJBarButtonView *)leftBarButtonView {
    _leftBarButtonView = leftBarButtonView;
    [self setBarButtonView:_leftBarButtonView];
}

- (void)setRightBarButtonView:(YJBarButtonView *)rightBarButtonView {
    _rightBarButtonView = rightBarButtonView;
    [self setBarButtonView:_rightBarButtonView];
}

- (void)setBarButtonView:(YJBarButtonView *)barButtonView {
    if (barButtonView.superview) {
        [barButtonView removeFromSuperview];
    }
    [self addSubview:barButtonView];
    __weak YJNavigationBar *weakSelf = self;
    barButtonView.reloadDataBlock = ^(BOOL animation) {
        [weakSelf layoutSubviews];
    };
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self layoutSubviews];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.heightFrame)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = self.titleColor;
        _titleLabel.font = self.titleFont;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setTitleView:(UIView *)titleView {
    if (_titleView.superview) {
        [_titleView removeFromSuperview];
    }
    _titleView = titleView;
    [self addSubview:_titleView];
    [self layoutSubviews];
}

@end


