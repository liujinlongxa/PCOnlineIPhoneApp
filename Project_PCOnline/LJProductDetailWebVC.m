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
    NSString * urlStr = [self getUrlStrWithProduct:product];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];
}

- (NSString *)getUrlStrWithProduct:(LJProduct *)product
{
    NSString * urlStr = nil;
    switch (self.type) {
        case LJProductWebVCTypeSummary:
            urlStr = [NSString stringWithFormat:kProductDetailSummaryUrl, product.ID.integerValue];
            break;
        case LJProductWebVCTypeDetail:
            urlStr = [NSString stringWithFormat:kProductDetailDetailUrl, product.ID.integerValue];
            break;
        case LJProductWebVCTypePrice:
            urlStr = [NSString stringWithFormat:kProductDetailPriceUrl, product.ID.integerValue];
            break;
        case LJProductWebVCTypeComment:
            urlStr = [NSString stringWithFormat:kProductDetailCommentUrl, product.ID.integerValue];
            break;
            
        default:
            break;
    }
    return urlStr;
}

@end
