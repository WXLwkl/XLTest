//
//  ViewController.m
//  Demo
//
//  Created by 兴林 on 2016/10/12.
//  Copyright © 2016年 兴林. All rights reserved.
//

#define Y_W  [UIScreen mainScreen].bounds.size.width

#define YG_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define YG_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"

@interface ViewController () {
    //浅灰色的那个图层
    UIView * yg_backView;
    //黄色的那个图层
    CAShapeLayer * yg_animation_shapeLayer;
}
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;

/**replicatorLayer*/
@property (nonatomic,strong) CAReplicatorLayer * yg_replicatorLayer;



/**计时器*/
@property (nonatomic, strong) NSTimer  *timer;
/**顶部进度条*/
@property (nonatomic,strong) CAGradientLayer * YG_top_colorLayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"【code_逍遥郎】";
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    /**设置主界面*/
//    [self setUI];
    
    /**创建顶部进度条--水平防线颜色渐变*/
//    [self creatYGTopColorLayer];
    /**创建底部彩带--对角线方向颜色渐变*/
//    [self creatYGBottomColorLayer];
    
    
    
//    [self creatMyBtn];
    
    
//    [self code_Animation4];
    
    
}

#pragma mark -- 创建顶部 水平方向变色的进度条
-(void)creatYGTopColorLayer
{
    /**创建*/
    self.self.YG_top_colorLayer     = [CAGradientLayer layer];
    /**设置frame*/
    self.YG_top_colorLayer.frame                 = (CGRect){CGPointMake(0, 64), CGSizeMake(15, 3)};
    
    /**修改位置为屏幕居中*/
    //    self.YG_top_colorLayer.position              = self.view.center;
    /**添加到View上*/
    [self.view.layer addSublayer:self.YG_top_colorLayer];
    
    /**颜色分配----类型(NSArray)*/
    self.YG_top_colorLayer.colors                = @[(__bridge id)[UIColor redColor].CGColor,
                                                     (__bridge id)[UIColor blueColor].CGColor,
                                                     (__bridge id)[UIColor greenColor].CGColor,
                                                     (__bridge id)[UIColor yellowColor].CGColor];
    
    /**颜色分割线----类型(NSArray<NSNumber *>)*/
    self.YG_top_colorLayer.locations             = @[@(0.2),@(0.4),@(0.6),@(0.8)];
    
    /**起始点----类型：(CGPoint)*/
    self.YG_top_colorLayer.startPoint            = CGPointMake(0, 0);
    
    /**结束点----类型：(CGPoint)*/
    self.YG_top_colorLayer.endPoint              = CGPointMake(1, 0);
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3f
                                                  target:self
                                                selector:@selector(TimerEvent)
                                                userInfo:nil
                                                 repeats:YES];
}
#pragma mark - 定时器响应事件

- (void)TimerEvent
{
    //定时改变颜色（后边两个效果图，第一个是注释掉了这行代码这个行的，第二个是没有注释的）；
    self.YG_top_colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                                      (__bridge id)[UIColor blueColor].CGColor,
                                      (__bridge id)[UIColor greenColor].CGColor,
                                      (__bridge id)[UIColor colorWithRed:arc4random() % 255 / 255.0
                                                                   green:arc4random() % 255 / 255.0
                                                                    blue:arc4random() % 255 / 255.0
                                                                   alpha:1.0].CGColor];
    
    //定时改变分割点
    self.YG_top_colorLayer.locations = @[@(arc4random() % 2 / 10.0f),           //取0.0~0.2之间的数值
                                         @(arc4random() % 4 / 10.0f + 0.21f),   //取0.21~0.4之间的数值
                                         @(arc4random() % 6 / 10.0f + 0.41f),   //取0.41~0.6之间的数值
                                         @(arc4random() % 8 / 10.0f + 0.61f)];  //取0.61~0.8之间的数值
    //定时增加进度条宽度
    
    CGRect progressRect = [self.YG_top_colorLayer frame];
    if (progressRect.size.width < YG_SCREEN_WIDTH) {
        progressRect.size.width += 10;
    } else {
        progressRect.size.width = 15;
    }
    
    [self.YG_top_colorLayer setFrame:progressRect];
}

