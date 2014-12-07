//
//  LJPhotoThumbShowView.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPhotoThumbShowView.h"
#import "UIImageView+WebCache.h"
#import "LJCommonHeader.h"
#import "LJPhoto.h"
#define viewW 120
#define upOffset 40
#define downOffset 78
#define kPhotoThumbCellIdentifier @"photoThumbCell"
@interface LJPhotoThumbShowView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView * photoCollectionView;
@property (nonatomic, strong) NSArray * photos;
@property (nonatomic, copy) void (^selectBlock)(NSInteger);

@end

@implementation LJPhotoThumbShowView

- (id)initWithPhotos:(NSArray *)photos andSelectActionBlock:(void (^)(NSInteger index))selectBlock
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 60);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    if (self = [super initWithFrame:CGRectMake(kScrW, upOffset, viewW, kScrH - upOffset - downOffset) collectionViewLayout:flowLayout]) {
        self.dataSource = self;
        self.delegate = self;
        self.photos = photos;
        self.selectBlock = selectBlock;
        self.backgroundColor = [UIColor blackColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kPhotoThumbCellIdentifier];
    }
    return self;
}

#pragma mark - 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJPhoto * photo = self.photos[indexPath.item];
    UIImageView * photoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
    [photoView sd_setImageWithURL:[NSURL URLWithString:photo.tumbUrl] placeholderImage:[UIImage imageNamed:@"common_default_88x66"]];
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoThumbCellIdentifier forIndexPath:indexPath];
    cell.opaque = NO;
    [cell.contentView addSubview:photoView];
    return cell;
}

#pragma mark - collectionview 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectBlock(indexPath.item);
}

@end
