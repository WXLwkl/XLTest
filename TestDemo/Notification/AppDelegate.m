//
//  AppDelegate.m
//  aa
//
//  Created by xingl on 16/5/6.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        //iOS8以后需要注册
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //创建要注册的通知类型，必须
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
            //注册通知类型
            [application registerUserNotificationSettings:settings];
            //
            //注册远程通知，才可以获取用户的devicetoken
            [application registerForRemoteNotifications];
        } else {
            //iOS8之前不需要注册
            [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
        }
    }
    
    
    
    //    创建本地推送
    UILocalNotification *localN = [[UILocalNotification alloc] init];
    //设置推送时间
    localN.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    //    设置推送正文
    localN.alertBody = @"这是第一条本地推送消息";
    localN.userInfo = @{@"key":@"1"};
    
    //    创建本地推送
    UILocalNotification *localN1 = [[UILocalNotification alloc] init];
    //设置推送时间
    localN1.fireDate = [NSDate dateWithTimeIntervalSinceNow:20];
    //    设置推送正文
    localN1.alertBody = @"这是第二条本地推送消息";
    localN1.userInfo = @{@"key":@"3"};
    
    
    application.applicationIconBadgeNumber = [application scheduledLocalNotifications].count;
    //注册推送
    [application setScheduledLocalNotifications:@[localN,localN1]];
    
    //已经开启的本地推送
    NSArray *array = [application scheduledLocalNotifications];
    //取消某个本地推送
    for (UILocalNotification *noti in array) {
        if ([[noti.userInfo objectForKey:@"key"] isEqualToString:@"2"]) {
            [application cancelLocalNotification:noti];
            break;
        }
    }
    
    return YES;
}
//收到本地推送时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本地推送" message:notification.alertBody delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}
//获得推送token之后的回调
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    //得到token之后，把token发送给APP的服务器。
    
    NSLog(@"%@",deviceToken);
    
    
    //671f6d16ddf7a999d15ddaa485153834505e9c3a499a058655286feb9568ca42
}

//收到远程推送通知时调用。
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    //    NSString *title = [userInfo objectForKey:@"aps"];
    //
    //    NSString *msg = [userInfo objectForKey:@"alert"];
    NSLog(@"收到推送了");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收到推送了" message:[NSString stringWithFormat:@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
