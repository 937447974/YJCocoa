//
//  YJTestURLSessionTask.m
//  YJFoundation
//
//  Created by 阳君 on 2016/11/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTestURLSessionTask.h"

@implementation YJTestURLSessionTask

- (void)resume {
    [super resume];
    self.failure([NSError errorWithDomain:@"网络错误测试" code:404 userInfo:nil]);
}

@end
