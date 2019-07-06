//
//  YJCodeInject.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/3/5.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** YJScheduler 调度器订阅、拦截加载*/
#define YJSCHEDULER_LOAD(block) YJCI_BLOCK_EXPORT(YJSchedulerLoad, block)
/** YJURLRouter 路由懒加载*/
#define YJURLROUTER_LOAD(block) YJCI_BLOCK_EXPORT(YJURLRouterLoad, block)

struct YJCI_Function {
    char *key;
    void (*function)(void);
};

struct YJCI_Block {
    char *key;
    __unsafe_unretained void (^block)(void);
};

// 存储 function
#define YJCI_FUNCTION_EXPORT(key) \
static void _ci##key(void); \
__attribute__((used, section("__YJCocoa,"#key"f"))) \
static const struct YJCI_Function __F##key = (struct YJCI_Function){(char *)(&#key), (void *)(&_ci##key)}; \
static void _ci##key
// 执行 function
#define YJCI_FUNCTION_EXECUTE(key) [YJCodeInject executeFunctionForKey:@""#key""];

// 存储 block
#define YJCI_BLOCK_EXPORT(key, block) \
__attribute__((used, section("__YJCocoa,"#key"b"))) \
static const struct YJCI_Block __B##key = (struct YJCI_Block){((char *)&#key), block};
// 执行 block
#define YJCI_BLOCK_EXECUTE(key) [YJCodeInject executeBlockForKey:@""#key""];


/** 代码注入*/
@interface YJCodeInject : NSObject

/**
 *  @abstract 执行注册为 key 的 function
 *
 *  @param key function 的 key
 */
+ (void)executeFunctionForKey:(NSString *)key;

/**
 *  @abstract 执行注册为key的block
 *
 *  @param key block 的 key
 */
+ (void)executeBlockForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
