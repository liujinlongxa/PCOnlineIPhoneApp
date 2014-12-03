//
//  LJPhotoVIewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPhotoVIewController.h"
#import "LJPhoto.h"
#import "LJPhotoCell.h"
#import "LJPhotoGroup.h"
#import "LJNetWorking.h"

#define kPhotoIdentifier @"kPhotoIdentifier"
#define kPhotoUrlID @"41"

@interface LJPhotoVIewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * photoGroupData;

@end

@implementation LJPhotoVIewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title  = @"图赏";
    
    //初始化tableView
    [self setupTableview];
    
}

#pragma mark - 初始化
- (void)setupTableview
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"LJPhotoCell" bundle:nil] forCellReuseIdentifier:kPhotoIdentifier];
    self.tableView.rowHeight = 180;
    UIEdgeInsets edge = self.tableView.contentInset;
    edge.bottom = kTabBarH + kNavBarH + kStatusBarH;
    self.tableView.contentInset = edge;
    self.tableView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - 加载数据
- (NSMutableArray *)photoGroupData
{
    if (!_photoGroupData) {
        _photoGroupData = [NSMutableArray array];
        [self loadPhotoGroupData];
    }
    return _photoGroupData;
}

- (void)loadPhotoGroupData
{
    NSString * urlStr = [NSString stringWithFormat:kPhotoUrl, kPhotoUrlID];
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        for (NSDictionary * groupDict in dict[@"groups"]) {
            LJPhotoGroup * group = [LJPhotoGroup photoGroupWithDict:groupDict];
            [self.photoGroupData addObject:group];
        }
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        
    }];
}

#pragma mark - tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photoGroupData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJPhotoCell * cell = [tableView dequeueReusableCellWithIdentifier:kPhotoIdentifier];
    LJPhotoGroup * group = self.photoGroupData[indexPath.row];
    cell.photoGroup = group;
    return cell;
}


@end
