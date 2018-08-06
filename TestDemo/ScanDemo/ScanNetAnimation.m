//
//  ScanNetAnimation.m
//  ScanDemo
//
//  Created by xingl on 2018/6/4.
//  Copyright © 2018年 xingl. All rights reserved.
//

#import "ScanNetAnimation.h"
@interface ScanNetAnimation () {
    
    BOOL isAnimationing;
}
@property (nonatomic, assign) CGRect animationRect;
@property (nonatomic, strong) UIImageView *scanImageView;

@end
@implementation ScanNetAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        [self addSubview:self.scanImageView];
    }
    return self;
}

- (UIImageView *)scanImageView {
    if (!_scanImageView) {
        _scanImageView = [[UIImageView alloc] init];
    }
    return _scanImageView;
}

- (void)startAnimatingWithRect:(CGRect)animationRect InView:(UIView *)parentView Image:(UIImage *)image {
    [self.scanImageView setImage:image];
    self.animationRect = animationRect;
    [parentView addSubview:self];
    self.hidden = NO;
    isAnimationing = YES;
    [self stepAnimation];
}

- (void)stepAnimation {
    if (!isAnimationing) return;
    self.frame = _animationRect;
    CGFloat scanW = self.frame.size.width;
    CGFloat scanH = self.frame.size.height;
    self.alpha = 0.5;
    _scanImageView.frame = CGRectMake(0, -scanH, scanW, scanH);
    [UIView animateWithDuration:2.5 animations:^{
        self.alpha = 1.0;
        _scanImageView.frame = CGRectMake(0, scanW - scanH + 100, scanW, scanH);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(stepAnimation) withObject:nil afterDelay:0.3];
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self performSelector:@selector(stepAnimation) withObject:nil afterDelay:0.3];
}

- (void)dealloc {
    
    [self stopAnimating];
}

- (void)stopAnimating {
    
    self.hidden = YES;
    isAnimationing = NO;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
