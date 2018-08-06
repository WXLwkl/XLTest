//
//  DetailViewController.m
//  SplitViewController
//
//  Created by yinjia on 16/4/13.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "DetailViewController.h"
#import "MenuViewController.h"
@interface DetailViewController ()


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(300, 100, 200, 50)];
    self.label.text = @"这个是详细视图";
    self.label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.label];
   
    
//    MenuViewController *vc = [[MenuViewController alloc] init];
//    
//    vc.block = ^(NSString *str) {
//        self.label.text = str;
//    };
    
}

- (void)setString:(NSString *)string {
    self.label.text = [NSString stringWithFormat:@"你点击的是第%@行",string];;
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
