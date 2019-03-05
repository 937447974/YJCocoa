//
//  Test2.m
//  YJCodeInject
//
//  Created by 阳君 on 2019/3/5.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import "Test2.h"
#import "YJCodeInject.h"

@implementation Test2

YJCI_FUNCTION_EXPORT(A)(void) {
    NSLog(@"Test2 FUNCTION A", nil);
}

YJCI_FUNCTION_EXPORT(B)(void) {
    NSLog(@"Test2 FUNCTION B", nil);
}

YJCI_BLOCK_EXPORT(A, ^(void) {
    NSLog(@"Test2 BLOCK A", nil);
})

YJCI_BLOCK_EXPORT(B, ^(void) {
    NSLog(@"Test2 BLOCK B", nil);
})

@end
