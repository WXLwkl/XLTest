//
//  DIYScanViewController.m
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import "DIYScanViewController.h"
#import "ScanResultViewController.h"

@interface DIYScanViewController ()

@end

@implementation DIYScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cameraInvokeMsg = @"相机启动中";
    //设置扫码后需要扫码图像
    self.isNeedScanImage = YES;
}

#pragma mark -实现类继承该方法，作出对应处理

- (void)scanResultWithArray:(NSArray<ScanResult*>*)array {
    
    
    if (!array ||  array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以ZXing同时识别2个二维码，不能同时识别二维码和条形码
    //    for (LBXScanResult *result in array) {
    //
    //        NSLog(@"scanResult:%@",result.strScanned);
    //    }
    
    ScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //TODO: 这里可以根据需要自行添加震动或播放声音提示相关代码
    //...
    
    [self showNextVCWithScanResult:scanResult];
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) strResult = @"识别失败";
    
    NSLog(@"%@", strResult);
}

- (void)showNextVCWithScanResult:(ScanResult*)strResult {
    
    
    ScanResultViewController *vc = [ScanResultViewController new];
    vc.imgScan = strResult.imgScanned;
    
    vc.strScan = strResult.strScanned;
    
    vc.strCodeType = strResult.strBarCodeType;
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
