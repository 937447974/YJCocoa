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
    return [code stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"] invertedSet]];
}

NSString *YJNSURLDecode(NSString *code) {
    return [code stringByRemovingPercentEncoding];
}
