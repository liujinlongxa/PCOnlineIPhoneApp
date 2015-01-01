//
//  LJNewsViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNewsViewController.h"
#import "UIImage+MyImage.h"
#import "LJSubjectView.h"
#import "LJCommonData.h"
#import "LJNewsNormalCell.h"
#import "MJRefresh.h"
#import "LJNewsDetailController.h"
#import "LJSelectButton.h"
//模型
#import "LJSubject.h"
#import "LJNews.h"
#import "LJAds.h"
//tableview
#import "LJTopNewsTableView.h"
#import "LJLiveTableView.h"
#import "LJPriceTableView.h"
#import "LJNormalTableView.h"
#import "LJBaseCustomTableView.h"

#import "LJChannelSelectViewController.h"
#import "LJAreaTableViewController.h"


@interface LJNewsViewController ()< LJSubjectViewDelegate, LJCustomTableViewDelegate, UIScrollViewDelegate, LJChannelSelectViewControllerDelegate, LJAreaTableViewControllerDelegate>

@property (nonatomic, weak) UIScrollView * scrollView;

@property (nonatomic, strong) LJSubject * curSubject;
@property (nonatomic, strong) NSArray * subjects;
@property (nonatomic, weak) LJSubjectView * subjectView;

@property (nonatomic, weak) LJPriceTableView * priceTableView;

//频道定制
@property (nonatomic, strong) LJChannelSelectViewController * channelSelectVC;//频道定制控制器
@property (nonatomic, assign, getter=isChannelSelect) BOOL channelSelect;//是否正在定制频道
@property (nonatomic, strong) UIView * shadowView; //引用
@property (nonatomic, strong) UIView * channelSelectView;//显示频道选择视图的区域
@property (nonatomic, strong) UILabel * shadowLabel;
@end

@implementation LJNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageWithNameNoRender:@"pconline_top_title"]];
    
    //初始化频道选择滚动条
    [self setupSubjectView];
    
    //初始化滚动视图
    [self setupScrollView];
    
    //设置TableView
    [self setupTableView];
    
    //默认选中头条
    LJBaseCustomTableView * table = self.scrollView.subviews[0];
    [table beginRefresh];
    
    //注册广告点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adsClikc:) name:LJAdsViewTapNotify object:nil];
    
    //定位按钮点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loctionSelect:) name:kLJPriceTableLocationButtonClickNotification object:nil];

    [self setupShadowLabel];
}

- (void)setupSubjectView
{
    //添加栏目条
    LJSubjectView * subjectView = [LJSubjectView subjectView];
    [self.view addSubview:subjectView];
    self.subjectView = subjectView;
    subjectView.delegate = self;
    subjectView.subjects = self.subjects;
}

