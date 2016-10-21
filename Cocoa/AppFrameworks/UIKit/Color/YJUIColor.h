//
//  YJUIColor.h
//  YJUIColor
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @abstract 通过RGB获取UIColor
 *
 *  @param red   红[0, 255]
 *  @param green 绿[0, 255]
 *  @param blue  蓝[0, 255]
 *
 *  @return UIColor
 */
FOUNDATION_EXPORT UIColor *YJUIColorRGB(CGFloat red, CGFloat green, CGFloat blue);

/**
 *  @abstract 通过RGB以及透明度获取UIColor
 *
 *  @param red   红[0, 255]
 *  @param green 绿[0, 255]
 *  @param blue  蓝[0, 255]
 *  @param alpha 透明度[0, 1]
 *
 *  @return UIColor
 */
FOUNDATION_EXPORT UIColor *YJUIColorRGBA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);

/**
 *  @abstract 通过十六进制获取UIColor
 *
 *  @param hex 如#FFFFFF
 *
 *  @return UIColor
 */
FOUNDATION_EXPORT UIColor *YJUIColorHex(NSString *hex);

/**
 *  @abstract 通过十六进制以及透明度获取UIColor
 *
 *  @param hex 如#FFFFFF
 *  @param alpha 透明度[0, 1]
 *
 *  @return UIColor
 */
FOUNDATION_EXPORT UIColor *YJUIColorHexA(NSString *hex, CGFloat alpha);


/** UIView颜色扩展*/
@interface UIView (YJUIColor)

/** RGB设置背景色*/
@property (nonatomic, copy, readonly) void (^ backgroundColorRGB)(CGFloat red, CGFloat green, CGFloat blue);
/** RGB及透明度设置背景色*/
@property (nonatomic, copy, readonly) void (^ backgroundColorRGBA)(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);

@end


