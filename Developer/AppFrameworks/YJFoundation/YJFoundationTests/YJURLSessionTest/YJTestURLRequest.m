//
//  YJTestURLRequest.m
//  YJFoundation
//
//  Created by 阳君 on 2016/11/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTestURLRequest.h"
#import "YJTestURLSessionTask.h"

@implementation YJTestURLRequest

- (Class)URLSessionTask {
    return [YJTestURLSessionTask class];
}

- (NSString *)URL {
    return @"https://github.com/937447974/YJCocoa";
}

- (BOOL)supportResume {
    return YES;
}

@end
