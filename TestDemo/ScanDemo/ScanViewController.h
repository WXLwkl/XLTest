//
//  ScanViewController.h
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanView.h"
#import "ScanViewStyle.h"
#import "ScanNative.h"




// @[@"QRCode",@"BarCode93",@"BarCode128",@"BarCodeITF",@"EAN13"];
typedef NS_ENUM(NSInteger, SCANCODETYPE) {
    SCT_QRCode, //QR二维码
    SCT_BarCode93,
    SCT_BarCode128,//支付条形码(支付宝、微信支付条形码)
    SCT_BarCodeITF,//燃气回执联 条形码?
    SCT_BarEAN13 //一般用做商品码
};


@interface ScanViewController : UIViewController


/**
 当前选择的识别码制
 */
@property (nonatomic, assign) SCANCODETYPE scanCodeType;

/**
 @brief  启动区域识别功能
 */
@property(nonatomic,assign) BOOL isOpenInterestRect;

/**
 @brief 是否需要扫码图像
 */
@property (nonatomic, assign) BOOL isNeedScanImage;


/**
 @brief  扫码功能封装对象
 */
@property (nonatomic,strong) ScanNative *scanObj;

/** 扫码区域视图 */
@property (nonatomic, strong) ScanView *qrScanView;


/**
 @brief  扫码存储的当前图片
 */
@property (nonatomic, strong) UIImage *scanImage;

/**
 相机启动提示,如 相机启动中...
 */
@property (nonatomic, copy) NSString *cameraInvokeMsg;

/**
 *  界面效果参数
 */
@property (nonatomic, strong) ScanViewStyle *style;


//启动扫描
- (void)reStartDevice;

//关闭扫描
- (void)stopScan;

@end
