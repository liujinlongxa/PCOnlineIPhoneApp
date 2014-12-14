//
//  LJNewsDetailController.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJUrlHeader.h"
#import "LJCommonHeader.h"
#import "LJWebViewController.h"
#import "LJNews.h"

@interface LJNewsDetailController : LJWebViewController

@property (nonatomic, copy) NSString * ID;
@property (nonatomic, strong) LJNews * news;

@end
