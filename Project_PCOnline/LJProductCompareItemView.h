//
//  LJProductCompareItemView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJProduct.h"

@class LJProductCompareItemView;

@protocol LJProductCompareItemViewDelegate <NSObject>

@optional
- (void)productCompareItemViewCloseProductItem:(LJProductCompareItemView *)view;
- (void)productCompareItemViewAddProductItem:(LJProductCompareItemView *)view;

@end

@interface LJProductCompareItemView : UIView

+ (instancetype)productCompareItemViewWithFrame:(CGRect)frame andProduct:(LJProduct *)product;
@property (nonatomic, weak) id<LJProductCompareItemViewDelegate> delegate;

@property (nonatomic, strong) LJProduct * product;

@end
