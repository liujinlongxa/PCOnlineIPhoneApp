//
//  LJWebViewController.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/12.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJWebViewController.h"
#import "LJCommentBar.h"
#import "LJCommonHeader.h"
#import "LJCommentPage.h"
#import "LJNetWorking.h"
#import "LJPageTableCell.h"
#import "LJWebImages.h"

#define kPageTableH 200
#define kShadowAlpha 0.7
#define kCommentBarPageTabelCellIdentifier @"CommentBarPageTabelCell"
@interface LJWebViewController ()<UIWebViewDelegate, LJCommentBarDelegate, UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, weak) UIWebView * webView;
@property (nonatomic, weak) LJCommentBar * commentBar;
@property (nonatomic, weak) UITableView * pageTable;
@property (nonatomic, weak) UIView * shadowView;

@property (nonatomic, assign, getter=isShowPage) BOOL showPage;
@property (nonatomic, strong) LJCommentPage * pageInfo;
@end

@implementation LJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //web view
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kScrH - kBarH)];
    [self.view addSubview:webView];
    self.webView = webView;
    self.webView.backgroundColor = LightGrayBGColor;
    self.webView.delegate = self;
    
    //shadowView
    UIView * shadowView = [[UIView alloc] initWithFrame:self.webView.frame];
    [self.view addSubview:shadowView];
    self.shadowView = shadowView;
    self.shadowView.backgroundColor = [UIColor blackColor];
    self.shadowView.alpha = 0;
    self.shadowView.hidden = YES;
    [self.shadowView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePageTable)]];
    
    //pageTable
    CGFloat pageTabelY = CGRectGetHeight(self.webView.frame) - kBarH;
    UITableView * pageTable = [[UITableView alloc] initWithFrame:CGRectMake(0,  pageTabelY, kScrW, kPageTableH)];
    [self.view addSubview:pageTable];
    self.pageTable = pageTable;
    self.pageTable.delegate = self;
    self.pageTable.dataSource = self;
    self.pageTable.hidden = YES;
    [self.pageTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone]; //默认选中第一行
    _curPage = 0;
    [self.pageTable registerClass:[LJPageTableCell class] forCellReuseIdentifier:kCommentBarPageTabelCellIdentifier];
    
    //comment bar
    LJCommentBar * bar = [[LJCommentBar alloc] initWithFrame:CGRectMake(0, pageTabelY, kScrW, kBarH)];
    [self.view addSubview:bar];
    self.commentBar = bar;
    self.commentBar.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

#pragma mark - load web
- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;
    [self loadWebPage];
}

- (void)loadWebPage
{
    [LJNetWorking GET:self.urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        NSString * htmlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        [self.webView loadHTMLString:htmlStr baseURL:nil];
        [self setupPageDataWithHtmlStr:htmlStr];
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - load page data
- (void)setupPageDataWithHtmlStr:(NSString *)htmlStr
{
    NSUInteger startPositon = [htmlStr rangeOfString:kLJPageJsonHeader].location + kLJPageJsonHeader.length;
    NSUInteger endPositon = [htmlStr rangeOfString:kLJPageJsonFooter].location;
    assert(startPositon != NSNotFound && endPositon != NSNotFound);
    NSString * pageJsonStr = [htmlStr substringWithRange:NSMakeRange(startPositon, endPositon - startPositon)];
    //解析json
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:[pageJsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    assert(dict != nil);
    self.pageInfo = [LJCommentPage commentPageWithDict:dict];
}

- (void)setPageInfo:(LJCommentPage *)pageInfo
{
    _pageInfo = pageInfo;
    [self.pageTable reloadData];
    self.commentBar.page = self.pageInfo;
    self.commentBar.curPage = self.curPage;
}

#pragma mark - table view datesource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pageInfo.pageCount.integerValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJPageTableCell * cell = [tableView dequeueReusableCellWithIdentifier:kCommentBarPageTabelCellIdentifier];
    
    if (indexPath.row >= self.pageInfo.pages.count)
    {
        //没有页面信息，只显示页号
        cell.textLabel.text = [NSString stringWithFormat:@"第%d页", indexPath.row + 1];
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"第%d页:%@", indexPath.row + 1, self.pageInfo.pages[indexPath.row]];
    }
    return cell;
}

#pragma mark - page table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.curPage == indexPath.row) return;
    self.curPage = indexPath.row;
    [self hidePageTable];
    self.commentBar.curPage = self.curPage;
}

#pragma mark - comment bar delegate
- (void)commentBar:(LJCommentBar *)bar didSelectPageButton:(UIButton *)pageBtn
{
    //如果只有1页，则不用显示page table
    if(self.pageInfo.pageCount.integerValue <= 1) return;
    
    if (self.isShowPage)
    {
        [self hidePageTable];
    }
    else
    {
        [self showPageTable];
    }
}

- (void)showPageTable
{
    CGRect tableFrame = self.pageTable.frame;
    tableFrame.origin.y = CGRectGetHeight(self.webView.frame) - kBarH - kPageTableH;
    self.pageTable.hidden = NO;
    [self.pageTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.curPage inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    self.shadowView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.shadowView.alpha = kShadowAlpha;
        self.pageTable.frame = tableFrame;
    } completion:^(BOOL finished) {
        self.showPage = YES;
    }];
}

- (void)hidePageTable
{
    CGRect tableFrame = self.pageTable.frame;
    tableFrame.origin.y = CGRectGetHeight(self.webView.frame) - kBarH;
    [UIView animateWithDuration:0.5 animations:^{
        self.shadowView.alpha = 0;
        self.pageTable.frame = tableFrame;
    } completion:^(BOOL finished) {
        self.shadowView.hidden = YES;
        self.pageTable.hidden = YES;
        self.showPage = NO;
    }];
}

@end
