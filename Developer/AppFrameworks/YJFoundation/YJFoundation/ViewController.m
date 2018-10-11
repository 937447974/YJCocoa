//
//  ViewController.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJDispatch.h"
#import "YJFoundation.h"

#import "YJTestURLSessionTask.h"
#import "YJTestURLRequestModel.h"
#import "YJNSURLResponseModel.h"

@interface ViewController1 : NSObject

@property (nonatomic, copy) NSSet *set; ///<

@end

@implementation ViewController1
@end

@interface ViewController () <NSCacheDelegate>

@property (nonatomic, copy) NSString *str; ///<
@property (nonatomic, strong) YJNSCache *cache; ///<

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testAOP];
//    [self testSingleton];
    [self testTimer];
    [self testCalendar];
//    [self testURLSession];
//    [self testSwizzling];
//    [self testLog];
//    [self testKVO];
//    [self testNotificationCenter];
//    [self testCache];
}

#pragma mark - AOP
- (void)testAOP {
    YJNSAspectOrientProgramming *aop = YJNSAspectOrientProgramming.new;
    ViewController *v = (ViewController *)aop;
    NSLog(@"%@", [v testAOPSelector]);
    [v testAOPSelector1];
    NSLog(@"%d", [v testAOPSelector2]);
    [aop addTarget:self];
    NSLog(@"%@", [v testAOPSelector]);
    [v testAOPSelector1];
    NSLog(@"%d", [v testAOPSelector2]);
}

- (UIView *)testAOPSelector {
    NSLog(@"dodo");
    return UIView.new;
}

- (void)testAOPSelector1 {}

- (BOOL)testAOPSelector2 {
    return YES;
}



