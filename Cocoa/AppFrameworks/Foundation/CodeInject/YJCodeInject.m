//
//  YJCodeInject.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/3/5.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#import "YJCodeInject.h"
#import <mach-o/dyld.h>
#import <mach-o/getsect.h>

@implementation YJCodeInject

+ (void)executeFunctionForKey:(NSString *)key {
    NSString *sectname = [NSString stringWithFormat:@"%@f", key];
    uint64_t addrOffset = sizeof(struct YJCI_Function);
    [self executeMatchForSectname:sectname completionHandler:^(const uint64_t mach_header, const struct section_64 *section) {
        for (uint64_t addr = section->offset; addr < section->offset + section->size; addr += addrOffset) {
            struct YJCI_Function entry = *(struct YJCI_Function *)(mach_header + addr);
            entry.function();
        }
    }];
}

+ (void)executeBlockForKey:(NSString *)key {
    NSString *sectname = [NSString stringWithFormat:@"%@b", key];
    uint64_t addrOffset = sizeof(struct YJCI_Block);
    [self executeMatchForSectname:sectname completionHandler:^(const uint64_t mach_header, const struct section_64 *section) {
        for (uint64_t addr = section->offset; addr < section->offset + section->size; addr += addrOffset) {
            struct YJCI_Block entry = *(struct YJCI_Block *)(mach_header + addr);
            !entry.block ?: entry.block();
        }
    }];
}

+ (void)executeMatchForSectname:(NSString *)sectname completionHandler:(void (^)(const uint64_t mach_header, const struct section_64 *section))handler {
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count; ++i) {
#if TARGET_IPHONE_SIMULATOR
        if (strstr(_dyld_get_image_name(i), "/Users/") == NULL) continue;
#else
        if (strstr(_dyld_get_image_name(i), "/var/") == NULL) continue;
#endif
        const uint64_t mach_header = (uint64_t)_dyld_get_image_header(i);
        const struct section_64 *section = getsectbynamefromheader_64((void *)mach_header, "__YJCocoa", sectname.UTF8String);
        if (section == NULL) continue;
        handler(mach_header, section);
    }
}

@end
