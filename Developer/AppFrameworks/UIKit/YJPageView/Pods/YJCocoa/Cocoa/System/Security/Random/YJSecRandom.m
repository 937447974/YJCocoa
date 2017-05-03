//
//  YJSecRandom.m
//  YJCSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJSecRandom.h"
#import <Security/Security.h>

NSString *randomUL(size_t count,  NSString * _Nullable format) {
    uint8_t randomBytes[count];
    int result = SecRandomCopyBytes(kSecRandomDefault, count, randomBytes);
    if(result == 0) {
        NSMutableString *mStr = [[NSMutableString alloc] initWithCapacity:count*2];
        BOOL bRandom = format.length;
        for (NSInteger index = 0; index < count; index++) {
            if (bRandom) {
                [mStr appendFormat:format, randomBytes[index]];
            } else {
                format = random() % 2 ? @"%02X" : @"%02x";
                [mStr appendFormat:format, randomBytes[index]];
            }
        }
        return mStr;
    }
    return nil;
}

NSString *YJSecRandomU(size_t count) {
    return randomUL(count, @"%02X");
}

NSString *YJSecRandomL(size_t count) {
    return randomUL(count, @"%02x");
}

NSString *YJSecRandomUL(size_t count) {
    return randomUL(count, nil);
}

