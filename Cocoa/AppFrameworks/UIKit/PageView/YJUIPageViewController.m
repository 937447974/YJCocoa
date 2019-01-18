//
//  YJUIPageViewController.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/6/10.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import "YJUIPageViewController.h"

@interface YJUIPageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YJUIPageViewController

- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options {
    self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    if (self) {
        self.manager = [[YJUIPageViewManager alloc] initWithPageViewController:self];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.manager = [[YJUIPageViewManager alloc] initWithPageViewController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for(UIScrollView *subview in self.view.subviews) {
        if([subview isKindOfClass:UIScrollView.class]) {
            self.scrollView = subview;
        }
    }
}

- (void)reloadData {
    [self.manager reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    [self.pageDelegate pageViewController:self didScrollOffset:(scrollView.contentOffset.x - width)/width];
}

#pragma mark - getter & setter
- (NSMutableArray<YJUIPageViewCellObject *> *)dataSourcePlain {
    return self.manager.dataSourcePlain;
}

- (void)setDataSourcePlain:(NSMutableArray<YJUIPageViewCellObject *> *)dataSourcePlain {
    self.manager.dataSourcePlain = dataSourcePlain;
}

- (void)setPageDelegate:(id<YJUIPageViewControllerDelegate>)pageDelegate {
    _pageDelegate = pageDelegate;
    self.scrollView.delegate = self;
}

@end
