//
//  LJBaseWebViewController.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/13.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBaseWebViewController.h"
#import "MBProgressHUD+LJProgressHUD.h"
#import "LJCommonData.h"

#import "LJNewsDetailController.h"
#import "LJProductDetailScrollTabVC.h"
#import "LJWebImageViewerController.h"
#import "LJFullScreenWebViewerVC.h"
#import "LJBBSSubForumTVC.h"

@interface LJBaseWebViewController ()

@end

@implementation LJBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - 指示器
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showLoadingHUDInView:self.webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideLoadingHUDInView:self.webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NetworkErrorNotify(self);
}

#pragma mark - 网页内容点击跳转
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * urlStr = request.URL.absoluteString;
    if ([urlStr hasPrefix:LJWebViewClickToNewsFullScreen])
    {
        [self handleFullScreenWebLinkWithUrlString:urlStr];
    }
    else if([urlStr hasPrefix:LJWebViewClickToHTTPFullScreen])
    {
        if (navigationType != UIWebViewNavigationTypeLinkClicked) return YES; //处理普通的页面跳转
        [self handleHTTPFullScreenWebLinkWithUrlString:urlStr];
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
    else if([urlStr hasPrefix:LJWebViewClickToTopicList])
    {
        [self handleTopicListLinkWithUrlString:urlStr];
    }
    else if([urlStr hasPrefix:LJWebViewClickToForum])
    {
        [self handleTopicListLinkWithUrlString:urlStr];
    }
    else if([urlStr hasPrefix:LJWebViewClickToPhoto])
    {
        [self handleProductPhotoWithUrlString:urlStr];
    }
    else if([urlStr hasPrefix:LJWebViewClickToProductDetailTab])
    {
        [self handleProductTabWithUrlString:urlStr andTab:LJProductTabDetail];
    }
    else if([urlStr hasPrefix:LJWebViewClickToProductArticleTab])
    {
        [self handleProductTabWithUrlString:urlStr andTab:LJProductTabArticle];
    }
    else if([urlStr hasPrefix:LJWebViewClickToProductCommentTab])
    {
        [self handleProductTabWithUrlString:urlStr andTab:LJProductTabComment];
    }
    else if([urlStr hasPrefix:LJWebViewClickToProductPriceTab])
    {
        [self handleProductTabWithUrlString:urlStr andTab:LJProductTabPrice];
    }
    else
    {
        return YES;
    }
    return NO;
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

//论坛链接，跳往LJBBSSubForumTVC
- (void)handleTopicListLinkWithUrlString:(NSString *)urlStr
{
    NSRange urlStrRange = [urlStr rangeOfString:LJWebViewClickToTopicList];
    assert(urlStrRange.location != NSNotFound);
    NSString * ID = [urlStr substringFromIndex:urlStrRange.location + urlStrRange.length];
    
    LJBBSSubForumTVC * forumTVC = [[LJBBSSubForumTVC alloc] init];
    LJBBSListItem * item = [[LJCommonData shareCommonData] findBBSItemByID:@(ID.integerValue) inBBSLists:nil];
    forumTVC.bbsItem = item == nil ? [LJBBSListItem bbsListItemWithID:@(ID.integerValue)] : item;
    [self.navigationController pushViewController:forumTVC animated:YES];
}

//产品图片链接，跳往图赏模块
- (void)handleProductPhotoWithUrlString:(NSString *)urlStr
{
    //子类实现
}

//产品详情Tab跳转
- (void)handleProductTabWithUrlString:(NSString *)urlStr andTab:(LJProductTab)tab
{
    //子类实现
}

@end
