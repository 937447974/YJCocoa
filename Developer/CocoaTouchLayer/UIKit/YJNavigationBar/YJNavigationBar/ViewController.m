//
//  ViewController.m
//  YJNavigationBar
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [UINavigationBar appearance];
    self.button.titleLabel.font = [UIFont systemFontOfSize:100];
    [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.button setTitleColor:[[UIColor redColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    UIImage *image = [UIImage imageNamed:@"nav_back"];
//     imageWithRenderingMode:(UIImageRenderingMode)
//    [self.button setImage:image forState:UIControlStateNormal];
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
//    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height) blendMode:kCGBlendModeNormal alpha:0.5];
    [self.button setImage:image forState:UIControlStateNormal];
    [self.button setImage:[self imageByApplyingAlpha:0.5 image:image] forState:UIControlStateHighlighted];
    
}

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