#pragma mark - log
- (void)testLog {
    NSArray *array = [NSArray arrayWithObjects:@"阳君", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSSet *set = [NSSet setWithObjects:@"937447974", @"阳君", dict, nil];
    array = [NSArray arrayWithObjects:@"阳君", dict, set, nil];
    dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSLog(@"%@", dict);
}

#pragma mark - 单例
- (void)testSingleton {
    for (int i = 0; i < 3; i++) {
        //异步执行队列任务
        dispatch_async_default(^{
            NSLog(@"0-%@", YJNSSingletonS(ViewController, nil));
        });
        dispatch_async_default(^{
            NSLog(@"1-%@", YJNSSingletonS(ViewController, @"private1"));
        });
        dispatch_async_default(^{
            NSLog(@"2-%@", YJNSSingletonW(ViewController, @"private2"));
        });
        dispatch_async_default(^{
            NSLog(@"3-%@", YJNSSingletonW(ViewController, @"private3"));
        });
        dispatch_async_default(^{
            NSLog(@"4-%@", YJNSSingletonW(ViewController, @"private4"));
        });
        dispatch_async_default(^{
            NSLog(@"5-%@", YJNSSingletonW(ViewController, @"private5"));
        });
    }
    dispatch_after_main(1, ^{
        [NSNotificationCenter.defaultCenter postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    });
    NSLog(@"dispatch_queue_create");
}

#pragma mark - 倒计时
- (void)testTimer {
    for (int i=0; i<1; i++) {
        YJNSTimer *timer = [YJNSTimer timerIdentifier:nil target:self completionHandler:^(YJNSTimer *timer) {
            NSLog(@"%@ day:%ld; hour:%ld; minute:%ld; second:%ld;", timer.identifier, timer.day, timer.hour, timer.minute, timer.second);
        }];
        timer.timeInterval = 3;
        timer.time = 10;
        timer.countdown = YES;
        [timer run];
    }
}


#pragma mark - Calendar
- (void)testCalendar {
    YJNSCalendar *calendar = YJNSCalendar.currentCalendar;
    NSLog(@"day:%ld; hour:%ld; minute:%ld; second:%ld;", calendar.day, calendar.hour, calendar.minute, calendar.second);
}

#pragma mark - URLSession
- (void)testURLSession {
    YJTestURLRequestModel *requestModel = [[YJTestURLRequestModel alloc] init];
    requestModel.name = @"阳君";
    requestModel.qq = @"557445088";
    YJNSURLRequest *request = [YJNSURLRequest requestWithSource:nil url:@"https://github.com/937447974/YJCocoa" reqMethod:YJNSURLRequestMethodPOST reqModel:requestModel respModelClass:YJNSURLResponseModel.class];
    [[[YJTestURLSessionTask taskWithRequest:request] completionHandler:^(YJNSURLResponseModel *responseModel) {
        NSLog(@"获取服务器数据:%@", responseModel.modelDictionary);
        [[YJTestURLSessionTask taskWithRequest:request] cancel]; // 取消请求
    } failure:^(NSError *error) {
        request.supportResume = YES; // 开启断网重连
        [YJNSURLSession resumeAllNeedTask];// 断网重连
    }] resume]; // 发出请求
}

#pragma mark - Swizzling
- (void)testSwizzling {
    /*
     // 分组多线程交换测试
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
     dispatch_group_t group = dispatch_group_create();
     for (int i = 0; i < 20; i++) {
     dispatch_group_async(group, queue, ^{
     NSLog(@"dispatch_group_async:%d", i);
     [self.class swizzlingSEL:@selector(testSwizzlingInstance) withSEL:@selector(swizzling_testSwizzlingInstance)];
     });
     }
     dispatch_group_notify(group, queue, ^{
     NSLog(@"dispatch_group_notify");
     [self testSwizzlingInstance];
     // 多次交换
     [self.class swizzlingSEL:@selector(testSwizzlingInstance) withSEL:@selector(swizzling_testSwizzlingInstance)];
     [self testSwizzlingInstance];
     [self.class swizzlingSEL:@selector(swizzling_testSwizzlingInstance) withSEL:@selector(testSwizzlingInstance)];
     [self testSwizzlingInstance];
     });
     */
    // class方法交换
    [self.class swizzlingClassSEL:@selector(testSwizzlingClass) withSEL:@selector(swizzling_testSwizzlingClass)];
    [self.class testSwizzlingClass];
}

- (void)testSwizzlingInstance {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)swizzling_testSwizzlingInstance{
    [self swizzling_testSwizzlingInstance];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)testSwizzlingClass {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)swizzling_testSwizzlingClass {
    [self swizzling_testSwizzlingClass];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - KVO
- (void)testKVO {
    ViewController *target = [ViewController new];
    ViewController *observer = [ViewController new];
    [target addObserver:observer forKeyPath:@"str" kvoBlock:^(id oldValue, id newValue) {
        NSLog(@"1-%@-%@", oldValue, newValue);
    }];
    [target addObserver:observer forKeyPath:@"str" kvoBlock:^(id oldValue, id newValue) {
        NSLog(@"2-%@-%@", oldValue, newValue);
    }];
    target.str = @"YJ";
    target.str = @"YJ";
    [target removeKVObserver:observer forKeyPath:nil];// 全移除
    target.str = @"YJ1";
    [target addObserver:observer forKeyPath:@"str" kvoBlock:^(id oldValue, id newValue) {
        NSLog(@"3-%@-%@", oldValue, newValue);
    }];
    target.str = @"YJ3";
    [target removeKVObserver:observer forKeyPath:@"str"];// 路径移除
    target.str = @"YJ3";
    [target addObserver:observer forKeyPath:@"str" kvoBlock:^(id oldValue, id newValue) {
        NSLog(@"4-%@-%@", oldValue, newValue);
    }];
    target.str = @"YJ4";
    observer = nil; // 自动移除
    target.str = @"YJ4";
    [target removeKVObserver:observer forKeyPath:nil];// 重复移除崩溃测试
}

#pragma mark - NotificationCenter
- (void)testNotificationCenter {
    NSObject *test = [NSObject new];
    [NSNotificationCenter.defaultCenter addObserver:test name:@"test" usingBlock:^(NSNotification *note) {
        NSLog(@"%@", note);
    }];
    [NSNotificationCenter.defaultCenter postNotificationName:@"test" object:nil userInfo:@{@"1":@"1"}];
    dispatch_async_main(^{
        [NSNotificationCenter.defaultCenter postNotificationName:@"test" object:nil userInfo:@{@"1":@"2"}];
    });
}

#pragma mark - Cache
- (void)testCache {
    self.cache = YJNSCache.new;
    self.cache.delegate = self;
    self.cache.countLimit = 9999;
    [self.cache setObject:@"1" forKey:@"1"];
    [self.cache setObject:@"2" forKey:@"2"];
    [self.cache setObject:ViewController.new forKey:@"private"];
    [self.cache setObject:ViewController.new forKey:@"private2"];
    [self.cache setObject:ViewController.new forKey:@"private3"];
    self.cache.countLimit = 1;
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"%@%@", NSStringFromSelector(_cmd), obj);
}

@end
