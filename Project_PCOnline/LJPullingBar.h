//
//  LJPullingBar.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJPullingBar;

@protocol LJPullingBarDelegate <NSObject>

- (void)pullingBar:(LJPullingBar *)bar didSelectBtnAtIndex:(NSInteger)index;

@end

@interface LJPullingBar : UIView

@property (nonatomic, weak) id<LJPullingBarDelegate> delegate;

- (instancetype)initPullingBarWithFrame:(CGRect)frame andTitles:(NSArray *)titles;

@end
