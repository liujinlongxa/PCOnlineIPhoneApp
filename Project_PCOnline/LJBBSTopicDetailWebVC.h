//
//  LJBBSTopicDetailWebVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBaseTopic.h"
#import "LJUrlHeader.h"
#import "LJBBSListItem.h"
#import "LJWebViewController.h"
#import "LJBBSAds.h"

@class LJTopicSearchResultItem;

@interface LJBBSTopicDetailWebVC : LJWebViewController

/**
 *  点击普通帖子跳转传递的模型数据
 */
@property (nonatomic, strong) LJBaseTopic * topic;

/**
 *  帖子所在的论坛板块模型数据
 */
@property (nonatomic, strong) LJBBSListItem * bbsItem;

/**
 *  点击搜索结果跳转传递的模型数据
 */
@property (nonatomic, strong) LJTopicSearchResultItem * searchResutItem;

/**
 *  点击滚动广告跳转传递的模型数据
 */
@property (nonatomic, strong) LJBBSAds * bbsAds;

/**
 *  帖子Id
 */
@property (nonatomic, copy) NSNumber * topicId;

/**
 *  构造方法，用于点击广告和热帖的跳转
 *
 *  @param urlStr  跳转的Url
 *  @param topicId 帖子ID
 *
 *  @return 返回创建好的WebViewController
 */
- (instancetype)initBBSTopicDetailWebVCWithBaseUrlStr:(NSString *)urlStr andTopicId:(NSNumber *)topicId;

@end
