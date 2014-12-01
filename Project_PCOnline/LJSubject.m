//
//  LJSubject.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSubject.h"

@implementation LJSubject

+ (instancetype)subjectWithArray:(NSArray *)arr
{
    LJSubject * subject = [[LJSubject alloc] init];
    subject.index = arr[0];
    subject.title = arr[1];
    subject.ID = arr[2];
    return subject;
}

@end
