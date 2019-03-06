//
//  TestA.m
//  Pods
//
//  Created by 阳君 on 2019/3/6.
//

#import "TestA.h"
#import <YJCocoa/YJCodeInject.h>

@implementation TestA

YJCI_FUNCTION_EXPORT(A)(void) {
    NSLog(@"FrameworkA FUNCTION A", nil);
}

YJCI_BLOCK_EXPORT(A, ^(void) {
    NSLog(@"FrameworkA BLOCK A", nil);
})

@end
