//
//  LJBaseTopic.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBaseTopic : NSObject

@property (nonatomic, copy) NSString * createAt;
@property (nonatomic, strong) NSNumber * floor;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * message;
@property (nonatomic, strong) NSNumber * replyCount;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) NSNumber * topicId;

@property (nonatomic, assign, readonly, getter=isShowImage) BOOL showImage;

@end
