//
//  ScanView.h
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScanViewStyle.h"

@interface ScanView : UIView

- (instancetype)initWithFrame:(CGRect)frame style:(ScanViewStyle *)style;

/**
 *  设备启动中文字提示
 */
- (void)startDeviceReadyingWithText:(NSString*)text;

/**
 *  设备启动完成
 */
- (void)stopDeviceReadying;

/**
 *  开始扫描动画
 */
- (void)startScanAnimation;

/**
 *  结束扫描动画
 */
- (void)stopScanAnimation;


/**
 @brief  根据矩形区域，获取Native扫码识别兴趣区域
 @param view  视频流显示UIView
 @param style 效果界面参数
 @return 识别区域
 */
+ (CGRect)getScanRectWithPreView:(UIView*)view style:(ScanViewStyle*)style;

@end
