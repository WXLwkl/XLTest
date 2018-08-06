//
//  ViewController.m
//  ImagePickerControllerDemo
//
//  Created by yinjia on 16/3/30.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "ViewController.h"

#import <MobileCoreServices/MobileCoreServices.h> //设置多媒体类型

#import <MediaPlayer/MediaPlayer.h> //播放时
#import <AVKit/AVPlayerViewController.h>

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)read {
    //判断图片库是否可用
    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //创建一个UIImagePickerController对象
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //设置picker对象的拾取源属性
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//默认就是PhotoLibrary
        //设置代理
        picker.delegate = self; //<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
        
        //可编辑
        picker.allowsEditing = YES;
        
        //显示控制器
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (IBAction)photoBtn {
    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;//设置为照相机(录像机)功能
        //设置摄像头捕获类型
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;//告诉picker使用照相机进行拍照操作,(设置拾取源属性为相机功能时,默认为拍照操作)
        //设置前或后面的摄像头
        picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;//fron:前置摄像头,rear:后置摄像头
        
//        picker.allowsEditing = YES;
        
        picker.delegate = self;//<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (IBAction)videoBtn {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    /*!
     *  @author 逍遥郎happy, 16-03-30 10:03:38
     *
     *  设置多媒体类型必须在设置摄像头捕获类型前面
     *         便于记忆:
                     1.创建对象
                     2.拾取源类型
                     3.多媒体类型
                     4.摄像头
                     5.录像质量
                     6.摄像头捕获类型
                     7.代理
     */
    
    //设置多媒体类型  @[(NSString *)kUTTypeVideo]这个是在头文件:#import <MobileCoreServices/MobileCoreServices.h>中,所以需要导入头文件
    picker.mediaTypes = @[(NSString *)kUTTypeMovie];//有录像,并且有声音;kUTTypeVideo有录像,无声音
    picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;//后置摄像头
    //设置录像的质量
    picker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
    
    //设置摄像头捕获类型 video:录像 photo:拍照(默认)
    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //读取/拍照
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        NSLog(@"----(NSString *)kUTTypeImage=%@",(NSString *)kUTTypeImage);
        UIImage *img;
        if (picker.allowsEditing) {
            img = info[UIImagePickerControllerEditedImage];//根据key获取编辑后选择的图片
        } else {
            img = info[UIImagePickerControllerOriginalImage];//根据key获取原始选择的图片
        }
        self.photo.image = img;
    }
    //录像部分
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSLog(@"=====(NSString *)kUTTypeMovie=%@",(NSString *)kUTTypeMovie);
        
        NSURL *url = info[UIImagePickerControllerMediaURL];//获取录像保存的url路径
        
        NSString *path = [url path];//把url路径转换为一个文件路径
        //判断是否可以保存到本地相册中
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path)) {
            UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//@selector(video:didFinishSavingWithError:contextInfo:)保存成功会回调一个方法,这个方法是固定的.
        }
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];//隐藏picker控制器
    
    NSLog(@"info=%@",info);
    /*
     不可编辑状态下
     info={
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x786a9d70> size {3000, 2002} orientation 0 scale 1.000000";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=9F983DBA-EC35-42B8-8773-B597CF782EDD&ext=JPG";
     }
     可编辑状态下
     info={
     UIImagePickerControllerCropRect = "NSRect: {{743, 369}, {794, 793}}";
     UIImagePickerControllerEditedImage = "<UIImage: 0x7c0d0a80> size {640, 640} orientation 0 scale 1.000000";
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x7c0d0bd0> size {2272, 1516} orientation 0 scale 1.000000";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=ED7AC36B-A150-4C38-BB8C-B6D696F4F2ED&ext=JPG";
     }
     录像
     info={
     UIImagePickerControllerMediaType = "public.movie";
     UIImagePickerControllerMediaURL = "file:///private/var/mobile/Containers/Data/Application/F0005957-2305-4AA9-9560-1A09F1CF616F/tmp/capture-T0x147d0f1a0.tmp.Qz5nF6/capturedvideo.MOV";
     }
     */
    
}
//是否保存成功的回调方法,固定格式,不能自己随便定义
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"error:%@",error.localizedDescription);
    } else {
        NSLog(@"保存成功");
        //保存成功后可以播放
        NSURL *url = [NSURL fileURLWithPath:videoPath];//把本地文件路径转换成一个url
        //创建播放视频的控制器
/**********   NO.1 MPMoviePlayerViewController***/
        //需要导入头文件  #import <MediaPlayer/MediaPlayer.h>
        MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [self presentViewController:player animated:YES completion:nil];

/**********   NO.2 AVPlayerViewController ******/
        /*
         //需要导入头文件  #import <AVKit/AVPlayerViewController.h>
        AVPlayerViewController *player1 = [[AVPlayerViewController alloc] init];
        player1.player = [[AVPlayer alloc] initWithURL:url];
        [self presentViewController:player1 animated:YES completion:nil];
        */
/**********   NO.3 AVPlayer  ******/
        //需要导入头文件  #import <AVFoundation/AVFoundation.h>
        /*
        AVPlayer *player2=[AVPlayer playerWithURL:url];
        AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:player2];
        playerLayer.frame=self.view.frame;
        [self.view.layer addSublayer:playerLayer];
        [player2 play];
         */
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];//隐藏picker控制器
}
- (IBAction)dengBtn {
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    if ([device hasTorch]) {
//        [device lockForConfiguration:nil];
//        [device setTorchMode: AVCaptureTorchModeOn];
//        [device unlockForConfiguration];
//    } else {
//        [device lockForConfiguration:nil];
//        [device setTorchMode: AVCaptureTorchModeOff];
//        [device unlockForConfiguration];
//    }
    
   //打开闪光灯
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];            if (![device hasTorch]) {//判断是否有闪光灯                NSLog(@"no torch");
    }else{                [device lockForConfiguration:nil];//锁定闪光灯
        [device setTorchMode: AVCaptureTorchModeOn];//打开闪光灯
        [device unlockForConfiguration];  //解除锁定
    }
    
    
       // 关闭闪光灯
        [device setTorchMode: AVCaptureTorchModeOff];

}
//闪光灯功能
- (IBAction)dengBtnClick:(UIButton *)sender {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([sender.titleLabel.text isEqualToString:@"打开"]) {
    
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOn];
            [device unlockForConfiguration];
            [sender setTitle:@"关闭" forState:UIControlStateNormal];
        }
    }
    if ([sender.titleLabel.text isEqualToString:@"关闭"]) {
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
            [sender setTitle:@"打开" forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
