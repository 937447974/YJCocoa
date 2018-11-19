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
    frame = CGRectMake(0, 0, 9999, 100);
    self = [super initWithFrame:frame];
    if (self) {
        self.middle = YES;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *sView = self.superview;
    CGFloat leftSpace = sView.leadingFrame;
    CGFloat rightSpace = sView.superview.widthFrame - sView.trailingFrame;
    if (leftSpace <= 0 && rightSpace <= 0) return;
    self.titleLabel.frame = self.bounds;
    if (self.middle) {
        if (leftSpace > rightSpace) {
            self.titleLabel.widthFrame -= leftSpace - rightSpace;
        } else {
            self.titleLabel.leadingFrame = rightSpace - leftSpace;
            self.titleLabel.widthFrame = self.widthFrame - self.titleLabel.leadingFrame;
        }
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

@end
