//
//  ViewController.m
//  YJSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJSecurity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testRadom];
    [self testKeyChain];
}

- (void)testRadom {
    NSString *result = randomizationUppercase(32);
    NSLog(result, nil);
    result = randomizationLowercase(32);
    NSLog(result, nil);
    result = randomization(32);
    NSLog(result, nil);
    NSLog(@"%lu", result.length);
}

- (void)testKeyChain {
    // Build Settings -> Code SigningEntitlements - ${SRCROOT}/$(PRODUCT_NAME)/Keychain.plist
    NSMutableDictionary *genericPasswordQuery = [[NSMutableDictionary alloc] init];
    [genericPasswordQuery setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
//    [genericPasswordQuery setObject:identifier forKey:(id)kSecAttrGeneric];
//    [genericPasswordQuery setObject:@"*" forKey:(id)kSecAttrAccessGroup];
    // Use the proper search constants, return only the attributes of the first match.
//    [genericPasswordQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    [genericPasswordQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    
    NSDictionary *tempQuery = [NSDictionary dictionaryWithDictionary:genericPasswordQuery];
    
    CFDictionaryRef result;
    OSStatus r = SecItemCopyMatching((CFDictionaryRef)tempQuery, (CFTypeRef *)&result);
    NSDictionary *outDictionary = (__bridge NSDictionary *)(result);
    NSLog(@"%@", outDictionary);
//    errSecItemNotFound
    
}

@end
