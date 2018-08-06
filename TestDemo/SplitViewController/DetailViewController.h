//
//  DetailViewController.h
//  SplitViewController
//
//  Created by yinjia on 16/4/13.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuViewController.h"

@interface DetailViewController : UIViewController <PassValue>

@property (nonatomic,retain) UILabel *label;

@property (nonatomic,copy) NSString *str;


@end
