//
//  CTFrameParserConfig.m
//  CoreTextDemo
//
//  Created by xingl on 16/4/20.
//  Copyright © 2016年 yinjia. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

- (id)init {
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = UICOLORRGB(108, 108, 108,0.6);
    }
    return self;
}

@end
