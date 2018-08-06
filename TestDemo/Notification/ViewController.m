//
//  ViewController.m
//  aa
//
//  Created by xingl on 16/5/6.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
- (void)clicked:(UIButton *)sender {

    //1.创建本地通知对象
    UILocalNotification *ln = [[UILocalNotification alloc] init];
    //2.设置通知属性
    //音效文件名
    ln.soundName = nil;
    //通知的具体内容
    ln.alertBody = @"重大消消:qwertyuiopasdfghjklzxcvbnm";
    //锁屏界面显示的小标题("滑动来" +alertAction)
    ln.alertAction = @"查看新闻";


    //通知第一次发出的时间(5秒后发出)
    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //设置时区
    ln.timeZone = [NSTimeZone defaultTimeZone];

    //设置app图标数字
    ln.applicationIconBadgeNumber = 10;
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:ln];


    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {

        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;

        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        ln.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        //        ln.repeatInterval = NSDayCalendarUnit;
    }

    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
