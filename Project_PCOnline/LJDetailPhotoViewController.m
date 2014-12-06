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

- (IBAction)shareBtnClick:(id)sender;
- (IBAction)backBtnClick:(id)sender;


@property (nonatomic, weak) UIView * tabView;
@property (nonatomic, weak) UIView * navView;
@property (nonatomic, weak) UICollectionView * collectionView;

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
    [UIApplication sharedApplication].statusBarHidden = YES;
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
    //初始化布局
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(kScrW, kScrH);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //初始化集合视图
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds  collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"LJPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kLJPhotoCollectionViewCellIndeifier];
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
    [self.navigationController setNavigationBarHidden:YES];
    UIView * navView = [[[UINib nibWithNibName:@"LJPhotoNavView" bundle:nil] instantiateWithOwner:self options:nil]firstObject];
    CGRect navViewF = navView.frame;
    navViewF.origin = CGPointMake(0, 0);
    navView.frame = navViewF;
    [self.view addSubview:navView];
    self.navView = navView;
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
        [self.collectionView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        
    }];
}

#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJPhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLJPhotoCollectionViewCellIndeifier forIndexPath:indexPath];
    LJPhoto * photo = self.photosData[indexPath.item];
    cell.photo = photo;
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / kScrW;
    self.pageLab.text = [NSString stringWithFormat:@"%d/%d", index + 1, self.photosData.count];
    LJPhotoCollectionViewCell * cell = [self.collectionView.visibleCells firstObject];
    self.descLab.text = cell.photo.name;
}

#pragma mark - 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //设置动画，隐藏navView和TabView
    CGFloat tabViewH = CGRectGetHeight(self.tabView.frame);
    __block CGRect tabViewF = self.tabView.frame;
    __block CGRect navViewF = self.navView.frame;
    if (self.isShow) {
        tabViewF.origin.y = kScrH;
        navViewF.origin.y = -CGRectGetHeight(self.navView.frame);
        [UIView animateWithDuration:1.0 animations:^{
            self.tabView.frame = tabViewF;
            self.navView.frame = navViewF;
        }];
        self.show = NO;
    }
    else
    {
        tabViewF.origin.y = kScrH - tabViewH;
        navViewF.origin.y = 0;
        [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
            self.tabView.frame = tabViewF;
            self.navView.frame = navViewF;
        }];
        self.show = YES;
    }
}

- (IBAction)downLoadClick:(id)sender {
}

- (IBAction)showBtnClick:(id)sender {
}

- (IBAction)shareBtnClick:(id)sender {
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





@end
