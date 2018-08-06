//
//  ViewController.h
//  UIPageViewControllerDemo
//
//  Created by xingl on 16/6/7.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPageViewControllerDataSource>


@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *pageContent;
@end