#pragma mark -- 创建底部 沿对角线变色的彩带
-(void)creatYGBottomColorLayer
{
    /**创建*/
    CAGradientLayer * YG_bottom_colorLayer     = [CAGradientLayer layer];
    /**设置frame*/
    YG_bottom_colorLayer.frame                 = (CGRect){CGPointMake(0, YG_SCREEN_HEIGHT-164), CGSizeMake(YG_SCREEN_WIDTH, 20)};
    
    /**修改位置为屏幕居中*/
    //    YG_bottom_colorLayer.position              = self.view.center;
    /**添加到View上*/
    [self.view.layer addSublayer:YG_bottom_colorLayer];
    
    
    
    
    
    /**颜色分配----类型(NSArray)*/
    YG_bottom_colorLayer.colors                = @[(__bridge id)[UIColor redColor].CGColor,
                                                   (__bridge id)[UIColor blueColor].CGColor,
                                                   (__bridge id)[UIColor greenColor].CGColor,
                                                   (__bridge id)[UIColor yellowColor].CGColor];
    /*也可以用下面的方式创建颜色的数组
     [NSArray arrayWithObjects:
     (id)[[[UIColor redColor] colorWithAlphaComponent:1] CGColor],
     (id)[[[UIColor blueColor] colorWithAlphaComponent:1] CGColor],
     (id)[[[UIColor greenColor] colorWithAlphaComponent:1] CGColor],
     (id)[[UIColor yellowColor] CGColor],
     nil];
     */
    
    
    
    
    /**颜色分割线----类型(NSArray<NSNumber *>)*/
    YG_bottom_colorLayer.locations             = @[@(0.2),@(0.4),@(0.6),@(0.8)];
    
    /*也可以用下边的方式创建颜色分割线
     [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
     [NSNumber numberWithFloat:0.2],
     [NSNumber numberWithFloat:0.4],
     [NSNumber numberWithFloat:0.6],
     [NSNumber numberWithFloat:0.8],
     [NSNumber numberWithFloat:1.0],
     nil];
     */
    
    
    
    
    /**起始点----类型：(CGPoint)*/
    YG_bottom_colorLayer.startPoint            = CGPointMake(0, 0);
    
    /**结束点----类型：(CGPoint)*/
    YG_bottom_colorLayer.endPoint              = CGPointMake(1, 1);
    
    
}

#pragma mark - 雷达动画
-(void)setUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    /**加一个动画开始的按钮*/
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:@"show" forState:(UIControlStateNormal)];
    button.frame = CGRectMake(Y_W-150, 80, 80, 60);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4;
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showAnimation) forControlEvents:(UIControlEventTouchUpInside)];
    
    /**动画背景图*/
    yg_backView = [[UIView alloc]init];
    yg_backView.frame = CGRectMake(0, 150, Y_W, 200);
    [self.view addSubview:yg_backView];
    yg_backView.backgroundColor = [UIColor lightGrayColor];
    yg_backView.clipsToBounds = YES;
    
    /**动画图层，就是不停变大的那个圆*/
    yg_animation_shapeLayer = [[CAShapeLayer alloc]init];
    yg_animation_shapeLayer.backgroundColor = [UIColor yellowColor].CGColor;
    yg_animation_shapeLayer.bounds = CGRectMake(0, 0, 20, 20);
    yg_animation_shapeLayer.cornerRadius = 10;
    yg_animation_shapeLayer.position = CGPointMake(Y_W/2, 100);
    
    /**复制图层，可以不设置bound或frame*/
    _yg_replicatorLayer = [CAReplicatorLayer layer];
    _yg_replicatorLayer.backgroundColor = [UIColor cyanColor].CGColor;
    [_yg_replicatorLayer addSublayer:yg_animation_shapeLayer];//把动 画图层（shaperLayer） 关联到 复制图层（replicatorLayer）上
    _yg_replicatorLayer.instanceCount = 3.0;//三个复制图层
    _yg_replicatorLayer.instanceDelay = 0.3;//复制间隔时间为0.3秒
    _yg_replicatorLayer.repeatCount = MAXFLOAT;
    [yg_backView.layer addSublayer:_yg_replicatorLayer];
    
    //想用instanceAlphaOffset实现透明度变化的，可以参考下下面的代码
    
    yg_animation_shapeLayer.opacity = 0.7;
    _yg_replicatorLayer.instanceAlphaOffset = -0.4;
}
-(void)showAnimation
{
    
    /**放大的动画*/
    CABasicAnimation * yg_transform_animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    NSValue * yg_value = [NSValue valueWithCATransform3D:CATransform3DMakeScale(10, 10, 1)];
    yg_transform_animation.toValue = yg_value;
    yg_transform_animation.duration = 2;
    
    /**透明度动画---->(也可以直接设置CAReplicatorLayer的instanceAlphaOffset来实现，记得提前设置shaperLayer的不透明度)*/
    CABasicAnimation * yg_alpha_animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    yg_alpha_animation.fromValue = [NSNumber numberWithInt:1];
    yg_alpha_animation.toValue = [NSNumber numberWithFloat:0.1];
    yg_alpha_animation.duration = 2;
    
    /**动画组*/
    CAAnimationGroup * yg_animationGroup = [[CAAnimationGroup alloc]init];
    yg_animationGroup.animations = @[yg_transform_animation,yg_alpha_animation];
    yg_animationGroup.duration = 2;
    yg_animationGroup.repeatCount = MAXFLOAT;
    [yg_animation_shapeLayer addAnimation:yg_animationGroup forKey:nil];//将动画组 添加到 shapeLayer上
    
}

