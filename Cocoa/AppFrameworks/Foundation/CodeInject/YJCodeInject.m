//
//  YJCodeInject.m
//  Pods
//
//  Created by 阳君 on 2019/3/5.
//

#import "YJCodeInject.h"
#import <dlfcn.h>
#import <objc/runtime.h>
#import <mach-o/dyld.h>
#import <mach-o/getsect.h>
#import <mach-o/ldsyms.h>

#ifdef __LP64__
typedef uint64_t YJCIExportValue;
typedef struct section_64 YJCIExportSection;
#define YJCIGetSectByNameFromHeader getsectbynamefromheader_64
#else
typedef uint32_t YJCIExportValue;
typedef struct section YJCIExportSection;
#define YJCIGetSectByNameFromHeader getsectbynamefromheader
#endif

void RAMExecuteFunction(char *key) {
    Dl_info info;
    dladdr((const void *)&RAMExecuteFunction, &info);
    const YJCIExportValue mach_header = (YJCIExportValue)info.dli_fbase;
    const YJCIExportSection *section = YJCIGetSectByNameFromHeader((void *)mach_header, "__YJCocoa", key);
    if (section == NULL) return;
    int addrOffset = sizeof(struct YJCI_Function);
    for (YJCIExportValue addr = section->offset; addr < section->offset + section->size; addr += addrOffset) {
        struct YJCI_Function entry = *(struct YJCI_Function *)(mach_header + addr);
        entry.function();
    }
}

void RAMExecuteBlock(char *key) {
    Dl_info info;
    dladdr((const void *)&RAMExecuteBlock, &info);
    const YJCIExportValue mach_header = (YJCIExportValue)info.dli_fbase;
    const YJCIExportSection *section = YJCIGetSectByNameFromHeader((void *)mach_header, "__YJCocoa", key);
    if (section == NULL) return;
    int addrOffset = sizeof(struct YJCI_Block);
    for (YJCIExportValue addr = section->offset; addr < section->offset + section->size; addr += addrOffset) {
        struct YJCI_Block entry = *(struct YJCI_Block *)(mach_header + addr);
        if (entry.block) {
            entry.block();
        }
    }
}

@implementation YJCodeInject

+ (void)executeFunctionForKey:(NSString *)key {
    NSString *fKey = [NSString stringWithFormat:@"__%@.func", key?:@""];
    RAMExecuteFunction((char *)[fKey UTF8String]);
}

+ (void)executeBlockForKey:(NSString *)key {
    NSString *fKey = [NSString stringWithFormat:@"__%@.block", key?:@""];
    RAMExecuteBlock((char *)[fKey UTF8String]);
}

@end
