//
//  YJKeychainItem.m
//  YJSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/1.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJKeychainItem.h"

@interface YJKeychainItem () <YJKItemAttribute, YJKItemGenericPasswordAttribute>

@end

@implementation YJKeychainItem

#pragma mark - 框架接口
- (void)setMatchingDict:(NSDictionary *)matchingDict {
    _matchingDict = matchingDict;
    _saveDict = [NSMutableDictionary dictionaryWithDictionary:matchingDict];
}

- (NSMutableDictionary *)saveDict {
    if (!_saveDict) {
        _saveDict = [NSMutableDictionary dictionary];
    }
    return _saveDict;
}

#pragma mark - YJKItemAttribute
#pragma mark kSecAttrAccessible
- (NSString *)accessible {
    return [self.saveDict objectForKey:(id)kSecAttrAccessible];
}

- (void)setAccessible:(NSString *)accessible {
    [self.saveDict setObject:accessible forKey:(id)kSecAttrAccessible];
}

#pragma mark kSecAttrAccessGroup
- (NSString *)accessGroup {
    return [self.saveDict objectForKey:(id)kSecAttrAccessGroup];
}

- (void)setAccessGroup:(NSString *)accessGroup {
    [self.saveDict setObject:accessGroup forKey:(id)kSecAttrAccessGroup];
}

#pragma mark kSecAttrLabel
- (NSString *)label {
    return [self.saveDict objectForKey:(id)kSecAttrLabel];
}

- (void)setLabel:(NSString *)label {
    [self.saveDict setObject:label forKey:(id)kSecAttrLabel];
}

#pragma mark - YJKItemGenericPasswordAttribute
#pragma mark kSecAttrCreationDate
- (NSDate *)createDate {
    return [self.saveDict objectForKey:(id)kSecAttrCreationDate];
}

#pragma mark kSecAttrModificationDate
- (NSDate *)modifyDate {
    return [self.saveDict objectForKey:(id)kSecAttrModificationDate];
}

#pragma mark kSecAttrDescription
- (NSString *)desc {
    return [self.saveDict objectForKey:(id)kSecAttrDescription];
}

- (void)setDesc:(NSString *)desc {
    [self.saveDict setObject:desc forKey:(id)kSecAttrDescription];
}

#pragma mark kSecAttrComment
- (NSString *)comment {
    return [self.saveDict objectForKey:(id)kSecAttrComment];
}

- (void)setComment:(NSString *)comment {
    [self.saveDict setObject:comment forKey:(id)kSecAttrComment];
}

#pragma mark kSecAttrCreator
- (NSNumber *)creator {
    return [self.saveDict objectForKey:(id)kSecAttrCreator];
}

- (void)setCreator:(NSNumber *)creator {
    [self.saveDict setObject:creator forKey:(id)kSecAttrCreator];
}

#pragma mark kSecAttrType
- (NSNumber *)type {
    return [self.saveDict objectForKey:(id)kSecAttrType];
}

- (void)setType:(NSNumber *)type {
    [self.saveDict setObject:type forKey:(id)kSecAttrType];
}

#pragma mark kSecAttrIsInvisible
- (Boolean)isInvisible {
    return ((NSNumber *)[self.saveDict objectForKey:(id)kSecAttrIsInvisible]).boolValue;
}

- (void)setIsInvisible:(Boolean)isInvisible {
    [self.saveDict setObject:@(isInvisible) forKey:(id)kSecAttrIsInvisible];
}

#pragma mark kSecAttrIsNegative
- (Boolean)isNegative {
    return ((NSNumber *)[self.saveDict objectForKey:(id)kSecAttrIsNegative]).boolValue;
}

- (void)setIsNegative:(Boolean)isNegative {
    [self.saveDict setObject:@(isNegative) forKey:(id)kSecAttrIsNegative];
}

#pragma mark kSecAttrAccount
- (NSString *)account {
    return [self.saveDict objectForKey:(id)kSecAttrAccount];
}

- (void)setAccount:(NSString *)account {
    [self.saveDict setObject:account forKey:(id)kSecAttrAccount];
}

#pragma mark kSecAttrService
- (NSString *)service {
    return [self.saveDict objectForKey:(id)kSecAttrService];
}

- (void)setService:(NSString *)service {
    [self.saveDict setObject:service forKey:(id)kSecAttrService];
}

#pragma mark kSecAttrGeneric
-(NSData *)generic {
    return [self.saveDict objectForKey:(id)kSecAttrGeneric];
}

- (void)setGeneric:(NSData *)generic {
    [self.saveDict setObject:generic forKey:(id)kSecAttrGeneric];
}

@end
