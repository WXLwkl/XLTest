//
//  ViewController.m
//  NSURLSession
//
//  Created by xingl on 16/4/14.
//  Copyright © 2016年 yinjia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>
{
    NSMutableData *_revData;
}
@property (weak, nonatomic) IBOutlet UITextView *textV;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"http://c.3g.163.com/nc/ad/headline/android/0-4.html"];
    //会话
    NSURLSession *session = [NSURLSession sharedSession];
    //任务
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //这里是分线程
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
           //这里是回到主线程   用途：刷新UI
        });
        
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
    //启动任务
    [task resume];
    
}
//post请求网络数据
- (IBAction)redBtnClick:(UIButton *)sender {
    
    //  https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1589956140,1606448699&fm=116&gp=0.jpg
    
    NSURL *url = [NSURL URLWithString:@"http://image.baidu.com/search/detail"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置提交方式
    [request setHTTPMethod:@"POST"];
    
    NSString *str = @"ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&pn=4&spn=0&di=105874631530&pi=&rn=1&tn=baiduimagedetail&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=1017606633%2C46849118&os=949164237%2C2326988691&simid=0%2C0&adpicid=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=11&oriquery=&objurl=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F19%2F43%2F68%2F56d3e7ffb7957_1024.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bcbrtv_z%26e3Bv54AzdH3Fzi7wg2fitAzdH3F8l9nmbcm_z%26e3Bip4s&gsm=0";
    //设置参数
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    //会话
    NSURLSession *session = [NSURLSession sharedSession];
    //任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"--post->%@:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding],error.localizedDescription);
        NSLog(@"----");
        dispatch_async(dispatch_get_main_queue(), ^{
            self.textV.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        });
        
    }];
    //启动任务
    [task resume];
}
- (IBAction)yellowBtnClick:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://c.3g.163.com/nc/ad/headline/android/0-4.html"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url];
    [task resume];
}
#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSLog(@"----接收到响应-");
    _revData = [[NSMutableData alloc] init];
    //使继续响应
    completionHandler(NSURLSessionResponseAllow);
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"--接收到数据");
    [_revData appendData:data];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"-1-完成--%@-----%@",[[NSString alloc] initWithData:_revData encoding:NSUTF8StringEncoding],error);
    
}
//下载的时候才能使用！！
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    NSLog(@"%lld//%lld",bytesSent,totalBytesSent);
}


- (IBAction)blueBtnClick:(UIButton *)sender {
    
}
- (void)loadUpdata {
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSString *str = @"123456";
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionUploadTask *task = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"-----完成");
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
