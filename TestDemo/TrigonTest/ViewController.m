//
//  ViewController.m
//  TrigonTest
//
//  Created by mac on 15-10-15.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	CALayer *layer = [CALayer layer];
    layer.bounds = self.view.bounds;
    layer.position = self.view.center;
    [self.view.layer addSublayer:layer];
    
    layer.delegate = self;
    
    [layer setNeedsDisplay];
    
    
}
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
    [self createCheseKont:ctx];
    
//    [self createTrigon:ctx];
   
//    [self createFivePointedStar:ctx];
    
}
-(void)createCheseKont:(CGContextRef)ctx
{
    
    double M = sqrt(2)*10;
    
    CGContextSetLineWidth(ctx, 5);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
    
    CGContextMoveToPoint(ctx, 150, 180);
    
    CGContextAddArc(ctx, 160, 170, M, M_PI*3/4, M_PI*2+M_PI/4, NO);
    
    CGContextAddLineToPoint(ctx, 100, 250);
    
    CGContextAddArc(ctx, 90, 240, M, M_PI/4, M_PI*2-M_PI/4, NO);
    
    CGContextAddLineToPoint(ctx, 170, 300);
    
    CGContextAddArc(ctx, 160, 310, M, -M_PI/4, M_PI*2-M_PI*3/4, NO);
    
    CGContextAddLineToPoint(ctx, 220, 230);
    
    CGContextAddArc(ctx, 230, 240, M, M_PI*5/4, M_PI*2+M_PI*3/4, NO);
    
    CGContextAddLineToPoint(ctx, 150, 180);
    //线条两端格式
    //    CGContextSetLineCap(ctx, kCGLineCapRound);
    //拐角格式
    //    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor yellowColor] CGColor]);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
}
-(void)createTrigon:(CGContextRef)ctx
{
    CGContextSetLineWidth(ctx, 5);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
    
    CGContextMoveToPoint(ctx, 160, 80);
    CGContextAddLineToPoint(ctx, 80, 200);
    CGContextAddLineToPoint(ctx, 240, 200);
    CGContextAddLineToPoint(ctx, 160, 80);
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor yellowColor] CGColor]);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    
}
-(void)createFivePointedStar:(CGContextRef)ctx
{
/*
    CGContextSetLineWidth(ctx, 5);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
    
    int m = 100;
    
    for (int i = 0; i < 5; i++)
    {
        CGContextAddArc(ctx, 160, 240, m , 0, i*72*M_PI/180, NO);
        CGPoint point = CGContextGetPathCurrentPoint(ctx);
        
        NSLog(@"->%d====%.2f--%.2f",i,point.x,point.y);
    }
 
    
    
    CGContextSetFillColorWithColor(ctx, [[UIColor yellowColor] CGColor]);
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
*/
   
    CGContextSetLineWidth(ctx, 5);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor blackColor] CGColor]);
    
    //确定中心点
    CGPoint centerPoint = CGPointMake(160, 240);
    //确定半径
    CGFloat radius = 100.0;
    //五角星到顶点
    CGPoint p1 = CGPointMake(centerPoint.x, centerPoint.y-radius);
    CGContextMoveToPoint(ctx, p1.x, p1.y);
    //五角星每个点之间点夹角，采用弧度计算。每两个点进行连线就可以画出五角星
    //点与点之间点夹角为2*M_PI/5.0，
    CGFloat angle = 2*2*M_PI/5.0;
    for (int i=1; i<=5; i++)
    {
        CGFloat x = centerPoint.x-sinf(i*angle)*radius;
        CGFloat y =  centerPoint.y-cosf(i*angle)*radius;
        CGContextAddLineToPoint(ctx, x, y);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
}
@end
