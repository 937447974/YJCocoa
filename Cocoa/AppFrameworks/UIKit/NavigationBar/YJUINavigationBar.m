//
//  YJNavigationBar.m
//  YJNavigationBar
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJUIocoa. All rights reserved.
//

#import "YJUINavigationBar.h"
#import "UIView+YJUIViewGeometry.h"

static YJUINavigationBar *NBarS; ///< YJUINavigationBar单例

@interface YJUINavigationBar ()

@property (nonatomic, strong) UILabel *titleLabel; ///< 标题label

@end

@implementation YJUINavigationBar

#pragma mark - 共享
+ (instancetype)appearance {
    if (!NBarS) {
        NBarS = [[YJUINavigationBar alloc] initWithFrame:CGRectZero];
    }
    return NBarS;
}

#pragma mark - self
- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, 9999, 44);
    self = [super initWithFrame:frame];
    if (self) {
        if (NBarS) {
            self.titleColor = NBarS.titleColor;
            self.titleFont = NBarS.titleFont;
            self.leftSpacing = NBarS.leftSpacing;
            self.rightSpacing = NBarS.rightSpacing;
            self.middle = NBarS.middle;
        } else {
            self.titleColor = [UIColor blackColor];
            self.titleFont = [UIFont systemFontOfSize:14];
            self.leftSpacing = 10;
            self.rightSpacing = 10;
            self.middle = YES;
        }
        self.leftBarButtonView = [[YJUIBarButtonView alloc] initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        self.rightBarButtonView = [[YJUIBarButtonView alloc] initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat centerYFrame = self.heightFrame / 2;
    UIView *middleView = self.titleView ? self.titleView : self.titleLabel;
    // 竖直
    self.leftBarButtonView.centerYFrame = centerYFrame;
    middleView.centerYFrame = centerYFrame;
    self.rightBarButtonView.centerYFrame = centerYFrame;
    // 水平
    self.rightBarButtonView.leadingFrame = self.widthFrame - self.rightBarButtonView.widthFrame;
    if (self.middle) {
        middleView.centerXFrame = self.widthFrame / 2;
        CGFloat leftSpacing = middleView.centerXFrame - self.leftBarButtonView.trailingFrame - self.leftSpacing;
        CGFloat rightSpecing = self.rightBarButtonView.leadingFrame - middleView.centerXFrame - self.rightSpacing;
        middleView.widthFrame = leftSpacing < rightSpecing ? 2*leftSpacing : 2*rightSpecing;
        middleView.leadingFrame = (self.widthFrame - middleView.widthFrame) / 2;
    } else {
        middleView.leadingFrame = self.leftBarButtonView.trailingFrame + self.leftSpacing;
        middleView.widthFrame = self.rightBarButtonView.leadingFrame - middleView.leadingFrame - self.rightSpacing;
    }
}

#pragma mark - getter and setter
- (void)setLeftBarButtonView:(YJUIBarButtonView *)leftBarButtonView {
    _leftBarButtonView = leftBarButtonView;
    [self setBarButtonView:_leftBarButtonView];
}

- (void)setRightBarButtonView:(YJUIBarButtonView *)rightBarButtonView {
    _rightBarButtonView = rightBarButtonView;
    [self setBarButtonView:_rightBarButtonView];
}

- (void)setBarButtonView:(YJUIBarButtonView *)barButtonView {
    if (barButtonView.superview) {
        [barButtonView removeFromSuperview];
    }
    [self addSubview:barButtonView];
    __weak YJUINavigationBar *weakSelf = self;
    barButtonView.reloadDataBlock = ^(BOOL animation) {
        [weakSelf layoutSubviews];
    };
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    self.titleView = nil;
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
    if (_titleView) {
        [self addSubview:_titleView];
    }
    [self layoutSubviews];
}

@end


