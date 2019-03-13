//
//  NSMutableDictionary+YJSecurity.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/3/13.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#import "NSMutableDictionary+YJSecurity.h"
#import "YJNSLog.h"

@implementation NSMutableDictionary (YJSecurity)

#pragma mark - Getter
- (BOOL)boolForKey:(id)aKey {
    NSNumber *obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class])
        return obj.boolValue;
    return NO;
}

- (NSInteger)integerForKey:(id)aKey {
    NSNumber *obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class])
        return obj.integerValue;
    return 0;
}

- (CGFloat)floatForKey:(id)aKey {
    NSNumber *obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class])
        return obj.floatValue;
    return 0;
}

#define YJObjectGet(Cls) Cls *obj = [self objectForKey:aKey];\
if ([obj isKindOfClass:Cls.class]) return obj;\
return [[Cls alloc] init];
- (NSString *)stringForKey:(id)aKey {YJObjectGet(NSString)}
- (NSSet *)setForKey:(id)aKey {YJObjectGet(NSSet)}
- (NSArray *)arrayForKey:(id)aKey {YJObjectGet(NSArray)}
- (NSDictionary *)dictionaryForKey:(id)aKey {YJObjectGet(NSDictionary)}

#define YJObjectGetM(ClsM, Cls) \
ClsM *obj = [self objectForKey:aKey];\
if ([obj isKindOfClass:ClsM.class])  { return obj;\
} if ([obj isKindOfClass:Cls.class]) {\
obj = obj.mutableCopy;\
} else {\
obj = [[ClsM alloc] init];\
}\
YJLogError(@"[Dictionary] get key: %@ 对应的 value 不存在或类型错误", aKey);\
[self setObject:obj forKey:aKey];\
return obj;
- (NSMutableSet *)mutableSetForKey:(id)aKey {YJObjectGetM(NSMutableSet, NSSet)}
- (NSMutableArray *)mutableArrayForKey:(id)aKey {YJObjectGetM(NSMutableArray, NSArray)}
- (NSMutableDictionary *)mutableDictionaryForKey:(id)aKey {YJObjectGetM(NSMutableDictionary, NSDictionary)}

#pragma mark - Setter
#define YJObjectSet \
NSNumber *obj = @(anObject); \
if (obj && aKey) [self setObject:obj forKey:aKey]; \
else YJLogError(@"[Dictionary] set 对应的 key:%@ 或 value:%@ 不存在", obj, aKey);

- (void)setBOOL:(BOOL)anObject forKey:(id)aKey {YJObjectSet}
- (void)setInteger:(NSInteger)anObject forKey:(id)aKey {YJObjectSet}
- (void)setFloat:(CGFloat)anObject forKey:(id)aKey {YJObjectSet}

#define YJObjectSet1(Cls) \
if (anObject && aKey) {   \
if ([anObject isKindOfClass:NSString.class]) { \
YJLogError(@"[Dictionary] set key:%@ 对应的 value:%@ 类型错误", anObject, aKey);\
} else { [self setObject:anObject forKey:aKey];}\
} else { YJLogError(@"[Dictionary] set 对应的 key:%@ 或 value:%@ 不存在", anObject, aKey);}

- (void)setString:(NSString *)anObject forKey:(id)aKey {YJObjectSet1(NSString)}
- (void)setSet:(NSSet *)anObject forKey:(id)aKey {YJObjectSet1(NSSet)}
- (void)setArray:(NSArray *)anObject forKey:(id)aKey {YJObjectSet1(NSArray)}
- (void)setDictionary:(NSDictionary *)anObject forKey:(id)aKey {YJObjectSet1(NSDictionary)}

@end