- (NSArray *)subjects
{
    return [LJCommonData shareCommonData].curShowSubjectsData;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//初始化滚动视图
- (void)setupScrollView
{
    //设置scrollview
    CGFloat scrollX = 0;
    CGFloat scrollY = CGRectGetMaxY(self.subjectView.frame);
    CGFloat scrollH = kScrH - 2 * kNavBarH - kStatusBarH - kTabBarH;
    CGFloat scrollW = kScrW;
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(scrollX, scrollY, scrollW, scrollH)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
}

//初始化表格视图
- (void)setupTableView
{
                            
    CGFloat tabH = CGRectGetHeight(self.scrollView.frame);
    CGFloat tabW = CGRectGetWidth(self.scrollView.frame);
    for (int i = 0; i < self.subjects.count; i++) {
        LJBaseCustomTableView * table = nil;
        LJSubject * subject = self.subjects[i];
        
        if ([subject.title isEqualToString:@"头条"])
        {
            table = [[LJTopNewsTableView alloc] init];
        }
        else if([subject.title isEqualToString:@"行情"])
        {
            table = [[LJPriceTableView alloc] init];
            self.priceTableView = (LJPriceTableView *)table;
        }
        else
        {
            table = [[LJNormalTableView alloc] init];
        }
        ((LJNormalTableView *)table).subject = subject;
        table.frame = CGRectMake(i * tabW, 0, tabW, tabH);
        table.customDelegate = self;
        [self.scrollView addSubview:table];
    }
    self.scrollView.contentSize = CGSizeMake(self.subjects.count * tabW, 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    //设置状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 选择频道
- (void)subjectView:(LJSubjectView *)subjectView didSelectButton:(LJSelectButton *)sender
{
    self.scrollView.contentOffset = CGPointMake(sender.tag * CGRectGetWidth(self.scrollView.frame), 0);
    LJBaseCustomTableView * table = self.scrollView.subviews[sender.tag];
    [table beginRefresh];
    self.curSubject = self.subjects[sender.tag];
}

- (void)subjectView:(LJSubjectView *)subjectView didSelectSubject:(LJSubject *)subject
{
    NSInteger index = [self.subjects indexOfObject:subject];
    self.scrollView.contentOffset = CGPointMake(index * CGRectGetWidth(self.scrollView.frame), 0);
    LJBaseCustomTableView * table = self.scrollView.subviews[index];
    [table beginRefresh];
    self.curSubject = subject;
    self.subjectView.selectIndex = index;
}

#pragma mark - 选择某条新闻代理方法
- (void)customTableView:(LJBaseCustomTableView *)tableView didSelectCellWithObject:(id)object
{
    if ([object isKindOfClass:[LJNews class]]) {
        LJNews * news = (LJNews *)object;
        LJNewsDetailController * detailVC = [[LJNewsDetailController alloc] init];
        detailVC.news = news;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - 滚动视图代理方法
//滚动到一个新的视图调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / kScrW;
    LJBaseCustomTableView * table = self.scrollView.subviews[index];
    [table beginRefresh];
    self.subjectView.selectIndex = index;
    self.curSubject = self.subjects[index];
}

#pragma mark - 广告点击
- (void)adsClikc:(NSNotification *)notify
{
    id ad = notify.userInfo[LJAdsViewTapNotifyAdsKey];
    if ([ad isKindOfClass:[LJAds class]]) {
        LJAds * newsAd = (LJAds *)ad;
        LJNewsDetailController * detailVC = [[LJNewsDetailController alloc] init];
        detailVC.ads = newsAd;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - 频道定制相关
- (void)subjectView:(LJSubjectView *)subjectView didSelectMoreButton:(UIButton *)moreBtn
{
    //如果用户中心侧滑显示，则先隐藏侧滑，再显示频道定制
    [self.revealSideViewController popViewControllerAnimated:YES completion:^{
        if (self.isChannelSelect) {
            [self.channelSelectVC saveChannelList];
            [self updateSubjectView];
            [self hideChannelSelectViewWithCompletion:nil];
        }
        else
        {
            [self showChannelSelectView];
        }
    }];
}

//更新频道设置
- (void)updateSubjectView
{
    [self.subjectView removeFromSuperview];
    [self setupSubjectView];
    
    for (UIView * view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    [self setupTableView];
    
    //默认选中头条
    if ([self.subjects containsObject:self.curSubject]) {
        [self subjectView:self.subjectView didSelectSubject:self.curSubject];
    }
    else
    {
        [self subjectView:self.subjectView didSelectSubject:self.subjects[0]];
    }
}

//设置频道选择时盖在subjectView上的Label
- (void)setupShadowLabel
{
    CGFloat labH = 44;
    CGFloat labW = kScrW - labH;
    
    UILabel * shadowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labW, labH)];
    [self.view addSubview:shadowLabel];
    self.shadowLabel = shadowLabel;
    self.shadowLabel.text = @"   现有栏目，拖动标签可以调整顺序";
    self.shadowLabel.backgroundColor = LightGrayBGColor;
    self.shadowLabel.textColor = [UIColor lightGrayColor];
    self.shadowLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.shadowLabel.layer.borderWidth = 0.5;
    self.shadowLabel.hidden = YES;
}

//隐藏频道选择view
- (void)hideChannelSelectViewWithCompletion:(void (^)())completionBlock
{
    CGRect showViewF = self.channelSelectView.frame;
    showViewF.size.height = 0;
    //设置消失的动画
    [UIView animateWithDuration:0.5 animations:^{
        self.channelSelectView.frame = showViewF;
        self.shadowView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
        self.shadowView = nil;
        [self.channelSelectView removeFromSuperview];
        self.channelSelectView = nil;
        self.channelSelect = NO;
        self.shadowLabel.hidden = YES;
        //回调
        if (completionBlock) completionBlock();
    }];
}

//显示频道选择View
- (void)showChannelSelectView
{
    self.shadowLabel.hidden = NO;
    [self.view bringSubviewToFront:self.shadowLabel];
    
    //shadowView
    UIView * shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.subjectView.frame) + kStatusBarH + kNavBarH, kScrW, kScrH - kNavBarH - kStatusBarH - CGRectGetHeight(self.subjectView.frame))];
    [self.view.window addSubview:shadowView];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.alpha = 0;
    self.shadowView = shadowView;
    
    //add select channel vc's view
    LJChannelSelectViewController * channelSelectVC = [[LJChannelSelectViewController alloc] init];
    CGRect viewF = channelSelectVC.view.frame;
    viewF.size.height = CGRectGetMaxY(channelSelectVC.hideChannelView.frame);
    channelSelectVC.view.frame = viewF;
    self.channelSelectVC = channelSelectVC;//必须把控制器记录下来否则过了这个方法，控制器就被释放了
    self.channelSelectVC.delegate = self;
    
    //show view
    CGRect showViewF = CGRectMake(0, kNavBarH + kStatusBarH + CGRectGetHeight(self.subjectView.frame), kScrW, 0);
    UIView * showView = [[UIView alloc] initWithFrame:showViewF];
    [self.view.window addSubview:showView];
    self.channelSelectView = showView;
    [self.channelSelectView addSubview:channelSelectVC.view];
    self.channelSelectView.clipsToBounds = YES;
    showViewF.size.height = viewF.size.height;
    
    //设置显示动画
    [UIView animateWithDuration:0.5 animations:^{
        self.shadowView.alpha = 0.7;
        showView.frame = showViewF;
    } completion:^(BOOL finished) {
        self.channelSelect = YES;
    }];
}

//代理方法
- (void)channelSelectViewControllerShowViewFrame:(LJChannelSelectViewController *)controller
{
    CGRect channelSelectViewFrame = self.channelSelectView.frame;
    channelSelectViewFrame.size.height = CGRectGetMaxY(self.channelSelectVC.hideChannelView.frame);
    [UIView animateWithDuration:0.5 animations:^{
        self.channelSelectView.frame = channelSelectViewFrame;
    }];
    
}

//重写导航栏按钮点击事件，在点击时先隐藏频道定制View
- (void)searchBtnClick:(id)sender
{
    if (self.isChannelSelect) {
        [self hideChannelSelectViewWithCompletion:^{
            [super searchBtnClick:sender];
        }];
    }
    else
    {
        [super searchBtnClick:sender];
    }
}

- (void)userCenterClick:(id)sender
{
    if (self.isChannelSelect) {
        [self hideChannelSelectViewWithCompletion:^{
            [super userCenterClick:sender];
        }];
    }
    else
    {
        [super userCenterClick:sender];
    }
}

#pragma mark - 定位
- (void)loctionSelect:(NSNotification *)notify
{
    LJAreaTableViewController * areaVC = [[LJAreaTableViewController alloc] init];
    areaVC.delegate = self;
    [self.navigationController pushViewController:areaVC animated:YES];
}

- (void)areaTableViewController:(LJAreaTableViewController *)controller didSelectArea:(LJArea *)area
{
    self.priceTableView.curArea = area;
    [self.priceTableView beginRefresh];
    [self.priceTableView showData];
}

@end
