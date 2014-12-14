//
//  LJWebImageViewerController.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/13.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJWebImageViewerController.h"
#import "LJCommonHeader.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "MBProgressHUD+LJProgressHUD.h"

@interface LJWebImageViewerController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView * scrollView;
@property (nonatomic, strong) NSMutableArray * imageViews;

@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, assign) NSInteger imageCount;
@property (nonatomic, assign) NSInteger preLocation;

@property (nonatomic, weak) UIView * navView;
@property (nonatomic, weak) UIView * toolBarView;
@property (nonatomic, weak) UILabel * pageLab;
@end

@implementation LJWebImageViewerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (NSMutableArray *)imageViews
{
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarHidden = YES;
    if (self.curIndex > 0)
    {
        self.scrollView.contentOffset = CGPointMake(kScrW, 0);
    }
}

#pragma mark - init UI

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView = scrollView;
        [self.view addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        
        [self setupNavView];
        [self setupToolBarView];
    }
    return _scrollView;
}

- (void)setupImageViews
{
    //最多初始化3个imageView
    self.imageCount = self.webImages.photos.count >= 3 ? 3 : self.webImages.photos.count;
    for (int i = 0; i < self.imageCount; i++) {
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScrW, 0, kScrW, CGRectGetHeight(self.scrollView.frame))];
        [self.scrollView addSubview:image];
        [self.imageViews addObject:image];
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * self.imageCount, 0);
}

- (void)setupNavView
{
    UIView * navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kNavBarH)];
    [self.view addSubview:navView];
    self.navView = navView;
    self.navView.backgroundColor = [UIColor blackColor];
    
    //back button
    CGFloat padding = 10;
    CGFloat btnWH = CGRectGetHeight(self.navView.frame) - 2 * padding;
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(padding, padding, btnWH, btnWH)];
    [self.navView addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"btn_common_white_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setCurIndex:(NSInteger)curIndex
{
    _curIndex = curIndex;
    self.pageLab.text = [NSString stringWithFormat:@"%d/%d", self.curIndex + 1, self.webImages.total.integerValue];
}

- (void)setupToolBarView
{
    UIView * toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kScrH - kTabBarH, kScrW, kTabBarH)];
    [self.view addSubview:toolBarView];
    self.toolBarView = toolBarView;
    self.toolBarView.backgroundColor = [UIColor blackColor];
    
    //page lab
    CGFloat padding = 10;
    CGFloat labH = kTabBarH - 2 * padding;
    CGFloat labW = 100;
    UILabel * pageLab = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, labW, labH)];
    [self.toolBarView addSubview:pageLab];
    self.pageLab = pageLab;
    self.pageLab.textColor = [UIColor whiteColor];
    
    //download btn
    CGFloat btnWH = 30;
    CGFloat btnX = kScrW - btnWH - padding;
    CGFloat btnY = padding;
    UIButton * dlBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnWH, btnWH)];
    [dlBtn setImage:[UIImage imageNamed:@"btn_photo_download"] forState:UIControlStateNormal];
    [self.toolBarView addSubview:dlBtn];
    [dlBtn addTarget:self action:@selector(downloadImage:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)downloadImage:(id)sender
{
    NSString * urlStr = self.webImages.photos[self.curIndex];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (image)
        {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }];
}

- (void)image:(UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    [MBProgressHUD showNotificationMessage:@"保存成功" InView:self.scrollView];
}

#pragma mark - set image

- (void)setWebImages:(LJWebImages *)webImages
{
    _webImages = webImages;
    [self setupImageViews];
    
    self.curIndex = self.webImages.currentIndex.integerValue;
    if (self.curIndex != 0)
    {
        self.preLocation = 1;
    }
    else
    {
        self.preLocation = 0;
    }
    
    NSInteger startIndex = self.curIndex > 0 ? self.curIndex - 1 : 0;
    for (int i = startIndex; i < self.imageCount + startIndex; i++) {
        UIImageView * imageView = self.imageViews[i - startIndex];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.webImages.photos[i]] placeholderImage:[UIImage imageNamed:@"common_default_320x480"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(self.webImages.photos.count <= 3) return;
    
    NSInteger curLocation = scrollView.contentOffset.x / kScrW;
    if(curLocation == self.preLocation) return; //没有滑动
    
    //排除两边的情况
    if(self.curIndex == 1 && curLocation == 0)
    {
        self.curIndex--;
        self.preLocation = curLocation;
        return;
    }
    else if(self.curIndex == self.webImages.photos.count - 2 && curLocation == 2)
    {
        self.curIndex++;
        self.preLocation = curLocation;
        return;
    }
    
    //正常情况
    if (curLocation == 2) {
        for (int i = 0; i < self.imageCount; i++) {
            UIImageView * imageView = self.imageViews[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.webImages.photos[self.curIndex + i]] placeholderImage:[UIImage imageNamed:@"common_default_320x480"]];
        }
        self.scrollView.contentOffset = CGPointMake(kScrW, 0);
        self.curIndex++;
    }
    else if(curLocation == 0)
    {
        for (int i = 0; i < self.imageCount; i++) {
            UIImageView * imageView = self.imageViews[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.webImages.photos[self.curIndex - 2 + i]] placeholderImage:[UIImage imageNamed:@"common_default_320x480"]];
        }
        self.scrollView.contentOffset = CGPointMake(kScrW, 0);
        self.curIndex--;
    }
    else
    {
        if (self.preLocation > curLocation) {
            self.curIndex--;
        }
        else
        {
            self.curIndex++;
        }
        self.preLocation = curLocation;
    }
}

@end
