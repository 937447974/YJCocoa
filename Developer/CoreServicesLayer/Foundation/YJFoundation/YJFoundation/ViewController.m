//
//  ViewController.m
//  YJFoundation
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJFoundation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = [NSArray arrayWithObjects:@"阳君", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSSet *set = [NSSet setWithObjects:@"937447974", @"阳君", dict, nil];
    array = [NSArray arrayWithObjects:@"阳君", dict, set, nil];
    dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSLog(@"%@", dict);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
