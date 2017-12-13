//
//  YJNSKeyValueObserver.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/12/13.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSKeyValueObserver.h"

@implementation YJNSKeyValueObserver

- (instancetype)initWithObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath kvoBlock:(YJNSKVOBlock)kvoBlock {
    self = [super init];
    if (self) {
        _observer = observer;
        _keyPath = keyPath;
        _kvoBlock = kvoBlock;
    }
    return self;
}

#pragma mark - NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(NSObject *)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (self.observer) {
        self.kvoBlock(change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
    } else if (!self.removed) {
        self.removed = YES;
        [object removeObserver:self forKeyPath:self.keyPath];
    }
}

@end
