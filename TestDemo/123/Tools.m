//
//  Tools.m
//  123
//
//  Created by xingl on 16/7/28.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "Tools.h"

#import "Model.h"

@implementation Tools

//获得所有相簿的原图
+ (NSMutableArray *)getOriginalImages
{
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
    
    
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;

    
    // 遍历相机胶卷,获取大图
    Model *model =  [Tools enumerateAssetsInAssetCollection:cameraRoll original:YES];
    [mArr addObject:model];
    
    
    
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        Model *model = [Tools enumerateAssetsInAssetCollection:assetCollection original:YES];
        [mArr addObject:model];
    }
    
    return mArr;
}


//获得所有相簿中的缩略图
- (void)getThumbnailImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [Tools enumerateAssetsInAssetCollection:assetCollection original:NO];
    }
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [Tools enumerateAssetsInAssetCollection:cameraRoll original:NO];
}


/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
+ (Model *)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original {
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:0];
    
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            [mArr addObject:result];
        }];
    }
    
    Model *model =  [Tools modelWithResult:mArr name:assetCollection.localizedTitle];
    return model;
}

+ (Model *)modelWithResult:(id)result name:(NSString *)name{
    Model *model = [[Model alloc] init];
    model.Array = result;
    model.name = name;
    return model;
}


+ (NSMutableArray *)getAllPhoto{
    
    NSMutableArray *arr = [NSMutableArray array];
    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        
        PHCollection *collection = smartAlbums[i];
        //遍历获取相册 PHAssetCollection
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            PHAsset *asset = nil;
            if (fetchResult.count != 0) {
                for (NSInteger j = 0; j < fetchResult.count; j++) {
                    //从相册中取出照片
                    asset = fetchResult[j];
                    PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
                    opt.synchronous = YES;
                    PHImageManager *imageManager = [[PHImageManager alloc] init];
                    [imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFill options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                        if (result) {
                            
                            [arr addObject:result];
                        }
                    }];
                }
            }
        }
    }
    
    //返回所有照片
    return arr;
}


@end
