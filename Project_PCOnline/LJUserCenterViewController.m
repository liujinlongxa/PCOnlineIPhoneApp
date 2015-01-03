//
//  LJUserSettingViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJUserCenterViewController.h"
#import "PPRevealSideViewController.h"
#import "LJLoginButton.h"
#import "LJCommonHeader.h"
#import "LJBigSettingButton.h"
#import "LJSmallSettingButton.h"
#import "LJUserSettingTVC.h"

//collection
#import "LJCollectionViewController.h"
#import "LJArticleCollectionTVC.h"
#import "LJBBSCollectionTVC.h"
#import "LJTopicCollectionTVC.h"

#define Padding 10
#define ViewOffsetX 80

@interface LJUserCenterViewController ()

//background
@property (nonatomic, strong) UIImageView * imageView;

//ui
@property (nonatomic, weak) LJLoginButton * loginButton; //登录
@property (nonatomic, weak) UIButton * notifyButton; //通知

@property (nonatomic, weak) LJBigSettingButton * myPostButton;//我发表的
@property (nonatomic, weak) LJBigSettingButton * myMsgButton;//我的消息
@property (nonatomic, weak) LJBigSettingButton * myCollButton;//个人收藏
@property (nonatomic, weak) LJBigSettingButton * downButton;//离线下载

@property (nonatomic, weak) UIButton * settingButton;//设置
@property (nonatomic, weak) UIButton * connectButton;//联系我们
@property (nonatomic, weak) UISwitch * nightSwich;//夜晚模式
@property (nonatomic, weak) UILabel * versionLab;//版本号
@end

@implementation LJUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.image = [UIImage imageNamed:@"bg_user_center"];
    [self.view addSubview:self.imageView];
    self.revealSideViewController.fakeiOS7StatusBarColor = [UIColor clearColor];
    
    [self setupLoginButton];
    [self setupNotifyButton];
    [self setupBigButton];
    [self setupSmallButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.revealSideViewController changeOffset:DefaultOffset forDirection:PPRevealSideDirectionRight];
    self.revealSideViewController.options |= PPRevealSideOptionsShowShadows;
}

#pragma mark - init UI

/**
 *  登录按钮
 */
- (void)setupLoginButton
{
    CGFloat btnX = ViewOffsetX;
    CGFloat btnW = kScrW - btnX;
    CGFloat btnH = 50;
    LJLoginButton * button = [[LJLoginButton alloc] initWithFrame:CGRectMake(btnX, kStatusBarH, btnW, btnH) andImage:[UIImage imageNamed:@"imageview_user_defultphoto"] andTitle:@"点击登录" andSubtitle:@"登录后，参见有奖活动更方便"];
    [self.view addSubview:button];
    self.loginButton = button;
}

/**
 *  初始化通知按钮
 */
- (void)setupNotifyButton
{
    CGFloat notifyX = self.loginButton.frame.origin.x;
    CGFloat notifyY = CGRectGetMaxY(self.loginButton.frame) + Padding;
    CGFloat notifyW = kScrW - ViewOffsetX;
    CGFloat notifyH = 20;
    UIButton * notifyButton = [[UIButton alloc] initWithFrame:CGRectMake(notifyX, notifyY, notifyW, notifyH)];
    [notifyButton setImage:[UIImage imageNamed:@"bg_usercenter_speaker"] forState:UIControlStateNormal];
    [notifyButton setTitle:@"  海量新奇IT产品免费使用" forState:UIControlStateNormal];
    [notifyButton setTintColor:[UIColor whiteColor]];
    [notifyButton setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.3]];
    notifyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:notifyButton];
    self.notifyButton = notifyButton;
}

/**
 *  初始化大按钮
 */
