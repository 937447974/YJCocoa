//
//  YJSecKeychainItem.m
//  YJSecSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/1.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJSecKeychainItem.h"

@interface YJSecKeychainItem () <YJSecKItemAttribute, YJSecKItemGenericPasswordAttribute>

@end

@implementation YJSecKeychainItem

- (instancetype)init {
    self = [super init];
    if (self) {
        _selectDict = [NSMutableDictionary dictionary];
        [_selectDict setObject:self.kClass forKey:(id)kSecClass];
        _weakDict = [NSMutableDictionary dictionary];
        _strongDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)mutableCopy {
    YJSecKeychainItem *mCopy = [[self.class alloc] init];
    mCopy.selectDict = [self.selectDict mutableCopy];
    mCopy.weakDict = [self.weakDict mutableCopy];
    mCopy.strongDict = [self.strongDict mutableCopy];   
    return mCopy;
}

#pragma mark - 框架接口
- (void)setStrongDict:(NSMutableDictionary *)strongDict {
    _strongDict = strongDict;
    [self saveToSelectDict:(id)kSecClass];
    [self saveToSelectDict:(id)kSecAttrAccessGroup];
    [self saveToSelectDict:(id)kSecAttrAccount];
    [self.weakDict removeAllObjects];
}

- (void)saveToSelectDict:(id)key {
    id obj = [self.strongDict objectForKey:key];
    if (obj) {
        [self.selectDict setObject:obj forKey:key];
    }
}

#pragma mark - YJKItemAttribute
#pragma mark kSecClass
- (NSString *)kClass {
    return (NSString *)kSecClassGenericPassword; // 默认
}

#pragma mark kSecAttrAccessGroup
- (NSString *)accessGroup {
    return [self.strongDict objectForKey:(id)kSecAttrAccessGroup];
}

- (void)setAccessGroup:(NSString *)accessGroup {
    [self.selectDict setObject:accessGroup forKey:(id)kSecAttrAccessGroup];
    [self.strongDict setObject:accessGroup forKey:(id)kSecAttrAccessGroup];
}

#pragma mark kSecAttrAccessible
- (NSString *)accessible {
    return [self.strongDict objectForKey:(id)kSecAttrAccessible];
}

- (void)setAccessible:(NSString *)accessible {
    [self.weakDict setObject:accessible forKey:(id)kSecAttrAccessible];
    [self.strongDict setObject:accessible forKey:(id)kSecAttrAccessible];
}

#pragma mark kSecAttrLabel
- (NSString *)label {
    return [self.strongDict objectForKey:(id)kSecAttrLabel];
}

- (void)setLabel:(NSString *)label {
    [self.weakDict setObject:label forKey:(id)kSecAttrLabel];
    [self.strongDict setObject:label forKey:(id)kSecAttrLabel];
}

#pragma mark - YJKItemGenericPasswordAttribute
#pragma mark kSecAttrAccount
- (NSString *)account {
    return [self.strongDict objectForKey:(id)kSecAttrAccount];
}

- (void)setAccount:(NSString *)account {
    [self.selectDict setObject:account forKey:(id)kSecAttrAccount];
    [self.strongDict setObject:account forKey:(id)kSecAttrAccount];
}

#pragma mark kSecAttrCreationDate
- (NSDate *)createDate {
    return [self.strongDict objectForKey:(id)kSecAttrCreationDate];
}

#pragma mark kSecAttrModificationDate
- (NSDate *)modifyDate {
    return [self.strongDict objectForKey:(id)kSecAttrModificationDate];
}

#pragma mark kSecAttrDescription
- (NSString *)desc {
    return [self.strongDict objectForKey:(id)kSecAttrDescription];
}

- (void)setDesc:(NSString *)desc {
    [self.weakDict setObject:desc forKey:(id)kSecAttrDescription];
    [self.strongDict setObject:desc forKey:(id)kSecAttrDescription];
}

#pragma mark kSecAttrComment
- (NSString *)comment {
    return [self.strongDict objectForKey:(id)kSecAttrComment];
}

- (void)setComment:(NSString *)comment {
    [self.weakDict setObject:comment forKey:(id)kSecAttrComment];
    [self.strongDict setObject:comment forKey:(id)kSecAttrComment];
}

#pragma mark kSecAttrCreator
- (NSNumber *)creator {
    return [self.strongDict objectForKey:(id)kSecAttrCreator];
}

- (void)setCreator:(NSNumber *)creator {
    [self.weakDict setObject:creator forKey:(id)kSecAttrCreator];
    [self.strongDict setObject:creator forKey:(id)kSecAttrCreator];
}

#pragma mark kSecAttrType
- (NSNumber *)type {
    return [self.strongDict objectForKey:(id)kSecAttrType];
}

- (void)setType:(NSNumber *)type {
    [self.weakDict setObject:type forKey:(id)kSecAttrType];
    [self.strongDict setObject:type forKey:(id)kSecAttrType];
}

#pragma mark kSecAttrIsInvisible
- (Boolean)isInvisible {
    return ((NSNumber *)[self.strongDict objectForKey:(id)kSecAttrIsInvisible]).boolValue;
}

- (void)setIsInvisible:(Boolean)isInvisible {
    [self.weakDict setObject:@(isInvisible) forKey:(id)kSecAttrIsInvisible];
    [self.strongDict setObject:@(isInvisible) forKey:(id)kSecAttrIsInvisible];
}

#pragma mark kSecAttrIsNegative
- (Boolean)isNegative {
    return ((NSNumber *)[self.strongDict objectForKey:(id)kSecAttrIsNegative]).boolValue;
}

- (void)setIsNegative:(Boolean)isNegative {
    [self.weakDict setObject:@(isNegative) forKey:(id)kSecAttrIsNegative];
    [self.strongDict setObject:@(isNegative) forKey:(id)kSecAttrIsNegative];
}

#pragma mark kSecAttrService
- (NSString *)service {
    return [self.strongDict objectForKey:(id)kSecAttrService];
}

- (void)setService:(NSString *)service {
    [self.weakDict setObject:service forKey:(id)kSecAttrService];
    [self.strongDict setObject:service forKey:(id)kSecAttrService];
}

#pragma mark kSecAttrGeneric
-(NSData *)generic {
    return [self.strongDict objectForKey:(id)kSecAttrGeneric];
}

- (void)setGeneric:(NSData *)generic {
    [self.weakDict setObject:generic forKey:(id)kSecAttrGeneric];
    [self.strongDict setObject:generic forKey:(id)kSecAttrGeneric];
}

@end
