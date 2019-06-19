//
//  YJMemoryInfo.m
//  YJMemoryInfo
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/3/15.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <mach/mach.h>
#import "YJMemoryInfo.h"

@implementation YJMemoryInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        _physicalMB = NSProcessInfo.processInfo.physicalMemory / 1048576.0; // 1048576.0 = 1024*1024
        vm_statistics_data_t vmStats;
        mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
        kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
        if (kernReturn == KERN_SUCCESS) {
            _freeMB = vmStats.free_count * vm_page_size / 1048576.0;
            _activeMB = vmStats.active_count * vm_page_size / 1048576.0;
            _inactiveMB = vmStats.inactive_count * vm_page_size / 1048576.0;
            _wireMB = vmStats.wire_count * vm_page_size / 1048576.0;
        }
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"YJMemoryInfo:{\n\tphysical: %.3f\n\tfree: %.3f\n\tinactive: %.3f\n\tactive: %.3f\n\twire: %.3f\n}", self.physicalMB, self.freeMB, self.inactiveMB, self.activeMB, self.wireMB];
}

@end
