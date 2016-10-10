//
//  ViewController.m
//  YJInputLength
//
//  Created by admin on 16/5/26.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJInputLength.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textField.inputLength = 10;
    self.textView.inputLength = 50;
    NSLog(@"%ld", (long)self.textField.inputLength);
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.inputLength = 10;
    textView = nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
