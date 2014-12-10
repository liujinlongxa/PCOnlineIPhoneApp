//
//  LJProductDetailWebVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductDetailWebVC.h"
#import "LJCommonHeader.h"
#import "LJUrlHeader.h"

@interface LJProductDetailWebVC ()

@property (nonatomic, weak) UIWebView * webView;
@property (nonatomic, assign) LJProductWebVCType type;
@end

@implementation LJProductDetailWebVC

- (instancetype)initWithType:(LJProductWebVCType)type
{
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupWebView];
}

#pragma mark - 初始化UI
- (void)setupWebView
{
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScrW, kScrH - kNavBarH * 2 - kStatusBarH)];
    [self.view addSubview:webView];
    self.webView = webView;
}

#pragma mark - 加载网页
- (void)setProduct:(LJProduct *)product
{
    _product = product;
    NSString * urlStr = [self getUrlStrWithProduct:product.ID.integerValue];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
}

- (void)setProductID:(NSString *)productID
{
    _productID = productID;
    NSString * urlStr = [self getUrlStrWithProduct:productID.integerValue];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
}

- (NSString *)getUrlStrWithProduct:(NSInteger)productID
{
    NSString * urlStr = nil;
    switch (self.type) {
        case LJProductWebVCTypeSummary:
            urlStr = [NSString stringWithFormat:kProductDetailSummaryUrl, productID];
            break;
        case LJProductWebVCTypeDetail:
            urlStr = [NSString stringWithFormat:kProductDetailDetailUrl, productID];
            break;
        case LJProductWebVCTypePrice:
            urlStr = [NSString stringWithFormat:kProductDetailPriceUrl, productID];
            break;
        case LJProductWebVCTypeComment:
            urlStr = [NSString stringWithFormat:kProductDetailCommentUrl, productID];
            break;
            
        default:
            break;
    }
    return urlStr;
}

@end
