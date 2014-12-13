//
//  LJWebViewController.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/12.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBaseWebViewController.h"

@interface LJWebViewController : LJBaseWebViewController

@property (nonatomic, copy) NSString * urlStr;
@property (nonatomic, assign) NSInteger curPage;


@end
