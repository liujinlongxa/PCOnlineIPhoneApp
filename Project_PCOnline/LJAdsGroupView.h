//
//  LJAdView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBaseAds.h"

@interface LJAdsGroupView : UIView

+ (instancetype)adViewWithAds:(NSArray *)ads andFrame:(CGRect)frame;
- (void)reloadViewWithAds:(NSArray *)ads;

@end
