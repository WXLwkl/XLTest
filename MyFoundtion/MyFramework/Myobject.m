//
//  Myobject.m
//  MyFramework
//
//  Created by yinjia on 16/3/4.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "Myobject.h"
#import <UIKit/UIKit.h>

@implementation Myobject

+(void)show:(NSString *)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}


@end
