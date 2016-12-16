//
//  YJUITableCellObject.m
//  YJUITableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/13.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUITableCellObject.h"
#import <objc/runtime.h>
#import "YJNSFoundationOther.h"

@implementation YJUITableCellObject

- (instancetype)initWithTableViewCellClass:(Class)cellClass {
    self = [super init];
    if (self) {
        _cellClass = cellClass;
        _cellName = YJNSStringFromClass(_cellClass);
        self.reuseIdentifier = _cellName;
    }
    return self;
}

@end
