//
//  LJDetailPhotoViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJDetailPhotoViewController.h"
#import "LJNetWorkingTool.h"
#import "LJPhoto.h"
#import "LJPhotoCollectionViewCell.h"
#import "UIImage+MyImage.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "LJPhotoThumbShowView.h"
#import "MBProgressHUD+LJProgressHUD.h"
#import "ShareSDK/ShareSDK.h"

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
@property (nonatomic, strong) LJPhotoThumbShowView * photoThumbView;

@property (nonatomic, strong) NSMutableArray * photosData;
@property (nonatomic, assign, getter=isShow) BOOL show;//导航栏隐藏
@property (nonatomic, assign, getter=isThumbShow) BOOL tuumbShow;
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
    //方法
    self.collectionView.maximumZoomScale = 2.0;
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

- (LJPhotoThumbShowView *)photoThumbView
{
    if (!_photoThumbView) {
        _photoThumbView = [[LJPhotoThumbShowView alloc] initWithPhotos:[self.photosData copy] andSelectActionBlock:^(NSInteger index) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            self.pageLab.text = [NSString stringWithFormat:@"%d/%d", index + 1, self.photosData.count];
            LJPhotoCollectionViewCell * cell = [self.collectionView.visibleCells firstObject];
            self.descLab.text = cell.photo.name;
        }];
        [self.view insertSubview:_photoThumbView belowSubview:self.tabView];
    }
    return _photoThumbView;
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
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * photoDict in dict[@"photos"]) {
            LJPhoto * photo = [LJPhoto photoWithDict:photoDict];
            [arr addObject:photo];
        }
        self.photosData = arr;
        [self.collectionView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NetworkErrorNotify(self);
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
    static BOOL isAnimating = NO;
    if (isAnimating) return;//如果正在动画，返回
    
    //设置动画，隐藏navView和TabView
    CGFloat tabViewH = CGRectGetHeight(self.tabView.frame);
    __block CGRect tabViewF = self.tabView.frame;
    __block CGRect navViewF = self.navView.frame;
    __block CGRect thumbViewF = self.photoThumbView.frame;
    if (self.isShow) {
        tabViewF.origin.y = kScrH;
        navViewF.origin.y = -CGRectGetHeight(self.navView.frame);
        if (self.isThumbShow) {//设置thumb view
            thumbViewF.origin.x = kScrW;
            self.tuumbShow = !self.isThumbShow;
            [self.showBtn setImage:[UIImage imageNamed:@"btn_photo_show_album"] forState:UIControlStateNormal];
        }
        //执行动画
        [UIView animateWithDuration:1.0 animations:^{
            isAnimating = YES;
            self.tabView.frame = tabViewF;
            self.navView.frame = navViewF;
            self.photoThumbView.frame = thumbViewF;
        }completion:^(BOOL finished) {
            isAnimating = NO;
            self.show = NO;
        }];
        
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

#pragma mark - 下载按钮点击
- (IBAction)downLoadClick:(id)sender {
    
    LJPhotoCollectionViewCell * cell = [self.collectionView.visibleCells firstObject];
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
    LJPhoto * photo = self.photosData[indexPath.item];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:photo.url] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image)
        {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [MBProgressHUD showNotificationMessage:@"保存成功" InView:self.collectionView];
}

#pragma mark - 缩略图视图
- (IBAction)showBtnClick:(id)sender {
    
    static BOOL isAnimating = NO;
    //是否正在进行动画
    if(isAnimating) return;
    
    CGRect viewF = self.photoThumbView.frame;
    if (self.isThumbShow)
    {
        viewF.origin.x = kScrW;
        [self.showBtn setImage:[UIImage imageNamed:@"btn_photo_show_album"] forState:UIControlStateNormal];
    }
    else
    {
        viewF.origin.x = kScrW - CGRectGetWidth(viewF);;
        [self.showBtn setImage:[UIImage imageNamed:@"btn_photo_hide_album"] forState:UIControlStateNormal];
    }
    
    
    [UIView animateWithDuration:1.0f animations:^{
        isAnimating = YES;
        self.photoThumbView.frame = viewF;
    } completion:^(BOOL finished) {
        self.tuumbShow = !self.isThumbShow;
        isAnimating = NO;
    }];
}


#pragma mark - 分享
- (IBAction)shareBtnClick:(id)sender {
    
    LJPhotoCollectionViewCell * cell = [self.collectionView.visibleCells firstObject];
    LJPhoto * photo = cell.photo;
    NSLog(@"%@", cell.photoImage.sd_imageURL);
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:photo.name
                                       defaultContent:nil
                                                image:[ShareSDK imageWithUrl:cell.photoImage.sd_imageURL.absoluteString]
                                                title:nil
                                                  url:nil
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //显示编辑框
    [ShareSDK showShareViewWithType:ShareTypeSinaWeibo
              container:nil
                content:publishContent
          statusBarTips:YES
            authOptions:nil
           shareOptions:nil
                 result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                     
                     if (state == SSPublishContentStateSuccess)
                     {
                         [MBProgressHUD showNotificationMessage:@"分享成功" InView:self.view];
                     }
                     else if (state == SSPublishContentStateFail)
                     {
                         [MBProgressHUD showNotificationMessage:@"分享失败" InView:self.view];
                     }
                     else
                     {
                         NSLog(@"other");
                     }
                 }];
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





@end
