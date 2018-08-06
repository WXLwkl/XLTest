//
//  MoreViewController.h
//  UIPageViewControllerDemo
//
//  Created by xingl on 16/6/7.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UIWebViewDelegate>


@property (nonatomic, retain) UIWebView *myWebView;
@property (nonatomic, retain) id dataObject;
@end
