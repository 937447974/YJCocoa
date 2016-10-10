//
//  YJNSDictionaryModelManager.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/9/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSDictionaryModelManager.h"

@implementation YJNSDictionaryModelManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _systemBaseClass = [NSSet setWithObjects:[NSString class], [NSNumber class], [NSDecimalNumber class], [NSArray class], [NSDictionary class], [NSNull class], [NSMutableString class], [NSMutableArray class], [NSMutableDictionary class], nil];
    }
    return self;
}

@end
