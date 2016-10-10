//
//  UITextView+YJInputLength.m
//  YJInputLength
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "UITextView+YJInputLength.h"
#import <objc/runtime.h>

@interface UITextView (YJPrivate)

@property (nonatomic, weak) NSString *oldInput; ///< 用户上一次输入

@end

@implementation UITextView (YJInputLength)

#pragma mark - getter and setter
- (void)setOldInput:(NSString *)oldInput {
    objc_setAssociatedObject(self, "oldInput", oldInput, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)oldInput {
    return objc_getAssociatedObject(self, "oldInput");
}

- (void)setInputLength:(NSInteger)inputLength {
    objc_setAssociatedObject(self, "inputLength", [NSNumber numberWithInteger:inputLength], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.oldInput = @"";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textEditingChanged:) name:UITextViewTextDidChangeNotification object:nil]; // 通过通知监听输入变化
}

- (NSInteger)inputLength {
    NSNumber *iL = objc_getAssociatedObject(self, "inputLength");
    return iL.integerValue;
}

#pragma mark - 输入变化监听
- (void)textEditingChanged:(NSNotification *)notification {
    if (![self isEqual:notification.object]) return;
    if (self.text.length > self.inputLength) {
        self.text = self.oldInput;
    } else {
        self.oldInput = self.text;
    }
}

@end
