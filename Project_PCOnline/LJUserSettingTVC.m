//
//  LJUserSettingTVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJUserSettingTVC.h"
#import "LJCommonData.h"
#import "LJNetWorkingTool.h"
#import "MBProgressHUD+LJProgressHUD.h"
#import "PPRevealSideviewController/PPRevealSideViewController.h"

#import "LJSettingActionCell.h"
#import "LJSettingSwitchCell.h"
#import "LJSettingSubtitleCell.h"
#import "LJSettingTwoImageCell.h"
#import "LJSettingChildSelectCell.h"

//setting
#import "LJBaseSettingItem.h"
#import "LJSettingSwitchItem.h"
#import "LJSettingActionItem.h"
#import "LJSettingSubtitleItem.h"
#import "LJSettingTwoImageItem.h"
#import "LJSettingChildSelectItem.h"

@interface LJUserSettingTVC ()<UIAlertViewDelegate>

/**
 *  设置tableview的数据
 */
@property (nonatomic, strong) NSArray * settingData;

/**
 *  清除缓存Item
 */
@property (nonatomic, strong) LJSettingSubtitleItem * cleanCacheItem;
@property (nonatomic, strong) LJSettingSubtitleCell * cleanCacheCell;
@end

@implementation LJUserSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LJSettingActionCell" bundle:nil] forCellReuseIdentifier:kSettingActionCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJSettingSwitchCell" bundle:nil] forCellReuseIdentifier:kSettingSwitchCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJSettingSubtitleCell" bundle:nil] forCellReuseIdentifier:kSettingSubtitleCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJSettingTwoImageCell" bundle:nil] forCellReuseIdentifier:kSettingTwoImageCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LJSettingChildSelectCell" bundle:nil] forCellReuseIdentifier:kSettingChildSelectCellIdentifier];
    
    self.tableView.rowHeight = 44;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //setting nav bar
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_common_white_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonClick:)];
    self.navigationItem.title = @"设置";
    
    [self.revealSideViewController changeOffset:0 forDirection:PPRevealSideDirectionRight];
    self.revealSideViewController.options &= !PPRevealSideOptionsShowShadows;
}

