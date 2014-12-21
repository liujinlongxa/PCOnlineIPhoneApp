//
//  LJCommonData.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommonData.h"
#import "LJNetWorking.h"
#import "LJSubject.h"
#import "LJDataManager.h"
#import "LJBBSListItem.h"
#import "LJBBSList.h"

//setting
#import "LJBaseSettingItem.h"
#import "LJSettingSwitchItem.h"
#import "LJSettingActionItem.h"
#import "LJSettingSubtitleItem.h"
#import "LJSettingTwoImageItem.h"
#import "LJSettingChildSelectItem.h"

#define kSubjectAndAreaDataFileName @"pconline_v4_cms_iphone_channel_tree4inch.json"
#define kBBSListDataFileName @"pconline_v4_bbs_forum_tree4inch.json"

#define KCurShowSubjectKey @"CurShowSubject"
#define kCurHideSubjectKey @"CurHideSubject"

#define kCurLocationKey @"CurLocation"

@interface LJCommonData ()

@property (nonatomic, strong) NSMutableDictionary * channelAndArea;
@property (nonatomic, strong) NSString * filePath;

@end

@implementation LJCommonData

@synthesize curShowSubjectsData = _curShowSubjectsData;
@synthesize curHideSubjectsData = _curHideSubjectsData;
@synthesize curArea = _curArea;

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

//获取当前的位置数据
- (LJArea *)curArea
{
    if (!_curArea)
    {
        NSString * index = [[NSUserDefaults standardUserDefaults] objectForKey:kCurLocationKey];
        if (!index)
        {
            _curArea = self.AreaData[0];
        }
        else
        {
            for (LJArea * area in self.AreaData) {
                if ([area.index isEqualToString:index])
                {
                    _curArea = area;
                    break;
                }
            }
        }
    }
    return _curArea;
}

- (void)setCurArea:(LJArea *)curArea
{
    _curArea = curArea;
    [[NSUserDefaults standardUserDefaults] setObject:curArea.index forKey:kCurLocationKey];
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

#pragma mark - 设置数据
- (NSArray *)settingData
{
    if (!_settingData) {
        [self setupSettingData];
    }
    return _settingData;
}

- (void)setupSettingData
{
    NSMutableArray * settingData = [NSMutableArray array];
    
    //section 1
    NSMutableArray * settingDataSection1 = [NSMutableArray array];
    LJSettingTwoImageItem * item11 = [[LJSettingTwoImageItem alloc] initWithTitle:@"绑定分享平台" andType:LJSettingItemTypeTwoImage andAction:nil];
    item11.image1 = [UIImage imageNamed:@"btn_setting_sina_weibo_nologin"];
    item11.image2 = [UIImage imageNamed:@"btn_setting_qq_nologin"];
    [settingDataSection1 addObject:item11];
    [settingData addObject:settingDataSection1];
    
    //section 2
    NSMutableArray * settingDataSection2 = [NSMutableArray array];
    //item 21
    LJSettingChildSelectItem * item21 = [[LJSettingChildSelectItem alloc] initWithTitle:@"文章字号大小" andType:LJSettingItemTypeChildSelect andAction:nil];
    item21.childItems = @[@"小字体", @"中字体", @"大字体"];
    item21.selectIndex = 0;
    [settingDataSection2 addObject:item21];
    //item 22
    LJSettingChildSelectItem * item22 = [[LJSettingChildSelectItem alloc] initWithTitle:@"非wifi下显示" andType:LJSettingItemTypeChildSelect andAction:nil];
    item22.childItems = @[@"无图", @"小图", @"大图"];
    item22.selectIndex = 0;
    item22.message = @"流量控制：选择小图或无图能够帮您更加省流量";
    [settingDataSection2 addObject:item22];
    //item 23
    LJSettingChildSelectItem * item23 = [[LJSettingChildSelectItem alloc] initWithTitle:@"离线阅读管理" andType:LJSettingItemTypeChildSelect andAction:nil];
    item23.childItems = @[@"手动下载", @"wifi网络下自动下载"];
    item23.message = @"离线阅读：下载内容到手机，没有网络照样看";
    item23.selectIndex = 0;
    [settingDataSection2 addObject:item23];
    [settingData addObject:settingDataSection2];
    
    //section 3
    NSMutableArray * settingDataSection3 = [NSMutableArray array];
    LJSettingSwitchItem * item31 = [[LJSettingSwitchItem alloc] initWithTitle:@"推送开关" andType:LJSettingItemTypeSwitch andAction:nil];
    [settingDataSection3 addObject:item31];
    [settingData addObject:settingDataSection3];
    
    //section 4
    NSMutableArray * settingDataSection4 = [NSMutableArray array];
    //item 41
    LJSettingSubtitleItem * item41 = [[LJSettingSubtitleItem alloc] initWithTitle:@"清理缓存" andType:LJSettingItemTypeSubtitle andAction:nil];
    NSUInteger curCache = [LJNetWorking shareNetwork].currnetCacheSize / 2048.0 / 2048.0;
    item41.subtitle = [NSString stringWithFormat:@"%dM", curCache];
    [settingDataSection4 addObject:item41];
    //item42
    LJSettingActionItem * item42 = [[LJSettingActionItem alloc] initWithTitle:@"关于我们" andType:LJSettingItemTypeWithAction andAction:nil];
    [settingDataSection4 addObject:item42];
    //item43
    LJSettingActionItem * item43 = [[LJSettingActionItem alloc] initWithTitle:@"给个评价" andType:LJSettingItemTypeWithAction andAction:nil];
    [settingDataSection4 addObject:item43];
    //item44
    LJSettingActionItem * item44 = [[LJSettingActionItem alloc] initWithTitle:@"用户体验计划" andType:LJSettingItemTypeWithAction andAction:nil];
    [settingDataSection4 addObject:item44];
    //item45
    LJSettingActionItem * item45 = [[LJSettingActionItem alloc] initWithTitle:@"精品应用推荐" andType:LJSettingItemTypeWithAction andAction:nil];
    [settingDataSection4 addObject:item45];
    [settingData addObject:settingDataSection4];
    
    _settingData = [settingData copy];
}

@end
