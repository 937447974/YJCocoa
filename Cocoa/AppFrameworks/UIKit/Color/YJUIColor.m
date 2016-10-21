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

UIColor *YJUIColorHex(NSString *hex) {
    return YJUIColorHexA(hex, 1);
}

CGFloat strtoulHex(NSString *str) {
    return strtoul(str.UTF8String, 0, 16);
}

UIColor *YJUIColorHexA(NSString *hex, CGFloat alpha) {
    if (hex.length<5) {
        NSLog(@"十六进制颜色设置错误：%@", hex);
        return [UIColor clearColor];
    }
    hex = [hex substringFromIndex:hex.length-6];
    CGFloat red = strtoulHex([hex substringWithRange:NSMakeRange(0, 2)]);
    CGFloat green = strtoulHex([hex substringWithRange:NSMakeRange(2, 2)]);
    CGFloat blue = strtoulHex([hex substringWithRange:NSMakeRange(4, 2)]);
    return YJUIColorRGBA(red, green, blue, alpha);
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
