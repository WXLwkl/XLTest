//
//  ViewController.m
//  Demo
//
//  Created by 兴林 on 2016/10/12.
//  Copyright © 2016年 兴林. All rights reserved.
//

#import "ViewController.h"
#import "XLAnimation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom;
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
    
    [arr addObject:[XLAnimation replicatorLayer_Circle]];
    [arr addObject:[XLAnimation replicatorLayer_Wave]];
    [arr addObject:[XLAnimation replicatorLayer_Triangle]];
    [arr addObject:[XLAnimation replicatorLayer_Grid]];
    
    CGFloat radius = self.view.bounds.size.width/2;
    
    for (NSInteger loop = 0; loop < arr.count; loop++) {
        NSInteger col = loop%2;
        NSInteger row = loop/2;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(radius*col, radius*row, radius, radius)];
        view.backgroundColor = [UIColor grayColor];
        
        [view.layer addSublayer:[arr objectAtIndex:loop]];
        [self.view addSubview:view];
    }
    
    
    
}
































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
