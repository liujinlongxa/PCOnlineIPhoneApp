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
#import "LJAds.h"
#import "LJNewsSearchResultItem.h"
#import "LJProductInformation.h"

@interface LJNewsDetailController : LJWebViewController

/**
 *  咨询模型
 */
@property (nonatomic, strong) LJNews * news;

/**
 *  广告模型
 */
@property (nonatomic, strong) LJAds * ads;

/**
 *  文章ID
 */
@property (nonatomic, copy) NSString * ID;

/**
 *  搜索结果数据模型
 */
@property (nonatomic, strong) LJNewsSearchResultItem * resultItem;

/**
 *  产品咨询数据模型
 */
@property (nonatomic, strong) LJProductInformation * proInfo;
@end
