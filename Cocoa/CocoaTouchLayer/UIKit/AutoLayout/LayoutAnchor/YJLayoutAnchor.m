//
//  YJLayoutAnchor.m
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJLayoutAnchor.h"

@implementation YJLayoutAnchor

#pragma mark super
- (instancetype)initWithItem:(id)item attribute:(NSLayoutAttribute)attribute {
    
    self = [super init];
    if (self) {
        _item = item;
        _attribute = attribute;
    }
    return self;
    
}

#pragma mark - getter
- (LessThanOrEqualTo)lessThanOrEqualTo {
    __weak YJLayoutAnchor *wSelf = self;
    LessThanOrEqualTo lessThanOrEqualTo = ^ (YJLayoutAnchor *anchor) {
        return [NSLayoutConstraint constraintWithItem:wSelf.item attribute:wSelf.attribute lessThanOrEqualToItem:anchor.item attribute:anchor.attribute];
    };
    return lessThanOrEqualTo;
}

- (EqualTo)equalTo {
    __weak YJLayoutAnchor *wSelf = self;
    EqualTo equalTo = ^ (YJLayoutAnchor *anchor) {
        return [NSLayoutConstraint constraintWithItem:wSelf.item attribute:wSelf.attribute equalToItem:anchor.item attribute:anchor.attribute];
    };
    return equalTo;
}

- (GreaterThanOrEqualTo)greaterThanOrEqualTo {
    __weak YJLayoutAnchor *wSelf = self;
    GreaterThanOrEqualTo greaterThanOrEqualTo = ^ (YJLayoutAnchor *anchor) {
        return [NSLayoutConstraint constraintWithItem:wSelf.item attribute:wSelf.attribute greaterThanOrEqualToItem:anchor.item attribute:anchor.attribute];
    };
    return greaterThanOrEqualTo;
}

- (ConstraintTo)costraintTo {
    __weak YJLayoutAnchor *wSelf = self;
    ConstraintTo block = ^ (YJLayoutAnchor *anchor) {
        return [NSLayoutConstraint findConstraintWithItem:wSelf.item attribute:wSelf.attribute toItem:anchor.item attribute:anchor.attribute];
    };
    return block;
}

@end
