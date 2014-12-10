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
@class LJTopicSearchResultItem;

@interface LJBBSTopicDetailWebVC : UIViewController

@property (nonatomic, strong) LJBaseTopic * topic;
@property (nonatomic, strong) LJBBSListItem * bbsItem;
@property (nonatomic, strong) LJTopicSearchResultItem * searchResutItem;

- (instancetype)initBBSTopicDetailWebVCWithUrlStr:(NSString *)urlStr;

@end
