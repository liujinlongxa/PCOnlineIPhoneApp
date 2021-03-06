//
//  LJAdView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBaseAds.h"
#import "LJCommonHeader.h"

@interface LJAdView : UIView
//创建一个广告显示，title可以为空
+ (instancetype)adViewWithFrame:(CGRect)frame andImage:(NSString *)imageUrl andTitle:(NSString *)title;

- (void)updateWithImage:(NSString *)imageUrl andTitle:(NSString *)title;

@property (nonatomic, strong) LJBaseAds * ad;

@end
