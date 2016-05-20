//
//  ViewController.h
//  YJAutoLayout
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by 阳君 on 16/4/22.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSInteger (^ Block)(NSInteger c);

@interface ViewController : UIViewController

@property (nonatomic, copy) Block block;

@end

