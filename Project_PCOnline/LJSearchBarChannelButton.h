//
//  LJSearchBarChannelButton.h
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJSearchBarChannelButton : UIView
@property (nonatomic, assign) NSInteger curSelectIndex;
- (instancetype)initWithFrame:(CGRect)frame andTitiles:(NSArray *)titles andActionBlock:(void (^)(NSInteger index))actionBlock;

@end
