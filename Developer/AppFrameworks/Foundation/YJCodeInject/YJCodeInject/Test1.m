//
//  Test1.m
//  YJCodeInject
//
//  Created by 阳君 on 2019/3/5.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import "Test1.h"
#import "YJCodeInject.h"

@implementation Test1

YJCI_FUNCTION_EXPORT(A)(void) {
    NSLog(@"Test1 FUNCTION A", nil);
}

YJCI_FUNCTION_EXPORT(B)(void) {
    NSLog(@"Test1 FUNCTION B", nil);
}

YJCI_BLOCK_EXPORT(A, ^(void) {
    NSLog(@"Test1 BLOCK A", nil);
})

YJCI_BLOCK_EXPORT(B, ^(void) {
    NSLog(@"Test1 BLOCK B", nil);
})

@end
