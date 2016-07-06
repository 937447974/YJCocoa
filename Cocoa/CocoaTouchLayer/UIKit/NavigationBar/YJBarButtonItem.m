//
//  YJBarButtonItem.m
//  YJNavigationBar
//
//  Created by admin on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJBarButtonItem.h"

@implementation YJBarButtonItem

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
