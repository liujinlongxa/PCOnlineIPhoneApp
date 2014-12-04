//
//  LJScrollTabButtonsView.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJScrollTabButton.h"
#import "LJCommonHeader.h"

@class LJScrollTabButtonsView;

@protocol LJScrollTabButtonsViewDelegate <NSObject>

@optional
- (void)scrollTabButtonsView:(LJScrollTabButtonsView *)view didSelectIndex:(NSInteger)index;

@end

@interface LJScrollTabButtonsView : UIView

+ (instancetype)scrollTabButtonsViewWithTitles:(NSArray *)titles;
@property (nonatomic, weak) id<LJScrollTabButtonsViewDelegate> delegate;

- (void)selectButtonAtIndex:(NSInteger)index;

@end
