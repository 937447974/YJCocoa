//
//  YJTTableCellObject.m
//  YJTTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/13.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTTableCellObject.h"
#import <objc/runtime.h>
#import "YJSFoundationOther.h"

@implementation YJTTableCellObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _cellName = YJStringFromClass([self class]);
        NSRange range = [_cellName rangeOfString:@"Cell"];
        if (range.length && ![_cellName isEqualToString:YJStringFromClass([YJTTableCellObject class])]) {
            _cellName = [_cellName substringWithRange:NSMakeRange(0, range.length + range.location)];// 获取类名
            const char *name = [_cellName cStringUsingEncoding:NSUTF8StringEncoding];
            _cellClass = objc_getClass(name);// 自动填充TableViewCell
        } else {
            NSLog(@"Cell非法命名。如使用YJCell，请以YJTTableCellObject命名");
        }
    }
    return self;
}

- (instancetype)initWithTableViewCellClass:(Class)cellClass {
    self = [super init];
    if (self) {
        _cellClass = cellClass;
        _cellName = YJStringFromClass(_cellClass);
    }
    return self;
}

@end