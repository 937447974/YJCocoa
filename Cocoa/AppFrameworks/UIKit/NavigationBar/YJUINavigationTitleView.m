//
//  YJUINavigationTitleView.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/19.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import "YJUINavigationTitleView.h"
#import "UIView+YJUIViewGeometry.h"

@implementation YJUINavigationTitleView

#pragma mark - self
- (instancetype)initWithFrame:(CGRect)frame {
    frame = CGRectMake(0, 0, 1000, 30);
    self = [super initWithFrame:frame];
    if (self) {
        self.middle = YES;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    if (!self.middle) return;
    UIView *cView = self;
    BOOL noInBar = YES;
    CGFloat leftSpace = 0;
    CGFloat rightSpace = 0;
    while (cView.superview && noInBar) {
        UIView *sView = cView.superview;
        noInBar = ![sView isKindOfClass:UINavigationBar.class];
        leftSpace += cView.leadingFrame;
        rightSpace += sView.widthFrame - cView.trailingFrame;
        cView = sView;
    }
    if (noInBar) return;
    if (leftSpace > rightSpace) {
        self.titleLabel.widthFrame -= leftSpace - rightSpace;
    } else {
        self.titleLabel.leadingFrame = rightSpace - leftSpace;
        self.titleLabel.widthFrame = self.widthFrame - self.titleLabel.leadingFrame;
    }
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.heightFrame)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        NSDictionary *titleTextAttributes = [UINavigationBar appearance].titleTextAttributes;
        _titleLabel.textColor = [titleTextAttributes objectForKey:NSForegroundColorAttributeName];
        _titleLabel.font = [titleTextAttributes objectForKey:NSFontAttributeName];
    }
    return _titleLabel;
}

- (void)setFrame:(CGRect)frame {
    if (self.superview) {
        frame.size.height = MIN(frame.size.height , self.superview.heightFrame);
        frame.size.width = MIN(frame.size.width, self.superview.widthFrame);
    }
    CGRect oldFrame = self.frame;
    [super setFrame:frame];
    if (oldFrame.size.width == frame.size.width && oldFrame.size.height == frame.size.height) {
        [self layoutSubviews];
    }
}

@end
