//
//  LJBaseWebViewController.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/13.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBaseWebViewController.h"
#import "MBProgressHUD.h"
#import "LJCommonHeader.h"

#import "LJNewsDetailController.h"
#import "LJProductDetailScrollTabVC.h"
#import "LJWebImageViewerController.h"
#import "LJFullScreenWebViewerVC.h"

@interface LJBaseWebViewController ()

@end

@implementation LJBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 指示器
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.webView animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@", error);
    [MBProgressHUD hideAllHUDsForView:self.webView animated:YES];
}

#pragma mark - 网页内容点击跳转
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType != UIWebViewNavigationTypeLinkClicked) return YES;
    
    NSString * urlStr = request.URL.absoluteString;
    if ([urlStr hasPrefix:LJWebViewClickToNewsFullScreen])
    {
        [self handleFullScreenWebLinkWithUrlString:urlStr];
    }
    else if([urlStr hasPrefix:LJWebViewClickToHTTPFullScreen])
    {
        [self handleHTTPFullScreenWebLinkWithUrlString:urlStr];
        return NO;
    }
    else if([urlStr hasPrefix:LJWebViewClickToNewsDetail])
    {
        [self handleNewsLinkWithUrlString:urlStr];
    }
    else if([urlStr hasPrefix:LJWebViewClickToProductDetail])
    {
        [self handleProductLinkWithUrlString:urlStr];
    }
    else if([urlStr hasPrefix:LJWebViewClickToBigPhoto])
    {
        [self handleBigPhotoLinkWithUrlString:urlStr];
    }
    return YES;
}

//网页链接（新闻咨询），跳往LJFullScreenWebViewerVC
- (void)handleFullScreenWebLinkWithUrlString:(NSString *)urlStr
{
    NSString * url = nil;
    
    NSRange urlStrRange = [urlStr rangeOfString:LJWebViewClickToNewsFullScreen];
    assert(urlStrRange.location != NSNotFound);
    url = [urlStr substringFromIndex:urlStrRange.location + urlStrRange.length];
    
    
    LJFullScreenWebViewerVC * webVC = [[LJFullScreenWebViewerVC alloc] init];
    webVC.urlStr = url;
    
    [self presentViewController:webVC animated:YES completion:nil];
}

//网页链接（http），跳往LJFullScreenWebViewerVC
- (void)handleHTTPFullScreenWebLinkWithUrlString:(NSString *)urlStr
{
    LJFullScreenWebViewerVC * webVC = [[LJFullScreenWebViewerVC alloc] init];
    webVC.urlStr = urlStr;
    
    [self presentViewController:webVC animated:YES completion:nil];
}

//新闻咨询链接，跳往LJNewsDetailController
- (void)handleNewsLinkWithUrlString:(NSString *)urlStr
{
    NSRange urlStrRange = [urlStr rangeOfString:LJWebViewClickToNewsDetail];
    assert(urlStrRange.location != NSNotFound);
    NSString * ID = [urlStr substringFromIndex:urlStrRange.location + urlStrRange.length];
    
    LJNewsDetailController * newDetailController = [[LJNewsDetailController alloc] init];
    newDetailController.ID = ID;
    [self.navigationController pushViewController:newDetailController animated:YES];
}

//产品详情链接，跳往LJProductDetailScrollTabVC
- (void)handleProductLinkWithUrlString:(NSString *)urlStr
{
    NSRange urlStrRange = [urlStr rangeOfString:LJWebViewClickToProductDetail];
    assert(urlStrRange.location != NSNotFound);
    NSString * ID = [urlStr substringFromIndex:urlStrRange.location + urlStrRange.length];
    
    LJProductDetailScrollTabVC * detailScrollTVC = [LJProductDetailScrollTabVC productDetailScrollTabVCWithDefautControllers];
    LJProduct * product = [LJProduct productWithID:@(ID.integerValue)];
    detailScrollTVC.product = product;
    [self.navigationController pushViewController:detailScrollTVC animated:YES];
}

//图片链接，跳往LJWebImageViewerController
- (void)handleBigPhotoLinkWithUrlString:(NSString *)urlStr
{
    NSRange urlStrRange = [urlStr rangeOfString:LJWebViewClickToBigPhoto];
    assert(urlStrRange.location != NSNotFound);
    NSString * webImageStr = [[urlStr substringFromIndex:urlStrRange.location + urlStrRange.length] stringByRemovingPercentEncoding];
    NSData * jsonData = [webImageStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * webImageDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    LJWebImages * webImages = [LJWebImages webImages:webImageDict];
    
    LJWebImageViewerController * viewer = [[LJWebImageViewerController alloc] init];
    viewer.webImages = webImages;
    [self.navigationController pushViewController:viewer animated:YES];
}

@end
