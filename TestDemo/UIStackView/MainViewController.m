//
//  MainViewController.m
//  UIStackView
//
//  Created by xingl on 16/4/15.
//  Copyright © 2016年 yinjia. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor redColor]];
    
    
    NSLog(@"-----");
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    //创建集合视图
    UIStackView *stack = [[UIStackView alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    
    //设置摆放方向 水平
    stack.axis = UILayoutConstraintAxisHorizontal;
    
    //对其方式
    stack.alignment = UIStackViewAlignmentCenter;
    
    //分布方式
    stack.distribution = UIStackViewDistributionEqualSpacing;
    
    UIImageView *img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    [stack addArrangedSubview:img1];
    
    UIImageView *img2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.png"]];
    [stack addArrangedSubview:img2];
    
    UIImageView *img3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.png"]];
    [stack addArrangedSubview:img3];
    
    UIImageView *img4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4.png"]];
    [stack addArrangedSubview:img4];
    
    [self.view addSubview:stack];
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
