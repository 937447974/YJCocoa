//
//  YJNSCache.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/7/13.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** NSCache */
@interface YJNSCache <KeyType, ObjectType> : NSCache <KeyType, ObjectType>

@property (nonatomic, readonly) NSUInteger count; ///< 总数
@property (nonatomic, copy, readonly) NSArray<KeyType> *allKeys; ///< 所有 key
@property (nonatomic, copy, readonly) NSArray<ObjectType> *allValues; ///< 所有 value

@end

NS_ASSUME_NONNULL_END
