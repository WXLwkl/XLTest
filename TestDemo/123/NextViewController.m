//
//  NextViewController.m
//  123
//
//  Created by xingl on 16/7/28.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController () <
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    [self showImage];
    [self showCollection];
}
- (void)showCollection {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    view.backgroundColor = [UIColor whiteColor];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    layout.minimumLineSpacing = 2;
//    layout.minimumInteritemSpacing = 2;
//    layout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
//    
//    CGFloat width = (view.bounds.size.width-10)/4;
//    layout.itemSize = CGSizeMake(width, width);
    
    view.delegate = self;
    view.dataSource = self;
    
    [self.view addSubview:view];
    
    [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"id"];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor grayColor];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:cell.bounds];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
    imgV.image = [self.arr objectAtIndex:indexPath.row];
    
    [cell.contentView addSubview:imgV];
    
    return cell;
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (collectionView.bounds.size.width-10)/4;
    CGSize itemSize = CGSizeMake(width, width);
    return itemSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets sectionInset = UIEdgeInsetsMake(2, 2, 0, 2);
    return sectionInset;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 2;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 2;
}


- (void)showImage {
    
    
    
    CGFloat Ww = [[UIScreen mainScreen] bounds].size.width;

    CGFloat width = (Ww-10)/4;

    
    for (int i = 0; i < self.arr.count; i++) {
        
        int x = (i%4)*(width+2)+2;
        int y = (i/4)*(width+2)+2;
        
        UIImageView *imgV = [[UIImageView alloc] init];
        
        imgV.frame = CGRectMake(x, y+64, width, width);
        
        imgV.contentMode = UIViewContentModeScaleToFill;
        
        imgV.image = self.arr[i];
        
        [self.view addSubview:imgV];
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
