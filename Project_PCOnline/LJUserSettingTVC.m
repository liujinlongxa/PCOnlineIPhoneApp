//
//  LJUserSettingTVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJUserSettingTVC.h"
#import "LJCommonData.h"
#import "PPRevealSideviewController/PPRevealSideViewController.h"

#import "LJSettingActionCell.h"
#import "LJSettingSwitchCell.h"
#import "LJSettingSubtitleCell.h"
#import "LJSettingTwoImageCell.h"
#import "LJSettingChildSelectCell.h"

@interface LJUserSettingTVC ()

@property (nonatomic, weak) NSArray * settingData;

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

- (NSArray *)settingData
{
    if (!_settingData) {
        _settingData = [LJCommonData shareCommonData].settingData;
    }
    return _settingData;
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

@end
