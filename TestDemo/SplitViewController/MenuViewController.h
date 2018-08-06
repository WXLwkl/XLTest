//
//  MenuViewController.h
//  SplitViewController
//
//  Created by yinjia on 16/4/13.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PassValue <NSObject>

- (void)setString:(NSString *)string;

@end


typedef void(^StringBlock)(NSString *);



@interface MenuViewController : UITableViewController

@property (nonatomic,assign) id<PassValue> Delegate;

@property (nonatomic,copy) StringBlock block;

@end
