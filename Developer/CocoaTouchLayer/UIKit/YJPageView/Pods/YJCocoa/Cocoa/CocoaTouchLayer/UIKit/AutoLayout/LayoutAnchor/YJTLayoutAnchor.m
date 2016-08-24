//
//  YJTLayoutAnchor.m
//  YJAutoLayout
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTLayoutAnchor.h"

@implementation YJTLayoutAnchor

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
    __weak YJTLayoutAnchor *wSelf = self;
    LessThanOrEqualTo lessThanOrEqualTo = ^ (YJTLayoutAnchor *anchor) {
        return [NSLayoutConstraint constraintWithItem:wSelf.item attribute:wSelf.attribute lessThanOrEqualToItem:anchor.item attribute:anchor.attribute];
    };
    return lessThanOrEqualTo;
}

- (EqualTo)equalTo {
    __weak YJTLayoutAnchor *wSelf = self;
    EqualTo equalTo = ^ (YJTLayoutAnchor *anchor) {
        return [NSLayoutConstraint constraintWithItem:wSelf.item attribute:wSelf.attribute equalToItem:anchor.item attribute:anchor.attribute];
    };
    return equalTo;
}

- (GreaterThanOrEqualTo)greaterThanOrEqualTo {
    __weak YJTLayoutAnchor *wSelf = self;
    GreaterThanOrEqualTo greaterThanOrEqualTo = ^ (YJTLayoutAnchor *anchor) {
        return [NSLayoutConstraint constraintWithItem:wSelf.item attribute:wSelf.attribute greaterThanOrEqualToItem:anchor.item attribute:anchor.attribute];
    };
    return greaterThanOrEqualTo;
}

- (ConstraintTo)costraintTo {
    __weak YJTLayoutAnchor *wSelf = self;
    ConstraintTo block = ^ (YJTLayoutAnchor *anchor) {
        return [NSLayoutConstraint findConstraintWithItem:wSelf.item attribute:wSelf.attribute toItem:anchor.item attribute:anchor.attribute];
    };
    return block;
}

@end
