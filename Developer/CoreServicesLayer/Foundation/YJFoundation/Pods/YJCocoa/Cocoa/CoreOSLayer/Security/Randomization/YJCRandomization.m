//
//  YJCRandomization.m
//  YJCSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJCRandomization.h"
#import <Security/Security.h>

NSString *randomizationUL(size_t count, NSString *format) {
    uint8_t randomBytes[count];
    int result = SecRandomCopyBytes(kSecRandomDefault, count, randomBytes);
    if(result == 0) {
        NSMutableString *mStr = [[NSMutableString alloc] initWithCapacity:count*2];
        for (NSInteger index = 0; index < count; index++) {
            [mStr appendFormat:format, randomBytes[index]];
        }
        return mStr;
    }
    return nil;
}

NSString *randomizationUppercase(size_t count) {
    return randomizationUL(count, @"%02X");
}

NSString *randomizationLowercase(size_t count) {
    return randomizationUL(count, @"%02x");
}

NSString *randomization(size_t count) {
    uint8_t randomBytes[count];
    int result = SecRandomCopyBytes(kSecRandomDefault, count, randomBytes);
    if (result == 0) {
        NSMutableString *mStr = [[NSMutableString alloc] initWithCapacity:count*2];
        NSString *format;
        for(NSInteger index = 0; index < count; index++) {
            format = random() % 2 ? @"%02X" : @"%02x";
            [mStr appendFormat:format, randomBytes[index]];
        }
        return mStr;
    }
    return nil;
}

