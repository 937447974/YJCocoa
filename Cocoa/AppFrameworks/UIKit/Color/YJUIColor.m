//
//  YJUIColor.m
//  YJUIColor
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUIColor.h"

UIColor *YJUIColorRGB(CGFloat red, CGFloat green, CGFloat blue) {
    return YJUIColorRGBA(red, green, blue, 1);
}

UIColor *YJUIColorRGBA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

UIColor *YJUIColorHex(NSInteger hex) {
    return YJUIColorHexA(hex, 1);
}

UIColor *YJUIColorHexA(NSInteger hex, CGFloat alpha) {
    return YJUIColorRGBA((hex & 0xFF0000) >> 16, (hex & 0xFF00) >> 8, hex & 0xFF, alpha);
}

@implementation UIView (YJUIColor)

- (void (^)(CGFloat, CGFloat, CGFloat))backgroundColorRGB {
    void (^ block)(CGFloat red, CGFloat green, CGFloat blue) = ^ (CGFloat red, CGFloat green, CGFloat blue) {
        self.backgroundColor = YJUIColorRGB(red, green, blue);
    };
    return block;
}

- (void (^)(CGFloat, CGFloat, CGFloat, CGFloat))backgroundColorRGBA {
    void (^ block)(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) = ^ (CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
        self.backgroundColor = YJUIColorRGBA(red, green, blue, alpha);
    };
    return block;
}

@end
