//
//  LJBaseTopic.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBaseTopic.h"

@implementation LJBaseTopic

- (BOOL)isShowImage
{
    return ((self.image != nil) && ![self.image isEqualToString:@""]);
}

@end
