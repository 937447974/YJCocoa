//
//  YJNSWeakObject.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//
//  Created by 阳君 on 2018/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 弱引用对象*/
@interface YJNSWeakObject : NSObject

@property (nonatomic, weak, nullable) id object; ///< 弱引用

- (instancetype)initWithObject:(id)object;

@end

NS_ASSUME_NONNULL_END