- (void)setupBigButton
{
    CGFloat btnW = 60;
    CGFloat btnH = 80;
    CGFloat btnOffset = 80;
    UIFont * titleFont = [UIFont systemFontOfSize:15];
    
    //my post
    CGFloat postX = ViewOffsetX + Padding;
    CGFloat postY = CGRectGetMaxY(self.notifyButton.frame) + Padding;
    LJBigSettingButton * postButton = [[LJBigSettingButton alloc] initWithFrame:CGRectMake(postX, postY, btnW, btnH)];
    [self.view addSubview:postButton];
    self.myPostButton = postButton;
    [self.myPostButton setImage:[UIImage imageNamed:@"btn_my_post"] forState:UIControlStateNormal];
    [self.myPostButton setTitle:@"我发表的" forState:UIControlStateNormal];
    self.myPostButton.titleLabel.font = titleFont;
    
    //my msg
    CGFloat msgX = CGRectGetMaxX(self.myPostButton.frame) + btnOffset;
    CGFloat msgY = postY;
    LJBigSettingButton * msgButton = [[LJBigSettingButton alloc] initWithFrame:CGRectMake(msgX, msgY, btnW, btnH)];
    [self.view addSubview:msgButton];
    self.myMsgButton = msgButton;
    [self.myMsgButton setImage:[UIImage imageNamed:@"btn_my_msg"] forState:UIControlStateNormal];
    [self.myMsgButton setTitle:@"我的消息" forState:UIControlStateNormal];
    self.myMsgButton.titleLabel.font = titleFont;
    
    //my collection
    CGFloat collX = postX;
    CGFloat collY = CGRectGetMaxY(self.myPostButton.frame) + Padding;
    LJBigSettingButton * collButton = [[LJBigSettingButton alloc] initWithFrame:CGRectMake(collX, collY, btnW, btnH)];
    [self.view addSubview:collButton];
    self.myCollButton = collButton;
    [self.myCollButton setImage:[UIImage imageNamed:@"btn_user_center_fav"] forState:UIControlStateNormal];
    [self.myCollButton setTitle:@"个人收藏" forState:UIControlStateNormal];
    self.myCollButton.titleLabel.font = titleFont;
    [self.myCollButton addTarget:self action:@selector(collectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //my msg
    CGFloat dlX = msgX;
    CGFloat dlY = collY;
    LJBigSettingButton * downloadButton = [[LJBigSettingButton alloc] initWithFrame:CGRectMake(dlX, dlY, btnW, btnH)];
    [self.view addSubview:downloadButton];
    self.downButton = downloadButton;
    [self.downButton setImage:[UIImage imageNamed:@"btn_user_center_offline_download"] forState:UIControlStateNormal];
    [self.downButton setTitle:@"离线下载" forState:UIControlStateNormal];
    self.downButton.titleLabel.font = titleFont;
}

/**
 *  设置小按钮
 */
- (void)setupSmallButton
{
    CGFloat imagWH = 22;
    CGFloat btnW = kScrW - ViewOffsetX - imagWH - Padding;
    CGFloat btnH = 22;
    
    //line1
    CGFloat line1Y = CGRectGetMaxY(self.myCollButton.frame) + Padding;
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(ViewOffsetX, line1Y, kScrW - ViewOffsetX, 1)];
    [self.view addSubview:line1];
    line1.backgroundColor = [UIColor lightGrayColor];
    
    //setting image
    CGFloat settingImageY = CGRectGetMaxY(line1.frame) + Padding;
    UIImageView * settingImage = [[UIImageView alloc] initWithFrame:CGRectMake(ViewOffsetX, settingImageY, imagWH, imagWH)];
    [self.view addSubview:settingImage];
    settingImage.image = [UIImage imageNamed:@"btn_user_center_setting"];
    
    //setting button
    CGFloat settingButtonX = CGRectGetMaxX(settingImage.frame) + Padding;
    LJSmallSettingButton * settingButton = [[LJSmallSettingButton alloc] initWithFrame:CGRectMake(settingButtonX, settingImageY, btnW, btnH) andTitle:@"设置"];
    [self.view addSubview:settingButton];
    self.settingButton = settingButton;
    [self.settingButton addTarget:self action:@selector(settingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //line2
    CGFloat line2Y = CGRectGetMaxY(self.settingButton.frame) + Padding;
    CGFloat line2X = settingButtonX;
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(line2X, line2Y, kScrW - line2X, 1)];
    [self.view addSubview:line2];
    line2.backgroundColor = [UIColor lightGrayColor];
    
    //connect image
    CGFloat connectImageY = CGRectGetMaxY(line2.frame) + Padding;
    UIImageView * connectImage = [[UIImageView alloc] initWithFrame:CGRectMake(ViewOffsetX, connectImageY, imagWH, imagWH)];
    [self.view addSubview:connectImage];
    connectImage.image = [UIImage imageNamed:@"btn_user_center_feedback"];
    
    //connect button
    CGFloat connectButtonX = CGRectGetMaxX(connectImage.frame) + Padding;
    LJSmallSettingButton * connectButton = [[LJSmallSettingButton alloc] initWithFrame:CGRectMake(connectButtonX, connectImageY, btnW, btnH) andTitle:@"意见反馈"];
    [self.view addSubview:connectButton];
    self.connectButton = connectButton;
    
    //line3
    CGFloat line3Y = CGRectGetMaxY(self.connectButton.frame) + Padding;
    CGFloat line3X = settingButtonX;
    UIView * line3 = [[UIView alloc] initWithFrame:CGRectMake(line3X, line3Y, kScrW - line3X, 1)];
    [self.view addSubview:line3];
    line3.backgroundColor = [UIColor lightGrayColor];
    
    //night image
    CGFloat nightImageY = CGRectGetMaxY(line3.frame) + Padding;
    UIImageView * nightImage = [[UIImageView alloc] initWithFrame:CGRectMake(ViewOffsetX, nightImageY, imagWH, imagWH)];
    [self.view addSubview:nightImage];
    nightImage.image = [UIImage imageNamed:@"btn_user_center_night"];
    
    //night label
    CGFloat nightLabX = CGRectGetMaxX(nightImage.frame) + Padding;
    CGFloat nightLabW = 100;
    UILabel * nightLab = [[UILabel alloc] initWithFrame:CGRectMake(nightLabX, nightImageY, nightLabW, btnH)];
    [self.view addSubview:nightLab];
    nightLab.text = @"夜间模式";
    nightLab.textAlignment = NSTextAlignmentLeft;
    nightLab.textColor = [UIColor whiteColor];
    
    //night switch
//    CGFloat nightSwitchX = CGRectGetMaxX(nightLab.frame) + Padding;
//    CGFloat nightSwitchW = 50;
//    UISwitch * nightSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(nightSwitchX, nightImageY, nightSwitchW, btnH)];
//    [self.view addSubview:nightSwitch];
//    self.nightSwich = nightSwitch;
    
    //line4
    CGFloat line4Y = CGRectGetMaxY(nightLab.frame) + Padding;
    CGFloat line4X = ViewOffsetX;
    UIView * line4 = [[UIView alloc] initWithFrame:CGRectMake(line4X, line4Y, kScrW - line4X, 1)];
    [self.view addSubview:line4];
    line4.backgroundColor = [UIColor lightGrayColor];
    
    //version lab
    CGFloat versionX = 250;
    CGFloat versionY = CGRectGetMaxY(line4.frame) + Padding * 2;
    UILabel * versionLab = [[UILabel alloc] initWithFrame:CGRectMake(versionX, versionY, 70, 20)];
    versionLab.font = [UIFont systemFontOfSize:13];
    versionLab.textColor = [UIColor whiteColor];
    versionLab.text = @"v3.10.0";
    [self.view addSubview:versionLab];
    self.versionLab = versionLab;
}

#pragma mark - action

/**
 *  点击设置按钮触发事件
 */
- (void)settingButtonClick:(__unused id)sender
{
    LJUserSettingTVC * settingTVC = [[LJUserSettingTVC alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:settingTVC animated:YES];
}

/**
 *  点击个人收藏按钮触发事件
 */
- (void)collectionButtonClick:(__unused id)sender
{
    LJArticleCollectionTVC * articleTVC = [[LJArticleCollectionTVC alloc] initWithStyle:UITableViewStylePlain];
    LJBBSCollectionTVC * bbsTVC = [[LJBBSCollectionTVC alloc] initWithStyle:UITableViewStylePlain];
    LJTopicCollectionTVC * topicTVC = [[LJTopicCollectionTVC alloc] initWithStyle:UITableViewStylePlain];
    
    LJCollectionViewController * collectionVC = [LJCollectionViewController collectionViewControllerWithControllers:@[articleTVC, bbsTVC, topicTVC] andTitles:@[@"文章", @"论坛", @"帖子"]];
    articleTVC.delegate = collectionVC;
    bbsTVC.delegate = collectionVC;
    topicTVC.delegate = collectionVC;
    [self.navigationController pushViewController:collectionVC animated:YES];
}


@end
