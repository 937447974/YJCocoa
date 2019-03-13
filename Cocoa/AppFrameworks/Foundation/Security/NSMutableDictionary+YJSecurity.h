//
//  NSMutableDictionary+YJSecurity.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/3/13.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary<KeyType, ObjectType> (YJSecurity)

- (BOOL)boolForKey:(KeyType)aKey;
- (NSInteger)integerForKey:(KeyType)aKey;
- (CGFloat)floatForKey:(KeyType)aKey;
- (NSString *)stringForKey:(KeyType)aKey;
- (NSSet *)setForKey:(KeyType)aKey;
- (NSArray *)arrayForKey:(KeyType)aKey;
- (NSDictionary *)dictionaryForKey:(KeyType)aKey;
- (NSMutableSet *)mutableSetForKey:(KeyType)aKey;
- (NSMutableArray *)mutableArrayForKey:(KeyType)aKey;
- (NSMutableDictionary *)mutableDictionaryForKey:(KeyType)aKey;

- (void)setBOOL:(BOOL)anObject forKey:(KeyType)aKey;
- (void)setInteger:(NSInteger)anObject forKey:(KeyType)aKey;
- (void)setFloat:(CGFloat)anObject forKey:(KeyType)aKey;
- (void)setString:(NSString *)anObject forKey:(KeyType)aKey;
- (void)setSet:(NSSet *)anObject forKey:(KeyType)aKey;
- (void)setArray:(NSArray *)anObject forKey:(KeyType)aKey;
- (void)setDictionary:(NSDictionary *)anObject forKey:(KeyType)aKey;

@end

NS_ASSUME_NONNULL_END
