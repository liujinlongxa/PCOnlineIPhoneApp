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
#import "MBProgressHUD+LJProgressHUD.h"
#import <CoreLocation/CoreLocation.h>

#define kLJAreaManualSelectCellIdentifier @"AreaManualSelectCell"
#define kLJAreaAutoSelectCellIdentifier @"AreaAutoSelectCell"

@interface LJAreaTableViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) NSArray * areaData;
@property (nonatomic, strong) LJAreaManualSelectCell * curSelectCell;
@property (nonatomic, strong) LJAreaAutoSelectCell * autoLocationCell;
@property (nonatomic, strong) CLLocationManager * locationManager;

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
    [self.tableView registerClass:[LJAreaAutoSelectCell class] forCellReuseIdentifier:kLJAreaAutoSelectCellIdentifier];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_secondary_64"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:NavBarTitleFont}];
    self.navigationItem.title = @"地区选择";
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupArea];
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
        LJAreaAutoSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:kLJAreaAutoSelectCellIdentifier];
        self.autoLocationCell = cell;
        if (!cell.area) {
            [cell startLocation];
        }
        return cell;
    }
    else
    {
        LJAreaManualSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:kLJAreaManualSelectCellIdentifier];
        [cell setupDeselect]; //消除选中的状态，否则重用会出问题
        LJArea * area = self.areaData[indexPath.row];
        cell.area = area;
        if ([area.index isEqualToString:[LJCommonData shareCommonData].curArea.index])
        {
            [cell setupSelect];
            self.curSelectCell = cell;
        }
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    LJArea * area = nil;
    
    if ([cell isKindOfClass:[LJAreaManualSelectCell class]])
    {
        [self.curSelectCell setupDeselect];
        LJAreaManualSelectCell * mCell = (LJAreaManualSelectCell *)cell;
        [mCell setupSelect];
        self.curSelectCell = mCell;
        //存储数据
        area = self.areaData[indexPath.row];
        [LJCommonData shareCommonData].curArea = area;
    }
    else
    {
        area = self.autoLocationCell.area;
        if(!area) return;
        [LJCommonData shareCommonData].curArea = area;
    }
    
    if ([self.delegate respondsToSelector:@selector(areaTableViewController:didSelectArea:)])
    {
        [self.delegate areaTableViewController:self didSelectArea:area];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScrW, 60)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.textColor = [UIColor darkGrayColor];
    if (section == 0) {
        label.text = @"  定位";
    }
    else
    {
        label.text = @"  手动选择";
    }
    return label;
}

#pragma mark - location 

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (LJArea *)setupArea
{
    //授权注册
    CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
    if (locationStatus == kCLAuthorizationStatusDenied ||
        locationStatus == kCLAuthorizationStatusRestricted) {
        [MBProgressHUD showNotificationMessage:@"无法定位" InView:self.tableView];
        [self.autoLocationCell failedLocation];
        return nil;
    }
    else if(locationStatus == kCLAuthorizationStatusNotDetermined)
    {
        if (IOS8) {
            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager requestWhenInUseAuthorization];
        }
    }
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"无法定位");
    }
    
    //设置精度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    self.locationManager.distanceFilter = 5.0;
    [self.locationManager startUpdatingLocation];
    
    return nil;
}

- (NSString *)setupAreaName
{
    return nil;
}

#pragma mark - CLLocationManager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * location = [locations firstObject];
    CLGeocoder * coder = [[CLGeocoder alloc] init];
    
    NSLog(@"%@", location);
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            CLPlacemark * place = [placemarks firstObject];
            NSString * cityName = place.locality;
            for (LJArea * area in [LJCommonData shareCommonData].AreaData) {
                if ([cityName containsString:area.title]) {
                    self.autoLocationCell.area = area;
                    [self.locationManager stopUpdatingLocation];
                    break;
                }
            }
        }
    }];
}









@end
