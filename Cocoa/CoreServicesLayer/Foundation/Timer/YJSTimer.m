//
//  YJSTimer.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/5.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJSTimer.h"
#import ""

@interface YJSTimer () {
    NSString *_identifier; ///< 标识符
}



@end

@implementation YJSTimer

#pragma mark - init
+ (instancetype)timerStrongWithIdentifier:(NSString *)identifier {
    
}

+ (instancetype)timerWeakWithIdentifier:(NSString *)identifier {
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeInterval = 1;
    }
    return self;
}

#pragma mark - getter & setter
- (NSString *)identifier {
    if (!_identifier) {
        
    }
    return _identifier;
}

@end
