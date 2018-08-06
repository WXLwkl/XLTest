//
//  ScanViewStyle.m
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import "ScanViewStyle.h"

@implementation ScanViewStyle

- (id)init
{
    if (self =  [super init]) {
        _isNeedShowRetangle = YES;
        
        _whRatio = 1.0;
        
        _colorRetangleLine = [UIColor whiteColor];
        
        _centerUpOffset = 44;
        _xScanRetangleOffset = 60;
        
        _anmiationStyle = ScanViewAnimationStyle_LineMove;
        _photoframeAngleStyle = ScanViewPhotoframeAngleStyle_Outer;
        _colorAngle = [UIColor colorWithRed:0. green:167./255. blue:231./255. alpha:1.0];
        
        _notRecoginitonArea = [UIColor colorWithRed:0. green:.0 blue:.0 alpha:.5];
        
        
        _photoframeAngleW = 24;
        _photoframeAngleH = 24;
        _photoframeLineW = 7;
        
    }
    
    return self;
}


@end
