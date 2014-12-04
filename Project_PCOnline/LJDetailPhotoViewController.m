//
//  LJDetailPhotoViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJDetailPhotoViewController.h"
#import "LJNetWorking.h"
#import "LJPhoto.h"
#import "LJPhotoCollectionViewCell.h"
#import "UIImage+MyImage.h"
#import "UIImageView+WebCache.h"

#define kLJPhotoCollectionViewCellIndeifier @"LJPhotoCollectionViewCell"

@interface LJDetailPhotoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UILabel *pageLab;
- (IBAction)downLoadClick:(id)sender;
- (IBAction)showBtnClick:(id)sender;

@property (nonatomic, weak) UIView * tabView;
//@property (nonatomic, weak) UICollectionView * collectionView;
@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, strong) NSMutableArray * photosData;
@property (nonatomic, assign, getter=isShow) BOOL show;//导航栏隐藏
@end

@implementation LJDetailPhotoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置滚动视图
    [self setupCollectionView];
    
    //设置底部tabview
    [self setupTabView];
    
    //设置导航栏
    [self setupNavBar];
    
    self.show = YES;
    
    [self loadPhotosData];
}

#pragma mark - 初始化UI
- (void)setupCollectionView
{
//    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.minimumLineSpacing = 0;
//    flowLayout.minimumInteritemSpacing = 0;
//    flowLayout.itemSize = CGSizeMake(320, 400);
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds  collectionViewLayout:flowLayout];
//    [self.view addSubview:collectionView];
//    self.collectionView = collectionView;
//    self.collectionView.dataSource = self;
//    self.collectionView.delegate = self;
//    self.collectionView.pagingEnabled = YES;
//    [self.collectionView registerNib:[UINib nibWithNibName:@"LJPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kLJPhotoCollectionViewCellIndeifier];
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupTabView
{
    UIView * tabView = [[[UINib nibWithNibName:@"LJDetailPhotoTabView" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
    [self.view addSubview:tabView];
    self.tabView = tabView;
    CGRect viewF = self.tabView.frame;
    viewF.origin = CGPointMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(viewF));
    self.tabView.frame = viewF;
    self.pageLab.text = [NSString stringWithFormat:@"1/%d", [self.group.photoCount integerValue]];
    self.descLab.text = self.group.name;
    
}

- (void)setupNavBar
{
    //设置导航栏的颜色
    UIColor * blackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    UIImage * image = [UIImage imageWithColor:blackColor];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_photo_share"] style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 加载数据
-(NSMutableArray *)photosData
{
    if (!_photosData) {
        _photosData = [NSMutableArray array];
//        [self loadPhotosData];
    }
    return _photosData;
}

- (void)loadPhotosData
{
    NSString * urlStr = self.group.url;
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * photoDict in dict[@"photos"]) {
            LJPhoto * photo = [LJPhoto photoWithDict:photoDict];
            [arr addObject:photo];
        }
        self.photosData = arr;
        [self setupPhoto];
//        [self.collectionView reloadData];
        
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        
    }];
}

- (void)setupPhoto
{
    for (int i = 0; i < self.photosData.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScrW, 0, kScrW, kScrH)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        LJPhoto * photo = self.photosData[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:photo.url] placeholderImage:[UIImage imageNamed:@"common_default_320x480"]];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(self.photosData.count * kScrW, 0);
}

#pragma mark - collectionView代理方法
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return self.photosData.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    LJPhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLJPhotoCollectionViewCellIndeifier forIndexPath:indexPath];
//    LJPhoto * photo = self.photosData[indexPath.item];
//    cell.photo = photo;
//#warning 调节cell，有没有其他方法？？？
//    CGRect cellF = cell.frame;
//    cellF.origin.y = -64;
//    cell.frame = cellF;
//    return cell;
//}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSInteger index = scrollView.contentOffset.x / kScrW;
//    self.pageLab.text = [NSString stringWithFormat:@"%d/%d", index + 1, self.photosData.count];
//    LJPhotoCollectionViewCell * cell = [self.collectionView.visibleCells firstObject];
//    self.descLab.text = cell.photo.name;
//}
//
//#pragma mark - 选中某个cell
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat tabViewH = CGRectGetHeight(self.tabView.frame);
//    __block CGRect tabViewF = self.tabView.frame;
//    if (self.isShow) {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        NSLog(@"111%@", NSStringFromCGRect(self.collectionView.frame));
//        tabViewF.origin.y = kScrH;
//        [UIView animateWithDuration:1.0 animations:^{
//            self.tabView.frame = tabViewF;
//        }];
//        self.show = NO;
//    }
//    else
//    {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        NSLog(@"222%@", NSStringFromCGRect(self.collectionView.frame));
//        tabViewF.origin.y = kScrH - tabViewH;
//        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
//            self.tabView.frame = tabViewF;
//        }];
//        self.show = YES;
//    }
//}

- (IBAction)downLoadClick:(id)sender {
}

- (IBAction)showBtnClick:(id)sender {
}





@end
