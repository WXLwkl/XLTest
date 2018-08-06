//
//  ViewController.m
//  NSURLSessionDownloadDemo
//
//  Created by xingl on 16/4/15.
//  Copyright © 2016年 yinjia. All rights reserved.
//

#import "ViewController.h"
#import "RainbowProgress.h"

#define MP4_URLString @"http://download.yjpal.com:8888/app/download/78B77AC62808AE4CDA409644555D660C/tianxingjinrong.ipa"

@interface ViewController ()<NSURLSessionDownloadDelegate>
//彩虹进度条
@property(nonatomic,weak) RainbowProgress *progress;
//下载任务
@property(nonatomic,strong)NSURLSessionDownloadTask *task;
//下载的数据信息
@property(nonatomic,strong)NSData *resumeData;

//下载的会话
@property(nonatomic,strong)NSURLSession *session;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RainbowProgress *progress = [[RainbowProgress alloc] init];
    progress.progressHeigh = 50;
    [progress startAnimating];
    [self.view addSubview:progress];
    self.view.backgroundColor = [UIColor whiteColor];
    self.progress = progress;
    
    [self download];
    
}
- (void)download {
    //创建会话
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:MP4_URLString];
    
    self.task = [self.session downloadTaskWithURL:url];
}
- (IBAction)kaishi:(id)sender {
    //启动任务
    [self.task resume];
}
- (IBAction)zanting:(id)sender {
    
//  [self.task suspend];//suspend暂停下载|可恢复的 [self.task resume]
//cancelByProducingResumeData取消下载，同时可以获取已经下载的数据相关信息
    
    [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
    }];
    NSLog(@"%s -- %@",__FUNCTION__,self.task);
}
- (IBAction)jixu:(id)sender {
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
    [downloadTask resume];
    
    self.task = downloadTask;
}
#pragma mark - NSURLSessionDataDelegate
// 下载了数据的过程中会调用的代理方法
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten
totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    NSLog(@"%lf",1.0 * totalBytesWritten / totalBytesExpectedToWrite);
    
    self.progress.progressValue = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
}
// 重新恢复下载的代理方法
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
    NSLog(@"调用了");
}
// 写入数据到本地的时候会调用的方法
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
//    NSString* fullPath =
//    [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
//     stringByAppendingPathComponent:downloadTask.response.suggestedFilename];;
//    [[NSFileManager defaultManager] moveItemAtURL:location
//                                            toURL:[NSURL fileURLWithPath:fullPath]
//                                            error:nil];
//    NSLog(@"%@",fullPath);
    
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    NSLog(@"%@",fullPath);
    
}
// 请求完成，错误调用的代理方法
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
    [self.progress stopAnimating];
    [self.progress removeFromSuperview];
    
    NSLog(@"%@---%@",error,[NSThread currentThread]);
}
#pragma mark - 懒加载
-(NSData *)resumeData{
    if (!_resumeData) {
        _resumeData = [NSData data];
    }
    return _resumeData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