- (void)backButtonClick:(__unused id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置数据
- (NSArray *)settingData
{
    if (!_settingData) {
        [self setupSettingData];
    }
    return _settingData;
}

- (void)setupSettingData
{
    NSMutableArray * settingData = [NSMutableArray array];
    
    //section 1
    NSMutableArray * settingDataSection1 = [NSMutableArray array];
    LJSettingTwoImageItem * item11 = [[LJSettingTwoImageItem alloc] initWithTitle:@"绑定分享平台" andType:LJSettingItemTypeTwoImage andAction:nil];
    item11.image1 = [UIImage imageNamed:@"btn_setting_sina_weibo_nologin"];
    item11.image2 = [UIImage imageNamed:@"btn_setting_qq_nologin"];
    [settingDataSection1 addObject:item11];
    [settingData addObject:settingDataSection1];
    
    //section 2
    NSMutableArray * settingDataSection2 = [NSMutableArray array];
    //item 21
    LJSettingChildSelectItem * item21 = [[LJSettingChildSelectItem alloc] initWithTitle:@"文章字号大小" andType:LJSettingItemTypeChildSelect andAction:nil];
    item21.childItems = @[@"小字体", @"中字体", @"大字体"];
    item21.selectIndex = 0;
    [settingDataSection2 addObject:item21];
    //item 22
    LJSettingChildSelectItem * item22 = [[LJSettingChildSelectItem alloc] initWithTitle:@"非wifi下显示" andType:LJSettingItemTypeChildSelect andAction:nil];
    item22.childItems = @[@"无图", @"小图", @"大图"];
    item22.selectIndex = 0;
    item22.message = @"流量控制：选择小图或无图能够帮您更加省流量";
    [settingDataSection2 addObject:item22];
    //item 23
    LJSettingChildSelectItem * item23 = [[LJSettingChildSelectItem alloc] initWithTitle:@"离线阅读管理" andType:LJSettingItemTypeChildSelect andAction:nil];
    item23.childItems = @[@"手动下载", @"wifi网络下自动下载"];
    item23.message = @"离线阅读：下载内容到手机，没有网络照样看";
    item23.selectIndex = 0;
    [settingDataSection2 addObject:item23];
    [settingData addObject:settingDataSection2];
    
    //section 3
    NSMutableArray * settingDataSection3 = [NSMutableArray array];
    LJSettingSwitchItem * item31 = [[LJSettingSwitchItem alloc] initWithTitle:@"推送开关" andType:LJSettingItemTypeSwitch andAction:nil];
    [settingDataSection3 addObject:item31];
    [settingData addObject:settingDataSection3];
    
    //section 4
    NSMutableArray * settingDataSection4 = [NSMutableArray array];
    //item 41
    LJSettingSubtitleItem * item41 = [[LJSettingSubtitleItem alloc] initWithTitle:@"清理缓存" andType:LJSettingItemTypeSubtitle andAction:^(LJBaseSettingItem *item) {
        UIAlertView * cleanCacheAlert = [[UIAlertView alloc] initWithTitle:nil message:@"确认清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [cleanCacheAlert show];
    }];
    float curCache = [LJNetWorkingTool shareNetworkTool].currnetCacheSize;
    item41.subtitle = [NSString stringWithFormat:@"%.1fM", curCache];
    self.cleanCacheItem = item41;
    [settingDataSection4 addObject:item41];
    
    //item42
    LJSettingActionItem * item42 = [[LJSettingActionItem alloc] initWithTitle:@"关于我们" andType:LJSettingItemTypeWithAction andAction:nil];
    [settingDataSection4 addObject:item42];
    
    //item43
    LJSettingActionItem * item43 = [[LJSettingActionItem alloc] initWithTitle:@"给个评价" andType:LJSettingItemTypeWithAction andAction:nil];
    [settingDataSection4 addObject:item43];
    
    //item44
    LJSettingActionItem * item44 = [[LJSettingActionItem alloc] initWithTitle:@"用户体验计划" andType:LJSettingItemTypeWithAction andAction:nil];
    [settingDataSection4 addObject:item44];
    
    //item45
    LJSettingActionItem * item45 = [[LJSettingActionItem alloc] initWithTitle:@"精品应用推荐" andType:LJSettingItemTypeWithAction andAction:nil];
    [settingDataSection4 addObject:item45];
    
    [settingData addObject:settingDataSection4];
    
    _settingData = [settingData copy];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.settingData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settingData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJBaseSettingItem * item = self.settingData[indexPath.section][indexPath.row];
    UITableViewCell * cell = nil;
    
    switch (item.type)
    {
        case LJSettingItemTypeSwitch:
            cell = [tableView dequeueReusableCellWithIdentifier:kSettingSwitchCellIdentifier];
            break;
        case LJSettingItemTypeTwoImage:
            cell = [tableView dequeueReusableCellWithIdentifier:kSettingTwoImageCellIdentifier];
            break;
        case LJSettingItemTypeWithAction:
            cell = [tableView dequeueReusableCellWithIdentifier:kSettingActionCellIdentifier];
            break;
        case LJSettingItemTypeChildSelect:
            cell = [tableView dequeueReusableCellWithIdentifier:kSettingChildSelectCellIdentifier];
            break;
        case LJSettingItemTypeSubtitle:
            cell = [tableView dequeueReusableCellWithIdentifier:kSettingSubtitleCellIdentifier];
            break;
        default:
            NSLog(@"unkonw cell type");
            break;
    }
    [cell setValue:item forKey:@"item"];
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJBaseSettingItem * item = self.settingData[indexPath.section][indexPath.row];
    switch (item.type)
    {
        case LJSettingItemTypeSwitch:
            break;
        case LJSettingItemTypeTwoImage:
            break;
        case LJSettingItemTypeWithAction:
            break;
        case LJSettingItemTypeChildSelect:
            break;
        case LJSettingItemTypeSubtitle:
            item.action(item);
            break;
        default:
            NSLog(@"unkonw cell type");
            break;
    }
}

#pragma mark - 清楚缓存代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) return;
    
    [[LJNetWorkingTool shareNetworkTool] cleanCache];
    self.cleanCacheItem.subtitle = @"0.0M";
    
    [MBProgressHUD showNotificationMessage:@"清除缓存成功" InView:self.view];
}

@end
