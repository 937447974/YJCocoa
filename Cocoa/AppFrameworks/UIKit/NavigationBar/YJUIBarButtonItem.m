//
//  YJUIBarButtonItem.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/18.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import "YJUIBarButtonItem.h"
#import "UIView+YJUIViewGeometry.h"
#import <objc/runtime.h>


@implementation UIButton (YJUIBarButtonItem)

- (void)yj_touchUpInside {
    dispatch_block_t block = objc_getAssociatedObject(self, "yj_touchUpInsideBlock");
    !block?:block();
}

- (void)setYj_touchUpInsideBlock:(dispatch_block_t)yj_touchUpInsideBlock {
    objc_setAssociatedObject(self, "yj_touchUpInsideBlock", yj_touchUpInsideBlock, OBJC_ASSOCIATION_COPY);
}

@end

#pragma mark -
@interface YJUIBarButtonItem ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation YJUIBarButtonItem

- (instancetype)initWithTouchUpInsideBlock:(dispatch_block_t)block {
    self = [super init];
    if (self) {
        [self.button setYj_touchUpInsideBlock:block];
    }
    return self;
}

- (void)setTitle:(NSString *)title font:(UIFont *)font color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor {
    font = font ?: [UIFont systemFontOfSize:14];;
    color = color ?: [UINavigationBar appearance].tintColor;
    color = color ?: UIColor.blackColor;
    highlightedColor = highlightedColor ?: [color colorWithAlphaComponent:0.5];
    self.button.titleLabel.font = font;
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button setTitleColor:color forState:UIControlStateNormal];
    [self.button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
}

- (void)setImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    highlightedImage = highlightedImage ?: [self imageWithAlpha:0.5 image:image];
    [self.button setImage:image forState:UIControlStateNormal];
    [self.button setImage:highlightedImage forState:UIControlStateHighlighted];
}

- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    self.button.titleEdgeInsets = titleEdgeInsets;
}

- (void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    self.button.imageEdgeInsets = imageEdgeInsets;
}

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

#pragma mark - Build
- (UIBarButtonItem *)buildBarButtonItem {
    CGSize size = [self.button sizeThatFits:CGSizeMake(300, 30)];
    self.button.widthFrame = size.width > 25 ? ceilf(size.width) : 25;
    return [[UIBarButtonItem alloc] initWithCustomView:self.button];
}

- (UIBarButtonItem *)buildBackBarButtonItem {
    UIBarButtonItem *item = [self buildBarButtonItem];
    self.button.widthFrame += 3;
    self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return item;
}

#pragma mark - Getter
- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        [_button addTarget:_button action:@selector(yj_touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
