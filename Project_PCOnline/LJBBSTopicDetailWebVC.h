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
@class LJTopicSearchResultItem;

@interface LJBBSTopicDetailWebVC : LJWebViewController

@property (nonatomic, strong) LJBaseTopic * topic;
@property (nonatomic, strong) LJBBSListItem * bbsItem;
@property (nonatomic, strong) LJTopicSearchResultItem * searchResutItem;
@property (nonatomic, copy) NSNumber * topicId;
- (instancetype)initBBSTopicDetailWebVCWithBaseUrlStr:(NSString *)urlStr andTopicId:(NSNumber *)topicId;

@end
