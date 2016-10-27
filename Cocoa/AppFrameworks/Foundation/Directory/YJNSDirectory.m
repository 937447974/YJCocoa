//
//  YJNSDirectory.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/12.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSDirectory.h"

@implementation YJNSDirectory

- (instancetype)init {
    self = [super init];
    if (self) {
        _homePath = NSHomeDirectory();
        _documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        _cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        _tempPath = NSTemporaryDirectory();
        
        _homeURL = [NSURL fileURLWithPath:_homePath];
        _documentURL = [NSURL fileURLWithPath:_documentPath];
        _libraryURL = [NSURL fileURLWithPath:_libraryPath];
        _cachesURL = [NSURL fileURLWithPath:_cachesPath];
        _tempURL = [NSURL fileURLWithPath:_tempPath];
    }
    return self;
}

@end
