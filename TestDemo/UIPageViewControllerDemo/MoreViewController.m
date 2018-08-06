//
//  MoreViewController.m
//  UIPageViewControllerDemo
//
//  Created by xingl on 16/6/7.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize myWebView=_myWebView;
@synthesize dataObject=_dataObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
}
- (void) viewWillAppear:(BOOL)paramAnimated{
    [super viewWillAppear:paramAnimated];
    [self.myWebView loadHTMLString:_dataObject baseURL:nil];
    [self.view addSubview:self.myWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
