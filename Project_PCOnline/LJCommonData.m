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
#import "LJDataManager.h"
#import "LJBBSListItem.h"
#import "LJBBSList.h"

#define kSubjectAndAreaDataFileName @"pconline_v4_cms_iphone_channel_tree4inch.json"
#define kBBSListDataFileName @"pconline_v4_bbs_forum_tree4inch.json"

#define KCurShowSubjectKey @"CurShowSubject"
#define kCurHideSubjectKey @"CurHideSubject"

@interface LJCommonData ()

@property (nonatomic, strong) NSMutableDictionary * channelAndArea;
@property (nonatomic, strong) NSString * filePath;

@end

@implementation LJCommonData

@synthesize curShowSubjectsData = _curShowSubjectsData;
@synthesize curHideSubjectsData = _curHideSubjectsData;

+ (instancetype)shareCommonData
{
    static LJCommonData * commonData = nil;
    if (commonData == nil) {
        commonData = [[LJCommonData alloc] init];
    }
    return commonData;
}

#pragma mark - 频道及地区编码数据
- (NSMutableDictionary *)channelAndArea
{
    if (!_channelAndArea) {
        _channelAndArea = [NSMutableDictionary dictionary];
        
        [self loadLocalData];
//        [self loadRemoteDataAndWrite];//暂时不加载远程的数据
        
    }
    return _channelAndArea;
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

#pragma mark - 显示及隐藏的频道数据
//所有频道
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
//显示的频道
- (NSArray *)curShowSubjectsData
{
    if (!_curShowSubjectsData) {
        NSArray * subjectDicts = [[LJDataManager manager] loadObjectsForKey:KCurShowSubjectKey];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * dict in subjectDicts) {
            LJSubject * subject = [LJSubject subjectWithDict:dict];
            [arr addObject:subject];
        }
        _curShowSubjectsData = [arr copy];
    }
    if (_curShowSubjectsData.count < 1) {
        _curShowSubjectsData = self.SubjectsData;
    }
    assert(_curShowSubjectsData.count >= 1);
    return _curShowSubjectsData;
}

- (void)setCurShowSubjectsData:(NSArray *)curShowSubjectsData
{
    _curShowSubjectsData = curShowSubjectsData;
    [[LJDataManager manager] saveDictionaryWithObjects:curShowSubjectsData andPropertyNames:@[@"index", @"title", @"ID"] forKey:KCurShowSubjectKey];
}

//隐藏的频道
- (NSArray *)curHideSubjectsData
{
    if (!_curHideSubjectsData) {
        NSArray * subjectDicts = [[LJDataManager manager] loadObjectsForKey:kCurHideSubjectKey];
        NSMutableArray * arr = [NSMutableArray array];
        for (NSDictionary * dict in subjectDicts) {
            LJSubject * subject = [LJSubject subjectWithDict:dict];
            [arr addObject:subject];
        }
        _curHideSubjectsData = [arr copy];
    }
    return _curHideSubjectsData;
}

- (void)setCurHideSubjectsData:(NSArray *)curHideSubjectsData
{
    _curHideSubjectsData = curHideSubjectsData;
    [[LJDataManager manager] saveDictionaryWithObjects:curHideSubjectsData andPropertyNames:@[@"index", @"title", @"ID"] forKey:kCurHideSubjectKey];
}

#pragma mark - BBS列表数据

//数据加载
- (NSArray *)BBSListData
{
    if (!_BBSListData)
    {
        [self loadBBSListData];
    }
    return _BBSListData;
}

- (void)loadBBSListData
{
    //先加载本地的
    NSString * path = [[NSBundle mainBundle] pathForResource:kBBSListDataFileName ofType:nil];
    NSData * bbsListJsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:bbsListJsonData options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray * arr = [NSMutableArray array];
    for (NSDictionary * bbsListDict in dict[@"children"]) {
        LJBBSList * list = [LJBBSList bbsListWithDict:bbsListDict];
        [arr addObject:list];
    }
    _BBSListData = [arr copy];
    
    //然后加载远程的，并更新本地的数据
//    [LJNetWorking GET:kBBSListUrl parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
//        NSString * jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        [jsonString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
//        
//    } failure:^(NSHTTPURLResponse *response, NSError *error) {
//        NSLog(@"%@", error);
//    }];
}

//按照ID查找item
- (LJBBSListItem *)findBBSItemByID:(NSNumber *)ID inBBSLists:(NSArray *)bbsLists
{
    if (!bbsLists)
    {
        bbsLists = self.BBSListData;
    }
    
    for (LJBBSList * list in bbsLists) {
        if ([list.listItem.ID isEqualToNumber:ID])
        {
            return list.listItem;
        }
        else
        {
            if (list.children == nil)
            {
                continue;
            }
            LJBBSListItem * ret = [self findBBSItemByID:ID inBBSLists:list.children];
            if(ret != nil) return ret;
        }
    }
    return [LJBBSListItem bbsListItemWithID:ID];
}

@end
