//
//  ViewController.m
//  YJDispatch
//
//  Created by admin on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJDispatch.h"

@interface ViewController () {
    dispatch_queue_t _queue;
    dispatch_source_t _timer;
    pthread_mutex_t _lock;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    for (int i = 0; i<1000; i++) {
    ////        dispatch_async_concurrent(^{
    ////            NSLog(@"dispatc:%d", i);
    ////
    ////        });
    //        dispatch_sync_serial("1", ^{
    //            NSLog(@"dispatch_get_global_queue:%d", i);
    ////            [NSThread sleepForTimeInterval:0.002];
    //        });
    ////        dispatch_async_concurrent(^{
    ////            NSLog(@"----:%d", i);
    ////        });
    //    }

    /*
    {
        __weakSelf
        dispatch_async_main(^{
            __strongSelf
            [strongSelf test:@"async"];
        });
        dispatch_sync_main(^{
            [weakSelf test:@"sync"];
        });
        NSLog(@"2");
        _timer = dispatch_timer(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), 3, ^{
            NSLog(@"1");
        });
    }
     */
    
    {
        @finally_execute {
            NSLog(@"finally_execute{}");
        };
        NSLog(@"finally_execute");
    }
    NSLog(@"finally_execute \n finally_execute{}");
    
    pthread_mutex_init(&_lock, NULL);
    {
        @synchronized_pthread (_lock)
    }
    pthread_mutex_destroy(&_lock);
}

- (void)test:(NSString *)str {
    NSLog(str, nil);
}

@end
