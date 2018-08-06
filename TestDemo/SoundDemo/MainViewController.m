//
//  MainViewController.m
//  SoundDemo
//
//  Created by yinjia on 16/4/8.
//  Copyright © 2016年 yjpal. All rights reserved.
//


#import "MainViewController.h"
#import <AudioToolbox/AudioToolbox.h> // C框架
#import <AVFoundation/AVFoundation.h>

@interface MainViewController ()<AVAudioPlayerDelegate>
{
    //声音播放器
    AVAudioPlayer *_player;
    
    //录音机
    AVAudioRecorder *_recorder;
    
}

@end



static NSDictionary *dic;

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    [self show];
    
    UIButton *sysbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sysbtn.frame = CGRectMake(20, 40, 280, 40);
    [sysbtn setTitle:@"播放系统声音" forState:UIControlStateNormal];
    [sysbtn addTarget:self action:@selector(systemBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sysbtn];
    
    
    UIButton *bgbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bgbtn.frame = CGRectMake(20, 100, 280, 40);
    [bgbtn setTitle:@"播放背景声音" forState:UIControlStateNormal];
    [bgbtn addTarget:self action:@selector(bgBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgbtn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 150, 80, 40);
    [btn1 setTitle:@"暂停" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(Btn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(140, 150, 80, 40);
    [btn2 setTitle:@"停止" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(Btn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(40, 200, 240, 50)];
    slider.value = 0.0f;
    [slider addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    //获得声音文件的路径.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"chuanqi" ofType:@"mp3"];
    //根据文件路径创建一个url
//    NSURL *url = [NSURL fileURLWithPath:path];
    
    //使用data
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    //创建声音播放器
//    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    _player = [[AVAudioPlayer alloc] initWithData:data error:nil];
    
    //打开可以改变速度
    _player.enableRate = YES;
    
    //播放次数 （0代表播放一次 1代表播放两次 。。。）
    _player.numberOfLoops = 0;
    
    _player.delegate = self;
    
    
    //播放进度
    slider.maximumValue = _player.duration;
    
    //播放速度
//    slider.maximumValue = 3.0f;
//    slider.value = 1.0f;
    
    //监听音乐中断
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:session];

    
    
/*----------------录音-------------------*/
    UIButton *LYbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LYbtn.frame = CGRectMake(20, 250,80, 40);
    [LYbtn setTitle:@"开始录音" forState:UIControlStateNormal];
    [LYbtn addTarget:self action:@selector(LYbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LYbtn];
    
    UIButton *LYbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    LYbtn2.frame = CGRectMake(120, 250, 80, 40);
    [LYbtn2 setTitle:@"结束录音" forState:UIControlStateNormal];
    [LYbtn2 addTarget:self action:@selector(LYbtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LYbtn2];
    
    UIButton *LYbtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    LYbtn3.frame = CGRectMake(220, 250, 80, 40);
    [LYbtn3 setTitle:@"播放录音" forState:UIControlStateNormal];
    [LYbtn3 addTarget:self action:@selector(LYbtn3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LYbtn3];
    
   
}
#pragma mark - 录音
- (void)LYbtn {
    NSLog(@"---开始录音----");
    
    //获取当前时间
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"yyyyMMddHHmmss";
//    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
        NSString *path1 = NSTemporaryDirectory();
        NSString *filePath = [path1 stringByAppendingPathComponent:@"red.wav"];
        NSLog(@"--filePath= %@",filePath);///Users/xingl/Library/Developer/CoreSimulator/Devices/54A76746-79B6-4260-9371-6259B090C809/data/Containers/Data/Application/95B05917-FDD8-4E6E-9057-0838227BB537/tmp/20160620113409.caf
    
    
//    NSString *audioName = [dateString stringByAppendingString:@".caf"];
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *fileURL = [doc stringByAppendingPathComponent:audioName];
//    NSLog(@"--%@",fileURL);///Users/xingl/Library/Developer/CoreSimulator/Devices/54A76746-79B6-4260-9371-6259B090C809/data/Containers/Data/Application/DAF780D1-909D-4F7B-AC00-92899719ED7F/Documents/20160620114010.caf
    
    
    //对录音机进行配置
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithCapacity:4];
    //采样频率
    [settings setObject:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    //声道数
    [settings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    //采样位数
    [settings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音质量
    [settings setObject:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSError *error;
    //创建录音对象
    _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:filePath] settings:settings error:&error];
    if (error) {
        NSLog(@"录音出错了:%@",error);
    }
    //准备录音(系统会分配一些录音资源)
    [_recorder prepareToRecord];
    
    [_recorder record];
}
- (void) LYbtn1 {
    NSLog(@"---结束录音----");
//    [_recorder pause];//暂停录音
    
    //录音时间
    double time =  _recorder.currentTime;
    NSLog(@"%g",time);
    [_recorder stop];
    
    NSString *path1 = NSTemporaryDirectory();
    NSString *filePath = [path1 stringByAppendingPathComponent:@"red.wav"];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:filePath] error:nil];
    
}
- (void)LYbtn3 {
    if (_player) {
        [_player play];
    }
}

#pragma mark - 播放器
- (void)bgBtn:(UIButton *)btn {
    //声音不超过30s,格式:caf,aif,wav
    //导入框架AVFoundation.framwork 头文件 AVFoundation/AVFoundation.h
    
    
    if (_player) {
        
        [_player play];
    }
    
    NSLog(@"播放");
}
- (void)Btn1 {
    //暂停
    if ([_player play]) {
        
        [_player pause];
    }
}
- (void)Btn2 {
    //停止
    if ([_player play]) {
        
        [_player stop];
        //需要手动设置当前时间为0
        _player.currentTime = 0;
    }

}

- (void)change:(UISlider *)sender {
    //滑块控制改变
    NSLog(@"时间变化：%g",sender.value);
    
    //播放进度
    _player.currentTime = sender.value;
    
    //播放速度
//    _player.rate = sender.value;
    
    //音量
//    _player.volume = sender.value;
    
}


#pragma mark - 系统声音
- (void)systemBtn:(UIButton *)btn {
    //声音不超过30s,格式:caf,aif,wav
    //导入框架AudioToolBox.framwork 头文件 AudioToolbox/AudioToolbox.h
    
    //获得声音文件的路径.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aa" ofType:@"wav"];
    //根据文件路径创建一个url
    NSURL *url = [NSURL fileURLWithPath:path];
    //注册声音文件为系统声音文件
    SystemSoundID sid;
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &sid);
    if (error) {
        
        NSLog(@"注册声音文件错误!!");
        return;
    }
    AudioServicesPlaySystemSound(sid);
}

#pragma mark - 工具类
/********************    声音的工具类    ****************************/
- (void)show {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"zz.zip" ofType:nil];
    NSError *error = nil;
    NSArray *contents = [manager contentsOfDirectoryAtPath:soundPath error:&error];
    NSLog(@"111%@",contents);
    
    
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    
    for (NSString *mp3Name in contents) {
        NSString *soundUrlStr = [soundPath stringByAppendingPathComponent:mp3Name];
        NSURL *soundUrl = [NSURL fileURLWithPath:soundUrlStr];
        
        SystemSoundID soundId;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundUrl), &soundId);
        
        dicM[mp3Name] = @(soundId);
        
    }
    dic = dicM;
}

- (void)playWithName:(NSString *)mp3Name {
    
    SystemSoundID soundId = [dic[mp3Name] unsignedIntValue];
    
    AudioServicesPlaySystemSound(soundId);
    
    //有震动的
    AudioServicesPlayAlertSound(soundId);
}

#pragma  mark - AVAudioPlayerDelegate
//播放完成调用
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"%s",__func__);
}
/*!
 *  @author 逍遥郎happy, 16-06-20 10:06:20
 *
 *  处理中断
 */
- (void)handleInterruption:(NSNotification *)noti {
    
    NSLog(@"%@",noti.userInfo);
    
//    AVAudioSessionInterruptionTypeKey = 1 //开始中断
//    AVAudioSessionInterruptionTypeKey = 0 //结束中断
    
    
}

#pragma mark - ios8已经过期了
/*
//中断（电话进来）
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    
    [_player pause];
}
//停止中断（电话挂了）
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player {
    [_player play];
}
 */
@end
