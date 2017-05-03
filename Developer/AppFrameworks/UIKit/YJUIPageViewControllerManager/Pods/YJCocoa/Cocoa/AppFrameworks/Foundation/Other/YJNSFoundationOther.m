//
//  YJNSFoundationOther.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//
//  Created by 阳君 on 16/5/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSFoundationOther.h"

#pragma mark 获取类名
NSString *YJNSStringFromClass(Class aClass) {
    NSString *className = NSStringFromClass(aClass);
    NSArray<NSString *> *array = [className componentsSeparatedByString:@"."];
    return array.lastObject;
}

