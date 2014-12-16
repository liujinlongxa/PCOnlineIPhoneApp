//
//  LJAreaTableViewController.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/16.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJAreaTableViewController.h"
#import "UIImage+MyImage.h"
#import "LJCommonHeader.h"
#import "LJCommonData.h"
#import "LJAreaManualSelectCell.h"
#import "LJAreaAutoSelectCell.h"

#define kLJAreaManualSelectCellIdentifier @"AreaManualSelectCell"
#define kLJAreaAutoSelectCellIdentifier @"AreaAutoSelectCell"

@interface LJAreaTableViewController ()

@property (nonatomic, strong) NSArray * areaData;
@property (nonatomic, strong) UITableViewCell * curSelect;
@end

@implementation LJAreaTableViewController

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
    [self.tableView registerClass:[LJAreaManualSelectCell class] forCellReuseIdentifier:kLJAreaManualSelectCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_secondary_64"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:NavBarTitleFont}];
    self.navigationItem.title = @"地区选择";
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)areaData
{
    if (!_areaData)
    {
        _areaData = [LJCommonData shareCommonData].AreaData;
    }
    return _areaData;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return self.areaData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        LJAreaAutoSelectCell * cell = [[LJAreaAutoSelectCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text = @"haha";
        return cell;
    }
    else
    {
        LJAreaManualSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:kLJAreaManualSelectCellIdentifier];
        LJArea * area = self.areaData[indexPath.row];
        cell.area = area;
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"定位";
    }
    else
    {
        return @"手动选择";
    }
}

#pragma mark - table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[LJAreaManualSelectCell class]])
    {
        LJAreaManualSelectCell * mCell = (LJAreaManualSelectCell *)cell;
        [mCell setupSelect];
    }
}

@end
