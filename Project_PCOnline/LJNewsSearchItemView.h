//
//  LJNewsSearchItemView.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJNewsSearchResultItem;

@interface LJNewsSearchItemView : UIControl

@property (nonatomic, strong) LJNewsSearchResultItem * newsItem;
- (instancetype)initWithFrame:(CGRect)frame andActionBlock:(void (^)(LJNewsSearchResultItem * newsItem))clickActionBlcok;
@end
