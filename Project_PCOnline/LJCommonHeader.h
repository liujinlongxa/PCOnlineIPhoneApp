//
//  LJCommonHeader.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#ifndef Project_PCOnline_LJCommonHeader_h
#define Project_PCOnline_LJCommonHeader_h

//屏幕尺寸
#define kScrW [UIScreen mainScreen].bounds.size.width
#define kScrH [UIScreen mainScreen].bounds.size.height

//tabBar高度
#define kTabBarH 49

//导航栏高度
#define kNavBarH 44

//状态栏高度
#define kStatusBarH 20

//蓝色文字颜色
#define BlueTextColor [[UIColor alloc] initWithRed:31 / 255.0 green:137 / 255.0 blue:227 /255.0 alpha:1.0]

//字体
#define SubjectButtonFont [UIFont systemFontOfSize:20] //频道Button上的字体大小

//颜色
#define RGBColor(r,g,b) ([[UIColor alloc] initWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0])

//通知
#define LJAdsViewTapNotify @"AdsViewTapNotify" //广告点击通知
#define LJAdsViewTapNotifyAdsKey @"AdsViewTapNotifyAdsKey" //取得广告模型的键

#endif
