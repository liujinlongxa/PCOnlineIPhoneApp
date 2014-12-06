//
//  LJTopicFrame.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJTopic.h"
#import "LJBaseTopicFrame.h"

@interface LJTopicFrame : LJBaseTopicFrame

+ (instancetype)topicFrameWithTopic:(LJBaseTopic *)topic;

@property (nonatomic, assign) CGRect essenceFrame;

@end
