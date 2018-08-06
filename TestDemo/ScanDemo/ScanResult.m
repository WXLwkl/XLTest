//
//  ScanResult.m
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import "ScanResult.h"

@implementation ScanResult


- (instancetype)initWithScanString:(NSString*)str imgScan:(UIImage*)img barCodeType:(NSString*)type {
    if (self = [super init]) {
        
        self.strScanned = str;
        self.imgScanned = img;
        self.strBarCodeType = type;
    }
    return self;
}


@end
