//
//  LJTabBar.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommonHeader.h"
#import "LJTabButton.h"

@class LJTabBar;

@protocol LJTabBarDelegate <NSObject>

- (void)tabBar:(LJTabBar *)tabBar didselectButton:(LJTabButton *)button;

@end

@interface LJTabBar : UIView

@property (nonatomic, weak) id<LJTabBarDelegate> delegate;

@end
