//
//  ScanViewController.m
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import "ScanViewController.h"

#import <AVFoundation/AVFoundation.h>


@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"二维码扫描";
    self.view.backgroundColor = [UIColor blackColor];
    
    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self drawScanView];
    
    [self requestCameraPemissionWithResult:^(BOOL granted) {
        if (granted) {
            [self performSelector:@selector(startScan) withObject:nil afterDelay:0.3];
        } else {
            [_qrScanView stopDeviceReadying];
        }
    }];
}

- (void)drawScanView {
    if (!_qrScanView) {
        CGRect rect = self.view.frame;
        rect.origin = CGPointMake(0, 0);
        _qrScanView = [[ScanView alloc] initWithFrame:rect style:_style];
        [self.view addSubview:_qrScanView];
    }
    if (!_cameraInvokeMsg) _cameraInvokeMsg = NSLocalizedString(@"设备启动中。。。", nil);
    
    [_qrScanView startDeviceReadyingWithText:_cameraInvokeMsg];
    
}

- (void)reStartDevice {
    [_scanObj startScan];
}

//启动设备
- (void)startScan {
    
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    videoView.backgroundColor = [UIColor redColor];
    [self.view insertSubview:videoView atIndex:0];
    
    __weak __typeof(self) weakSelf = self;
    
    if (!_scanObj) {
        CGRect cropRect = CGRectZero;
        
        if (_isOpenInterestRect) {
            //设置只识别框内区域
            cropRect = [ScanView getScanRectWithPreView:self.view style:_style];
        }
        
        NSString *strCode = AVMetadataObjectTypeQRCode;
        
        strCode = [self nativeCodeWithType:_scanCodeType];
        
        //AVMetadataObjectTypeITF14Code 扫码效果不行,另外只能输入一个码制，虽然接口是可以输入多个码制
        self.scanObj = [[ScanNative alloc] initWithPreView:videoView ObjectType:@[strCode] cropRect:cropRect success:^(NSArray<ScanResult *> *array) {
            
            [weakSelf scanResultWithArray:array];
        }];
        [_scanObj setNeedCaptureImage:_isNeedScanImage];
    }
    [_scanObj startScan];
    
    [_qrScanView stopDeviceReadying];
    [_qrScanView startScanAnimation];
    
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)stopScan {
    [_scanObj stopScan];
}
#pragma mark -扫码结果处理

- (void)scanResultWithArray:(NSArray<ScanResult*>*)array {

    NSLog(@"%@", array);
    //可以通过继承LBXScanViewController，重写本方法即可
}


- (NSString*)nativeCodeWithType:(SCANCODETYPE)type {
    switch (type) {
        case SCT_QRCode:
            return AVMetadataObjectTypeQRCode;
            break;
        case SCT_BarCode93:
            return AVMetadataObjectTypeCode93Code;
            break;
        case SCT_BarCode128:
            return AVMetadataObjectTypeCode128Code;
            break;
        case SCT_BarCodeITF:
            return @"ITF条码:only ZXing支持";
            break;
        case SCT_BarEAN13:
            return AVMetadataObjectTypeEAN13Code;
            break;
            
        default:
            return AVMetadataObjectTypeQRCode;
            break;
    }
}
- (void)requestCameraPemissionWithResult:(void(^)( BOOL granted))completion {
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                completion(YES);
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                completion(NO);
                break;
            case AVAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                         completionHandler:^(BOOL granted) {
                                             
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 if (granted) {
                                                     completion(true);
                                                 } else {
                                                     completion(false);
                                                 }
                                             });
                                             
                                         }];
            }
                break;
        }
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self stopScan];
    
    [_qrScanView stopScanAnimation];
    
}
@end
