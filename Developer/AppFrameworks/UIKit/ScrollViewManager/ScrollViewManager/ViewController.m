//
//  ViewController.m
//  ScrollViewManager
//
//  Created by 阳君 on 2016/12/22.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJUIScrollViewManager.h"

@interface ViewController () <UIScrollViewDelegate, YJUIScrollViewManagerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) YJUIScrollViewManager *scrollViewManager; ///< YJUIScrollViewManager

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollViewManager = [[YJUIScrollViewManager alloc] initWithScrollView:self.scrollView];
    self.scrollViewManager.edgeInset = UIEdgeInsetsMake(50, 50, 50, 50); // 正边缘
    self.scrollViewManager.endInset = UIEdgeInsetsMake(-20, -20, -20, -20); // 负边界
    self.scrollViewManager.delegate = self;
    [self.scrollViewManager addScrollViewAOPDelegate:self];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - YJUIScrollViewManagerDelegate
- (void)scrollViewManager:(YJUIScrollViewManager *)manager didVerticalScroll:(YJUIScrollViewScroll)scroll {
    NSLog(@"%@ -- %ld", NSStringFromSelector(_cmd), scroll);
}

- (void)scrollViewManager:(YJUIScrollViewManager *)manager didHorizontalScroll:(YJUIScrollViewScroll)scroll {
    NSLog(@"%@ -- %ld", NSStringFromSelector(_cmd), scroll);
}

@end
