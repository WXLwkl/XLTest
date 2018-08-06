//
//  ViewController.m
//  show
//
//  Created by yinjia on 16/3/4.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "ViewController.h"
#import <MyFramework/MyFramework.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}
- (IBAction)show:(UIButton *)sender {
    [Myobject show:@"这是一个测试alert"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
