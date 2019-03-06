//
//  ViewController.m
//  YJCodeInject
//
//  Created by 阳君 on 2019/3/5.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJCodeInject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YJCI_FUNCTION_EXECUTE(A)
    YJCI_FUNCTION_EXECUTE(B)
    YJCI_BLOCK_EXECUTE(A)
    YJCI_BLOCK_EXECUTE(B)
}

YJCI_FUNCTION_EXPORT(I23456789012345)(void) {}
YJCI_BLOCK_EXPORT(I23456789012345, ^(void) {})

YJCI_FUNCTION_EXPORT(A)(void) {
    NSLog(@"ViewController FUNCTION A", nil);
}

YJCI_FUNCTION_EXPORT(B)(void) {
    NSLog(@"ViewController FUNCTION B", nil);
}

YJCI_BLOCK_EXPORT(A, ^(void) {
    NSLog(@"ViewController BLOCK A", nil);
})

YJCI_BLOCK_EXPORT(B, ^(void) {
    NSLog(@"ViewController BLOCK B", nil);
})


@end
