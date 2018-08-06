//
//  ViewController.m
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import "ViewController.h"
#import "DIYScanViewController.h"
#import "StyleDIY.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}
- (void)clicked {
    
    [self openScanVCWithStyle:[StyleDIY ZhiFuBaoStyle]];
}

- (void)openScanVCWithStyle:(ScanViewStyle*)style {
    DIYScanViewController *vc = [DIYScanViewController new];
    vc.style = style;
    vc.isOpenInterestRect = YES;
    vc.scanCodeType = SCT_QRCode;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
