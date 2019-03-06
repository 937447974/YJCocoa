//
//  TestB.m
//  Pods
//
//  Created by 阳君 on 2019/3/6.
//

#import "TestB.h"
#import <YJCocoa/YJCodeInject.h>

@implementation TestB

YJCI_FUNCTION_EXPORT(B)(void) {
    NSLog(@"FrameworkB FUNCTION B", nil);
}

YJCI_BLOCK_EXPORT(B, ^(void) {
    NSLog(@"FrameworkB BLOCK B", nil);
})

@end
