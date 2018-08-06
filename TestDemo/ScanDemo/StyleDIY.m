//
//  StyleDIY.m
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import "StyleDIY.h"
#import <AVFoundation/AVFoundation.h>

@implementation StyleDIY

#pragma mark -模仿qq界面
+ (ScanViewStyle*)qqStyle
{
    //设置扫码区域参数设置
    
    //创建参数对象
    ScanViewStyle *style = [[ScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = ScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = ScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"qrcode_scan_light_green"];
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    return style;
}

#pragma mark --模仿支付宝
+ (ScanViewStyle*)ZhiFuBaoStyle
{
    //设置扫码区域参数
    ScanViewStyle *style = [[ScanViewStyle alloc]init];
    style.centerUpOffset = 60;
    style.xScanRetangleOffset = 30;
    
    if ([UIScreen mainScreen].bounds.size.height <= 480 )
    {
        //3.5inch 显示的扫码缩小
        style.centerUpOffset = 40;
        style.xScanRetangleOffset = 20;
    }
    
    style.photoframeAngleStyle = ScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    
    style.isNeedShowRetangle = NO;
    style.anmiationStyle = ScanViewAnimationStyle_NetGrid;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    //使用的支付宝里面网格图片
    UIImage *imgFullNet = [UIImage imageNamed:@"qrcode_scan_full_net"];
    style.animationImage = imgFullNet;
    
    return style;
}

#pragma mark -无边框，内嵌4个角
+ (ScanViewStyle*)InnerStyle
{
    //设置扫码区域参数
    ScanViewStyle *style = [[ScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = ScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 3;
    style.photoframeAngleW = 18;
    style.photoframeAngleH = 18;
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = ScanViewAnimationStyle_LineMove;
    
    //qq里面的线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    style.animationImage = imgLine;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    return style;
}

#pragma mark -无边框，内嵌4个角
+ (ScanViewStyle*)weixinStyle
{
    //设置扫码区域参数
    ScanViewStyle *style = [[ScanViewStyle alloc]init];
    
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = ScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2;
    style.photoframeAngleW = 18;
    style.photoframeAngleH = 18;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = ScanViewAnimationStyle_LineMove;
    style.colorAngle = [UIColor colorWithRed:0./255 green:200./255. blue:20./255. alpha:1.0];
    
    //qq里面的线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_Scan_weixin_Line"];
    style.animationImage = imgLine;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    return style;
}

#pragma mark -框内区域识别
+ (ScanViewStyle*)recoCropRect
{
    //设置扫码区域参数
    ScanViewStyle *style = [[ScanViewStyle alloc]init];
    
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = ScanViewPhotoframeAngleStyle_On;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = ScanViewAnimationStyle_NetGrid;
    //矩形框离左边缘及右边缘的距离
    style.xScanRetangleOffset = 80;
    
    //使用的支付宝里面网格图片
    UIImage *imgPartNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];
    style.animationImage = imgPartNet;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    return style;
}

#pragma mark -4个角在矩形框线上,网格动画
+ (ScanViewStyle*)OnStyle
{
    //设置扫码区域参数
    ScanViewStyle *style = [[ScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = ScanViewPhotoframeAngleStyle_On;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = ScanViewAnimationStyle_NetGrid;
    
    //使用的支付宝里面网格图片
    UIImage *imgPartNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];
    style.animationImage = imgPartNet;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    return style;
}

#pragma mark -自定义4个角及矩形框颜色
+ (ScanViewStyle*)changeColor
{
    //设置扫码区域参数
    ScanViewStyle *style = [[ScanViewStyle alloc]init];
    
    style.centerUpOffset = 44;
    //扫码框周围4个角的类型设置为在框的上面
    style.photoframeAngleStyle = ScanViewPhotoframeAngleStyle_On;
    //扫码框周围4个角绘制线宽度
    style.photoframeLineW = 6;
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    //显示矩形框
    style.isNeedShowRetangle = YES;
    //动画类型：网格形式，模仿支付宝
    style.anmiationStyle = ScanViewAnimationStyle_NetGrid;
    
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];;
    //码框周围4个角的颜色
    style.colorAngle = [UIColor colorWithRed:65./255. green:174./255. blue:57./255. alpha:1.0];
    //矩形框颜色
    style.colorRetangleLine = [UIColor colorWithRed:247/255. green:202./255. blue:15./255. alpha:1.0];
    //非矩形框区域颜色
    style.notRecoginitonArea = [UIColor colorWithRed:247./255. green:202./255 blue:15./255 alpha:0.2];
    
    return style;
}

#pragma mark -改变扫码区域位置
+ (ScanViewStyle*)changeSize
{
    //设置扫码区域参数
    ScanViewStyle *style = [[ScanViewStyle alloc]init];
    
    //矩形框向上移动
    style.centerUpOffset = 60;
    //矩形框离左边缘及右边缘的距离
    style.xScanRetangleOffset = 100;
    
    style.photoframeAngleStyle = ScanViewPhotoframeAngleStyle_On;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = ScanViewAnimationStyle_LineMove;
    
    //qq里面的线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    style.animationImage = imgLine;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    return style;
}

#pragma mark -非正方形，可以用在扫码条形码界面

+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (ScanViewStyle*)notSquare
{
    //设置扫码区域参数
    ScanViewStyle *style = [[ScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = ScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 4;
    style.photoframeAngleW = 28;
    style.photoframeAngleH = 16;
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = ScanViewAnimationStyle_LineStill;
    style.animationImage = [[self class] createImageWithColor:[UIColor redColor]];
    //非正方形
    //设置矩形宽高比
    style.whRatio = 4.3/2.18;
    //离左边和右边距离
    style.xScanRetangleOffset = 30;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    
    return style;
}

@end
