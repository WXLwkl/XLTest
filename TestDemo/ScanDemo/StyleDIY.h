//
//  StyleDIY.h
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScanViewStyle.h"

@interface StyleDIY : NSObject

#pragma mark -模仿qq界面
+ (ScanViewStyle*)qqStyle;

#pragma mark --模仿支付宝
+ (ScanViewStyle*)ZhiFuBaoStyle;

#pragma mark -无边框，内嵌4个角
+ (ScanViewStyle*)InnerStyle;

#pragma mark -无边框，内嵌4个角
+ (ScanViewStyle*)weixinStyle;

#pragma mark -框内区域识别
+ (ScanViewStyle*)recoCropRect;

#pragma mark -4个角在矩形框线上,网格动画
+ (ScanViewStyle*)OnStyle;

#pragma mark -自定义4个角及矩形框颜色
+ (ScanViewStyle*)changeColor;

#pragma mark -改变扫码区域位置
+ (ScanViewStyle*)changeSize;

#pragma mark -非正方形，可以用在扫码条形码界面
+ (ScanViewStyle*)notSquare;

@end
