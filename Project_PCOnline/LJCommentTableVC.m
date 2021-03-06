//
//  LJCommentTableVC.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/14.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommentTableVC.h"
#import "LJCommonHeader.h"
#import "LJUrlHeader.h"
#import "LJNetWorkingTool.h"
#import "LJComment.h"
#import "LJCommentTableViewCell.h"
#import "LJCommentSupportInfo.h"
#import "LJCommentTableHeaderView.h"
#import "UIImage+MyImage.h"
#import "MBProgressHUD+LJProgressHUD.h"

#define kCommentTableViewCellIdentifier @"CommentTableViewCell"

typedef enum : NSUInteger {
    LJCommentSupportResultSuccess,
    LJCommentSupportResultFailed,
} LJCommentSupportResult;

@interface LJCommentTableVC ()<UITableViewDelegate, UITableViewDataSource, LJCommentTableHeaderViewDelegate>

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * commentData;
@property (nonatomic, strong) LJCommentSupportInfo * supportInfo;
@property (nonatomic, weak) LJCommentTableHeaderView * header;

@end

@implementation LJCommentTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kScrH - kNavBarH - kStatusBarH) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView registerClass:[LJCommentTableViewCell class] forCellReuseIdentifier:kCommentTableViewCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithNameNoRender:@"btn_common_black_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:NavBarTitleFont}];
    self.navigationItem.title = @"评论";
    
}

- (void)backBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - load support info
- (void)loadSupportInfo
{
    NSString * urlStr = [NSString stringWithFormat:kCommentSupportInfoUrl, self.ID.integerValue];
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        LJCommentSupportInfo * info = [LJCommentSupportInfo commentSupportWithDict:dict];
        self.supportInfo = info;
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NetworkErrorNotify(self);
    }];
}

- (void)setSupportInfo:(LJCommentSupportInfo *)supportInfo
{
    _supportInfo = supportInfo;
    LJCommentTableHeaderView * header = [[LJCommentTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScrW, 180)];
    header.supprotInfo = supportInfo;
    header.pageInfo = self.pageInfo;
    header.delegate = self;
    self.tableView.tableHeaderView = header;
    self.header = header;
}

- (void)setPageInfo:(LJCommentPageInfo *)pageInfo
{
    _pageInfo = pageInfo;
    if (self.isShowHeader)
    {
        [self loadSupportInfo];
    }
    
}

#pragma mark - load data
- (NSMutableArray *)commentData
{
    if (!_commentData) {
        _commentData = [NSMutableArray array];
        [self loadCommentData];
    }
    return _commentData;
}

- (void)loadCommentData
{
    NSString * urlStr = [NSString stringWithFormat:kCommentDetailUrl, self.commentInfo.ID.integerValue, self.ID.integerValue];
    [LJNetWorkingTool GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        assert(dict != nil);
        NSMutableArray * commentsArr = [NSMutableArray array];
        NSMutableArray * hotCommentsArr = [NSMutableArray array];
        
        for (NSDictionary * commentDict in dict[@"comments"]) {
            LJComment * comment = [LJComment commentWithDict:commentDict];
            LJCommentFrame * commentFrame = [[LJCommentFrame alloc] init];
            commentFrame.comment = comment;
            [commentsArr addObject:commentFrame];
        }
        
        for (NSDictionary * commentDict in dict[@"hot-comments"]) {
            LJComment * comment = [LJComment commentWithDict:commentDict];
            LJCommentFrame * commentFrame = [[LJCommentFrame alloc] init];
            commentFrame.comment = comment;
            [hotCommentsArr addObject:commentFrame];
        }
        [_commentData addObjectsFromArray:@[hotCommentsArr, commentsArr]];
        [self.tableView reloadData];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NetworkErrorNotify(self);
    }];
}

#pragma mark - table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.commentData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.commentData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCommentTableViewCellIdentifier];
    LJCommentFrame * commentFrame = self.commentData[indexPath.section][indexPath.row];
    cell.commentFrame = commentFrame;
    return cell;
}

#pragma mark - table view delegate;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJCommentFrame * commentFrame = self.commentData[indexPath.section][indexPath.row];
    return commentFrame.cellHeigh;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 82, 20)];
    UITableViewHeaderFooterView * header = [[UITableViewHeaderFooterView alloc] init];
    header.contentView.backgroundColor = [UIColor clearColor];
    header.backgroundView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScrW, 20)];
        view.backgroundColor = [UIColor clearColor];
        view;
    });
    [header.contentView addSubview:imageView];
    if (section == 0)
    {
        imageView.image = [UIImage imageNamed:@"bg_comment_hot"];
    }
    else
    {
        imageView.image = [UIImage imageNamed:@"bg_comment_all"];
    }
    return header;
}

#pragma mark - header view delegate
- (void)commentTableHeaderView:(LJCommentTableHeaderView *)header didChangeSupport:(LJCommentSupportType)type
{
    NSString * urlString = [NSString stringWithFormat:kCommentChangeSupportUrl, (long)self.ID.integerValue, (long)type];

    [LJNetWorkingTool GET:urlString parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
#warning 注意这里必须使用GBK转码，并且去除字符串前的12个\n
        NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString * newStr = [[NSString alloc] initWithData:responseObject encoding:encode];
        
        NSString * jsonStr = [newStr substringFromIndex:12];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        assert(dict != nil);
        if ([dict[@"code"] integerValue] == LJCommentSupportResultSuccess)
        {
            if (type == LJCommentSupportTypeAgree)
            {
                self.supportInfo.agreeCount = @(self.supportInfo.agreeCount.integerValue + 1);
                [self.header addAgree];
            }
            else
            {
                self.supportInfo.againstCount = @(self.supportInfo.againstCount.integerValue + 1);
                [self.header addDisagree];
            }
        }
        else
        {
            [MBProgressHUD showNotificationMessage:@"您已经顶踩过了" InView:self.tableView];
        }
        
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NetworkErrorNotify(self);
    }];
}



@end
