//
//  LJCommonData.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommonData.h"
#import "LJNetWorking.h"
#import "LJArea.h"
#import "LJSubject.h"

@interface LJCommonData ()

@property (nonatomic, strong) NSMutableDictionary * channelAndArea;

@end

@implementation LJCommonData

- (NSMutableDictionary *)channelAndArea
{
    if (!_channelAndArea) {
        _channelAndArea = [NSMutableDictionary dictionary];
        
        [LJNetWorking GET:kChannelAndAreaUrl parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
            
            _channelAndArea = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
        } failure:^(NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"%@", error);
        }];
        
    }
    return _channelAndArea;
}

+ (instancetype)shareCommonData
{
    static LJCommonData * commonData = nil;
    if (commonData == nil) {
        commonData = [[LJCommonData alloc] init];
    }
    return commonData;
}

- (NSDictionary *)SubjectsData
{
    if (!_SubjectsData) {
        
        _SubjectsData = self.channelAndArea[@"news"];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSArray * subArr in _AreaData) {
            LJSubject * subject = [LJSubject subjectWithArray:subArr];
            [arr addObject:subject];
        }
        _SubjectsData = [arr copy];
    }
    return _SubjectsData;
}

- (NSDictionary *)AreaData
{
    if (!_AreaData) {
        _AreaData = self.channelAndArea[@"area"];
        
    }
    return _AreaData;
}

@end
