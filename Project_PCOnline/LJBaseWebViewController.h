//
//  LJBaseWebViewController.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/13.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBaseWebViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView * webView;

//供子类重写
- (void)handleHTTPFullScreenWebLinkWithUrlString:(NSString *)urlStr;
- (void)handleTopicListLinkWithUrlString:(NSString *)urlStr;
- (void)handleProductPhotoWihtUrlString:(NSString *)urlStr;
@end
