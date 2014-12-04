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

#define kSubjectAndAreaDataFileName @"pconline_v4_cms_iphone_channel_tree4inch.json"

@interface LJCommonData ()

@property (nonatomic, strong) NSMutableDictionary * channelAndArea;
@property (nonatomic, strong) NSString * filePath;

@end

@implementation LJCommonData

- (NSMutableDictionary *)channelAndArea
{
    if (!_channelAndArea) {
        _channelAndArea = [NSMutableDictionary dictionary];
        
        [self loadLocalData];
//        [self loadRemoteDataAndWrite];//暂时不加载远程的数据
        
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

//获取文件路径
- (NSString *)filePath
{
    if (!_filePath) {
        _filePath = [[NSBundle mainBundle] pathForResource:kSubjectAndAreaDataFileName ofType:nil];
    }
    return _filePath;
}

//加载本地数据
- (void)loadLocalData
{
    NSData * content = [NSData dataWithContentsOfFile:self.filePath];
    _channelAndArea = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableLeaves error:nil];
}

//加载远程数据并写入本地
- (void)loadRemoteDataAndWrite
{
    [LJNetWorking GET:kChannelAndAreaUrl parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        //重新创建文件
        [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
        [[NSFileManager defaultManager] createFileAtPath:self.filePath contents:responseObject attributes:nil];
        
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}

//频道数据
- (NSArray *)SubjectsData
{
    if (!_SubjectsData) {
        
        NSMutableArray * arr = [NSMutableArray array];
        for (NSArray * subArr in self.channelAndArea[@"news"]) {
            LJSubject * subject = [LJSubject subjectWithArray:subArr];
            [arr addObject:subject];
        }
        _SubjectsData = [arr copy];
    }
    return _SubjectsData;
}

//地区数据
- (NSArray *)AreaData
{
    if (!_AreaData) {
        NSMutableArray * arr = [NSMutableArray array];
        for (NSArray * subArr in self.channelAndArea[@"area"]) {
            LJArea * area = [LJArea subjectWithArray:subArr];
            [arr addObject:area];
        }
        _AreaData = [arr copy];
    }
    return _AreaData;
}

- (void)saveObjc:(id)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}

- (id)loadObjcForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
