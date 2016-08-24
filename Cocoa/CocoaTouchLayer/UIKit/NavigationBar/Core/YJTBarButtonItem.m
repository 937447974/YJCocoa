//
//  YJTBarButtonItem.m
//  YJNavigationBar
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTBarButtonItem.h"

@implementation YJTBarButtonItem

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    self = [super init];
    if (self) {
        self.title = title;
        self.target = target;
        self.action = action;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    self = [super init];
    if (self) {
        self.image = image;
        self.target = target;
        self.action = action;
    }
    return self;
}



@end
