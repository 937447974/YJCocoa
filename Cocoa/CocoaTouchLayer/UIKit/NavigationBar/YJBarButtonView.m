//
//  YJBarButtonView.m
//  YJNavigationBar
//
//  Created by admin on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJBarButtonView.h"
#import "YJSingletonMCenter.h"

@implementation YJBarButtonView

+ (instancetype)appearance {
    YJBarButtonView *bbView = [YJSingletonMC registerStrongSingleton:[YJBarButtonView class]];
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
        self.titleColor = bbView.titleColor;
        self.titleFont = bbView.titleFont;
        self.highlightedAlpha = bbView.highlightedAlpha;
        self.spacing = bbView.spacing;
    }
    return self;
}

@end
