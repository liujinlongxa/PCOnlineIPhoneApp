//
//  LJBaseTopicFrame.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LJBaseTopic.h"
#import "LJCommonHeader.h"

#define TopicTitleFont [UIFont systemFontOfSize:16]
#define TopicMessageFont [UIFont systemFontOfSize:15]
#define TopicForumFont [UIFont systemFontOfSize:13]
#define TopicFloorCountFont [UIFont systemFontOfSize:13]

@interface LJBaseTopicFrame : NSObject

@property (nonatomic, strong) LJBaseTopic * topic;

@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, assign) CGRect messageFrame;
@property (nonatomic, assign) CGRect forumOrTimeFrame;
@property (nonatomic, assign) CGRect floorCountFrame;
@property (nonatomic, assign) CGRect contentFrame;

@property (nonatomic, assign) CGFloat cellHeigh;

@end
