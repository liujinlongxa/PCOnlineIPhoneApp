//
//  LJBBSTopicDetailWebVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJHotTopic.h"
#import "LJUrlHeader.h"
#import "LJBBSList.h"

@interface LJBBSTopicDetailWebVC : UIViewController

@property (nonatomic, strong) LJHotTopic * topic;
@property (nonatomic, strong) LJBBSList * bbsList;

- (instancetype)initBBSTopicDetailWebVCWithUrlStr:(NSString *)urlStr;

@end
