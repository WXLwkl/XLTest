//
//  MyView.m
//  CoreTextDemo
//
//  Created by xingl on 16/4/20.
//  Copyright © 2016年 yinjia. All rights reserved.
//

#import "DisplayView.h"
#import <CoreText/CoreText.h>
@implementation DisplayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    //得到桑倩绘制画布的上下文，用于后续姜内容绘制在画布上。
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将坐标系上下翻转，对于底层的绘制引擎来说，屏幕的左下角是（0，0）坐标。而对于上层的UIKit来说，左上角是（0，0）坐标，所以我们为了之后的坐标系描述按UIKit来做，先在这里做一个坐标系的上下翻转操作。翻转之后，底层和上层的（0，0）坐标就是重合的了。
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //创建绘制的区域，CoreText本身支持各种文字排版的区域，我们这里简单的将UIView的整个界面作为排版的区域。
    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, self.bounds);
    CGPathAddEllipseInRect(path, NULL, self.bounds);
    
    //
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World"
                        "创建绘制区域，CoreText本身支持各种文字排版的区域"
                        "我们这里简单的将UIView的整个界面作为排版的区域。"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    
    //5.
    CTFrameDraw(frame, context);
    
    //
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
    
}


@end
