//
//  CoreTextData.h
//  CoreTextDemo
//
//  Created by xingl on 16/4/20.
//  Copyright © 2016年 yinjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextData : NSObject

@property (assign, nonatomic) CTFrameRef ctFrame;
@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) NSAttributedString *content;

@end
