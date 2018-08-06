//
//  AppDelegate.m
//  SplitViewController
//
//  Created by yinjia on 16/4/13.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "DetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc]init];
    
    //菜单控制器
    MenuViewController *menu = [[MenuViewController alloc] init];
    //菜单控制器的导航
    UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:menu];
    //详细视图控制器
    DetailViewController *detail = [[DetailViewController alloc] init];
    
    menu.Delegate = detail;
    
    menu.block = ^(NSString *str) {
        detail.label.text = str;
    };

    
    
    //详细视图的导航
    UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:detail];
    
    //定制导航控制器对象集合
    NSArray *vcs = [[NSArray alloc] initWithObjects:menuNav,detailNav, nil];
    //创建分割视图控制器
    UISplitViewController *split = [[UISplitViewController alloc] init];
    [split setViewControllers:vcs];
    
    self.window.rootViewController = split;
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
