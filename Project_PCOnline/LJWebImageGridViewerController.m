//
//  LJWebImageGridViewerController.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/14.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJWebImageGridViewerController.h"
#import "LJUrlHeader.h"
#import "LJCommonHeader.h"
#import "LJNetWorking.h"
#import "LJWebImageItem.h"
#import "LJWebImageGridViewerCell.h"
#import "UIImage+MyImage.h"
#import "LJWebImages.h"
#import "LJWebImageViewerController.h"

#define kWebImageGridViewerCellIdentifier @"WebImageGridViewerCell"

@interface LJWebImageGridViewerController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView * collectionView;

@property (nonatomic, strong) NSArray * photosData;

@end

@implementation LJWebImageGridViewerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick)];
    self.navigationItem.title = @"图片列表";
    [self.navigationController setNavigationBarHidden:NO];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - init UI
- (void)setupCollectionView
{
    CGFloat imgH = 70;
    CGFloat imgW = 90;
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(imgW, imgH);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView * collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kScrH - kNavBarH - kStatusBarH) collectionViewLayout:layout];
    [self.view addSubview:collection];
    self.collectionView = collection;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = LightGrayBGColor;
    [self.collectionView registerNib:[UINib nibWithNibName:@"LJWebImageGridViewerCell" bundle:nil] forCellWithReuseIdentifier:kWebImageGridViewerCellIdentifier];
}

#pragma mark - load data
- (NSArray *)photosData
{
    if (!_photosData)
    {
        _photosData = [NSArray array];
        [self loadPhotosData];
    }
    return _photosData;
}

- (void)loadPhotosData
{
    NSString * urlStr = [NSString stringWithFormat:kProductPhotosUrl, self.ID.integerValue];
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * photoDict in dict[@"data"]) {
            LJWebImageItem * item = [LJWebImageItem webImageItemWithDict:photoDict];
            [arr addObject:item];
        }
        _photosData  = [arr copy];
        [self.collectionView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - collectionView data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJWebImageGridViewerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWebImageGridViewerCellIdentifier forIndexPath:indexPath];
    LJWebImageItem * item = self.photosData[indexPath.item];
    cell.item = item;
    return cell;
}

#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJWebImageViewerController * viewer = [[LJWebImageViewerController alloc] init];
    LJWebImages * images = [LJWebImages webImagesWithImageItems:self.photosData andCurIndex:indexPath.item];
    viewer.webImages = images;
    [self.navigationController pushViewController:viewer animated:YES];
}


@end
