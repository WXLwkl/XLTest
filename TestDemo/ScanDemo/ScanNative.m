//
//  ScanNative.m
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import "ScanNative.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanNative ()<AVCaptureMetadataOutputObjectsDelegate> {
    
    BOOL bNeedScanResult;
}

@property (assign,nonatomic)AVCaptureDevice *device;
@property (strong,nonatomic)AVCaptureDeviceInput *input;
@property (strong,nonatomic)AVCaptureMetadataOutput *output;
@property (strong,nonatomic)AVCaptureSession *session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer *preview;

@property(nonatomic,strong)  AVCaptureStillImageOutput *stillImageOutput;//拍照

@property(nonatomic,assign) BOOL isNeedCaputureImage;

//扫码结果
@property (nonatomic, strong) NSMutableArray<ScanResult *> *arrayResult;

//扫码类型
@property (nonatomic, strong) NSArray *arrayBarCodeType;

/**
 @brief  视频预览显示视图
 */
@property (nonatomic,weak)UIView *videoPreView;

/** 扫码结果返回 */
@property(nonatomic,copy) void(^blockScanResult)(NSArray<ScanResult*> *array);


@end

@implementation ScanNative

/**
 @brief  默认支持码的类别
 @return 支持类别 数组
 */
- (NSArray *)defaultMetaDataObjectTypes {
    NSMutableArray *types = [@[AVMetadataObjectTypeQRCode,
                               AVMetadataObjectTypeUPCECode,
                               AVMetadataObjectTypeCode39Code,
                               AVMetadataObjectTypeCode39Mod43Code,
                               AVMetadataObjectTypeEAN13Code,
                               AVMetadataObjectTypeEAN8Code,
                               AVMetadataObjectTypeCode93Code,
                               AVMetadataObjectTypeCode128Code,
                               AVMetadataObjectTypePDF417Code,
                               AVMetadataObjectTypeAztecCode] mutableCopy];
    
    
    if (@available(iOS 8.0, *)) {
        [types addObjectsFromArray:@[
                                     AVMetadataObjectTypeInterleaved2of5Code,
                                     AVMetadataObjectTypeITF14Code,
                                     AVMetadataObjectTypeDataMatrixCode
                                     ]];
    }
    
    
    return types;
}



- (void)setNeedCaptureImage:(BOOL)isNeedCaputureImg {
    _isNeedCaputureImage = isNeedCaputureImg;
}

- (instancetype)initWithPreView:(UIView *)preView ObjectType:(NSArray *)objType success:(void (^)(NSArray<ScanResult *> *))block {
    if (self = [super init]) {
        [self initParaWithPreView:preView ObjectType:objType cropRect:CGRectZero success:block];
    }
    return self;
}

- (instancetype)initWithPreView:(UIView *)preView ObjectType:(NSArray *)objType cropRect:(CGRect)cropRect success:(void (^)(NSArray<ScanResult *> *))block {
    if (self = [super init]) {
        [self initParaWithPreView:preView ObjectType:objType cropRect:cropRect success:block];
    }
    return self;
}

- (void)initParaWithPreView:(UIView*)videoPreView ObjectType:(NSArray*)objType cropRect:(CGRect)cropRect success:(void(^)(NSArray<ScanResult*> *array))block {
    
    self.arrayBarCodeType = objType;
    self.blockScanResult = block;
    self.videoPreView = videoPreView;
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!_device) return;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    if (!_input) return;
    
    bNeedScanResult = YES;
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if (!CGRectEqualToRect(cropRect, CGRectZero)) {
        _output.rectOfInterest = cropRect;
    }
    
    _stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [_stillImageOutput setOutputSettings:outputSettings];
    
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:_input]) [_session addInput:_input];
    if ([_session canAddOutput:_output]) [_session addOutput:_output];
    if ([_session canAddOutput:_stillImageOutput]) [_session addOutput:_stillImageOutput];
    
    if (!objType) {
        objType = [self defaultMetaDataObjectTypes];
    }
    
    _output.metadataObjectTypes = objType;
    
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    CGRect frame = videoPreView.frame;
    frame.origin = CGPointZero;
    _preview.frame = frame;
    [videoPreView.layer insertSublayer:self.preview atIndex:0];
    
    AVCaptureConnection *videoConnection = [self connectionWithMediaType:AVMediaTypeVideo fromConnections:[[self stillImageOutput] connections]];
    CGFloat scale = videoConnection.videoScaleAndCropFactor;
    NSLog(@"%f", scale);
    
    if (_device.isFocusPointOfInterestSupported && [_device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [_input.device lockForConfiguration:nil];
        [_input.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [_input.device unlockForConfiguration];
    }
}

- (CGFloat)getVideoMaxScale {
    [_input.device lockForConfiguration:nil];
    AVCaptureConnection *videoConnection = [self connectionWithMediaType:AVMediaTypeVideo fromConnections:[[self stillImageOutput] connections]];
    CGFloat maxScale = videoConnection.videoMaxScaleAndCropFactor;
    [_input.device unlockForConfiguration];
    
    return maxScale;
}

- (void)setVideoScale:(CGFloat)scale {
    [_input.device lockForConfiguration:nil];
    
    AVCaptureConnection *videoConnection = [self connectionWithMediaType:AVMediaTypeVideo fromConnections:[[self stillImageOutput] connections]];
    
    CGFloat zoom = scale / videoConnection.videoScaleAndCropFactor;
    
    videoConnection.videoScaleAndCropFactor = scale;
    
    [_input.device unlockForConfiguration];
    
    CGAffineTransform transform = _videoPreView.transform;
    
    _videoPreView.transform = CGAffineTransformScale(transform, zoom, zoom);
}

- (void)setScanRect:(CGRect)scanRect {
    if (_output) {
        _output.rectOfInterest = [self.preview metadataOutputRectOfInterestForRect:scanRect];
    }
}

- (void)changeScanType:(NSArray*)objType {
    
    _output.metadataObjectTypes = objType;
}

- (void)startScan {
    
    if ( _input && !_session.isRunning )
    {
        [_session startRunning];
        bNeedScanResult = YES;
        
        [_videoPreView.layer insertSublayer:self.preview atIndex:0];
    }
    bNeedScanResult = YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ( object == _input.device ) {
        
        NSLog(@"flash change");
    }
}

- (void)stopScan {
    bNeedScanResult = NO;
    if ( _input && _session.isRunning )
    {
        bNeedScanResult = NO;
        [_session stopRunning];
        
        // [self.preview removeFromSuperlayer];
    }
}

- (void)setTorch:(BOOL)torch {
    
    [self.input.device lockForConfiguration:nil];
    self.input.device.torchMode = torch ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
    [self.input.device unlockForConfiguration];
}

- (void)changeTorch {
    AVCaptureTorchMode torch = self.input.device.torchMode;
    
    switch (_input.device.torchMode) {
        case AVCaptureTorchModeAuto:
            break;
        case AVCaptureTorchModeOff:
            torch = AVCaptureTorchModeOn;
            break;
        case AVCaptureTorchModeOn:
            torch = AVCaptureTorchModeOff;
            break;
        default:
            break;
    }
    
    [_input.device lockForConfiguration:nil];
    _input.device.torchMode = torch;
    [_input.device unlockForConfiguration];
}

-(UIImage *)getImageFromLayer:(CALayer *)layer size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, [[UIScreen mainScreen]scale]);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections
{
    for ( AVCaptureConnection *connection in connections ) {
        for ( AVCaptureInputPort *port in [connection inputPorts] ) {
            if ( [[port mediaType] isEqual:mediaType] ) {
                return connection;
            }
        }
    }
    return nil;
}

