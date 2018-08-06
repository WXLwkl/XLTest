//
//  ScanNetAnimation.h
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanNetAnimation : UIView

/**
 *  开始扫码网格效果
 *
 *  @param animationRect 显示在parentView中得区域
 *  @param parentView    动画显示在UIView
 *  @param image     扫码线的图像
 */
- (void)startAnimatingWithRect:(CGRect)animationRect InView:(UIView *)parentView Image:(UIImage *)image;

/**
 *  停止动画
 */
- (void)stopAnimating;

@end
