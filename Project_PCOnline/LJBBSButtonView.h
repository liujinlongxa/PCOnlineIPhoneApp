//
//  LJBBSButtonView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommonHeader.h"
#import "LJSelectButton.h"

@class LJBBSButtonView;

@protocol LJBBSButtonViewDelegate <NSObject>

@optional
- (void)BBSButtonView:(LJBBSButtonView *)view didClickButton:(LJSelectButton *)button;

@end

@interface LJBBSButtonView : UIView

+ (instancetype)bbsButtonViewWithFrame:(CGRect)frame andTitles:(NSArray *)titles;

@property (nonatomic, weak) id<LJBBSButtonViewDelegate> delegate;

@end