- (void)captureImage {
    AVCaptureConnection *stillImageConnection = [self connectionWithMediaType:AVMediaTypeVideo fromConnections:[[self stillImageOutput] connections]];
    
    
    [[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:stillImageConnection
                                                         completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
         [self stopScan];
         
         if (imageDataSampleBuffer) {
             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
             
             UIImage *img = [UIImage imageWithData:imageData];
             
             for (ScanResult* result in _arrayResult) {
                 
                 result.imgScanned = img;
             }
         }
         
         if (_blockScanResult) {
             
             _blockScanResult(_arrayResult);
         }
         
     }];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput2:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    //识别扫码类型
    for(AVMetadataObject *current in metadataObjects) {
        if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]] ) {
            
            NSString *scannedResult = [(AVMetadataMachineReadableCodeObject *) current stringValue];
            NSLog(@"type:%@",current.type);
            NSLog(@"result:%@",scannedResult);
            
            //测试可以同时识别多个二维码
        }
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (!bNeedScanResult)  return;
    
    
    bNeedScanResult = NO;
    
    if (!_arrayResult) {
        self.arrayResult = [NSMutableArray arrayWithCapacity:1];
    } else {
        [_arrayResult removeAllObjects];
    }
    
    //识别扫码类型
    for(AVMetadataObject *current in metadataObjects) {
        if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]){
            bNeedScanResult = NO;
            
            NSLog(@"type:%@",current.type);
            NSString *scannedResult = [(AVMetadataMachineReadableCodeObject *) current stringValue];
            
            if (scannedResult && ![scannedResult isEqualToString:@""]) {
                ScanResult *result = [ScanResult new];
                result.strScanned = scannedResult;
                result.strBarCodeType = current.type;
                
                [_arrayResult addObject:result];
            }
            //测试可以同时识别多个二维码
        }
    }
    
    if (_arrayResult.count < 1) {
        bNeedScanResult = YES;
        return;
    }
    
    if (_isNeedCaputureImage) {
        [self captureImage];
    } else {
        [self stopScan];
        
        if (_blockScanResult) {
            _blockScanResult(_arrayResult);
        }
    }
}

#pragma mark --识别条码图片
//+ (void)recognizeImage:(UIImage*)image success:(void(^)(NSArray<ScanResult*> *array))block {
//    if ([[[UIDevice currentDevice]systemVersion]floatValue] < 8.0) {
//        if (block) {
//            ScanResult *result = [[ScanResult alloc]init];
//            result.strScanned = @"只支持ios8.0之后系统";
//            block(@[result]);
//        }
//        return;
//    }
//    
//    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
//    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
//    NSMutableArray<ScanResult*> *mutableArray = [[NSMutableArray alloc]initWithCapacity:1];
//    for (int index = 0; index < [features count]; index ++)
//    {
//        CIQRCodeFeature *feature = [features objectAtIndex:index];
//        NSString *scannedResult = feature.messageString;
//        NSLog(@"result:%@",scannedResult);
//        
//        ScanResult *item = [[ScanResult alloc]init];
//        item.strScanned = scannedResult;
//        item.strBarCodeType = CIDetectorTypeQRCode;
//        item.imgScanned = image;
//        [mutableArray addObject:item];
//    }
//    if (block) {
//        block(mutableArray);
//    }
//}


@end
