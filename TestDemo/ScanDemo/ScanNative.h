//
//  ScanNative.h
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScanResult.h"

@interface ScanNative : NSObject

#pragma mark --初始化
/**
 @brief  初始化采集相机
 @param preView 视频显示区域
 @param objType 识别码类型：如果为nil，默认支持很多类型。(二维码QR：AVMetadataObjectTypeQRCode,条码如：AVMetadataObjectTypeCode93Code
 @param block   识别结果
 @return LBXScanNative的实例
 */
- (instancetype)initWithPreView:(UIView*)preView ObjectType:(NSArray*)objType success:(void(^)(NSArray<ScanResult*> *array))block;

/**
 @brief  初始化采集相机
 @param preView 视频显示区域
 @param objType 识别码类型：如果为nil，默认支持很多类型。(二维码如QR：AVMetadataObjectTypeQRCode,条码如：AVMetadataObjectTypeCode93Code
 @param cropRect 识别区域，值CGRectZero 全屏识别
 @param block   识别结果
 @return LBXScanNative的实例
 */
- (instancetype)initWithPreView:(UIView*)preView ObjectType:(NSArray*)objType cropRect:(CGRect)cropRect
                        success:(void(^)(NSArray<ScanResult*> *array))block;

#pragma mark --设备控制

/** 开始扫码 */
- (void)startScan;

/** 停止扫码 */
- (void)stopScan;

/** 开启关闭闪光灯 */
- (void)setTorch:(BOOL)torch;

/** 自动根据闪关灯状态去改变 */
- (void)changeTorch;

/** 修改扫码类型：二维码、条形码 */
- (void)changeScanType:(NSArray*)objType;

/** 设置扫码成功后是否拍照 */
- (void)setNeedCaptureImage:(BOOL)isNeedCaputureImg;

#pragma mark --镜头
/** 获取摄像机最大拉远镜头 */
- (CGFloat)getVideoMaxScale;

/** 拉近拉远镜头 */
- (void)setVideoScale:(CGFloat)scale;

#pragma mark --识别图片
/** 识别QR二维码图片,ios8.0以上支持 */
//+ (void)recognizeImage:(UIImage*)image success:(void(^)(NSArray<ScanResult*> *array))block;

@end
