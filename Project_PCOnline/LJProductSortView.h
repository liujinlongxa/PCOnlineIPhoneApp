//
//  LJProductSortView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJProductSortView;

@protocol LJProductSortViewDelegate <NSObject>

@optional
- (void)productSortView:(LJProductSortView *)view didSelectIndex:(NSInteger)index;

@end

@interface LJProductSortView : UIView

+ (instancetype)productScoTViewWithFrame:(CGRect)frame andButTitles:(NSArray *)titles;
@property (nonatomic, weak) id<LJProductSortViewDelegate> delegate;
@end