#pragma mark - 转圈动画
-(void)creatMyBtn
{
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(50 + 70 * i, self.view.frame.size.height - 50, 60, 50);
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:[NSString stringWithFormat:@"动画%d",i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectAnimation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
- (void)selectAnimation:(UIButton *)btn{
    [_imageView.layer removeAllAnimations];
    [_replicatorLayer removeAllAnimations];
    [_replicatorLayer removeFromSuperlayer];
    [_imageView removeFromSuperview];
    [self addImageView];
    [self addReplicatorLayer];
    [self  code_XMAnimation2];
}

#pragma mark - 添加图片

- (void)addImageView {
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView = imageView;
}

- (void)addReplicatorLayer {
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    
    replicatorLayer.bounds = self.view.bounds;
    replicatorLayer.position = self.view.center;
    replicatorLayer.preservesDepth = YES;
    replicatorLayer.instanceColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:_imageView.layer];
    [self.view.layer addSublayer:replicatorLayer];
    _replicatorLayer = replicatorLayer;
    
    
}

//设定动画，复制图层
- (void)code_XMAnimation2{
    
    _imageView.frame = CGRectMake(172, 200, 20, 20);
    _imageView.backgroundColor = [UIColor orangeColor];
    _imageView.image =[UIImage imageNamed:@"hei"];
    _imageView.layer.cornerRadius = 10;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    
    
    CGFloat count = 15.0;
    _replicatorLayer.instanceDelay = 1.0 / count;
    _replicatorLayer.instanceCount = count;
    //相对于_replicatorLayer.position旋转
    _replicatorLayer.instanceTransform = CATransform3DMakeRotation((2 * M_PI) / count, 0, 0, 1.0);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1.0;
    animation.repeatCount = MAXFLOAT;
    //    animation.autoreverses = YES;
    //从原大小变小时,动画 回到原状时不要动画
    animation.fromValue = @(1);
    animation.toValue = @(0.01);
    [_imageView.layer addAnimation:animation forKey:nil];
}

#pragma mark - 音乐谱动画
-(void)code_Animation4
{
    
    //1.首先创建复制layer,音乐振动条layer添加到复制layer上，然后复制图层就好了。
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(50, self.view.frame.size.height-200, 220, 150);
    replicatorLayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:replicatorLayer];
    
    // 2.先创建一个音量振动条，并且设置好动画,动画是绕着底部缩放，设置锚点
    CALayer *bar = [CALayer layer];
    bar.backgroundColor = [UIColor colorWithRed:255/255.0 green:110/255.0 blue:60/255.0 alpha:1.0].CGColor;
    bar.bounds = CGRectMake(0, 0, 10, 100);//bounds
    bar.position = CGPointMake(20, 150);//中心点的 x.y坐标
    bar.anchorPoint = CGPointMake(0.5, 1);//定位点
    [replicatorLayer addSublayer:bar];
    
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @(0.1);
    anim.autoreverses = YES;
    anim.repeatCount = MAXFLOAT;
    [bar addAnimation:anim forKey:nil];
    
    
    //3.复制图层（也可以说是复制图层）
    //设置13个图层，12个复制层
    replicatorLayer.instanceCount = 13;
    //设置复制图层的相对位置，每个x轴相差15
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(15, 0, 0);
    //设置复制图层的延迟动画时长
    replicatorLayer.instanceDelay = 0.3;
    
    //设置复制图层的透明度
    replicatorLayer.instanceAlphaOffset = -0.03;
    //设置复制图层相对上一个复制图层的红色偏移量
    replicatorLayer.instanceRedOffset = - 0.06;
    //    replicatorLayer.instanceGreenOffset = - 0.0;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
