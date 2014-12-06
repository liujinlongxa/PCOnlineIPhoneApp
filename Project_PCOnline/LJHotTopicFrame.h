//
//  LJHotTopicFrame.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LJHotTopic.h"
#import "LJCommonHeader.h"
#import "LJBaseTopicFrame.h"



@interface LJHotTopicFrame : LJBaseTopicFrame

+ (instancetype)topicFrameWithTopic:(LJHotTopic *)topic;

@end
