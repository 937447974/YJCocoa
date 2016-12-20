//
//  YJNSURLCode.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/16.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSURLCode.h"

NSString *YJNSURLEncode(NSString *code) {
    if ([code isKindOfClass:[NSString class]]) {
        return [code stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"] invertedSet]];
    }
    return code;
}

NSString *YJNSURLDecode(NSString *code) {
    if ([code isKindOfClass:[NSString class]]) {
        return [code stringByRemovingPercentEncoding];
    }
    return code;
}
