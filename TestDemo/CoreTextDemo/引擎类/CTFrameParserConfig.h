//
//  CTFrameParserConfig.h
//  CoreTextDemo
//
//  Created by xingl on 16/4/20.
//  Copyright © 2016年 yinjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFrameParserConfig : NSObject

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, strong) UIColor *textColor;

@end
