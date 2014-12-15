//
//  LJCommentItemFrame.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LJCommentItem.h"

#define ReplySmallLightFont [UIFont systemFontOfSize:12]
#define ReplyContentFont [UIFont systemFontOfSize:15]


@interface LJCommentItemFrame : NSObject

@property (nonatomic, assign) CGRect floorFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect indexFrame;

@property (nonatomic, assign) CGRect viewFrame;
@property (nonatomic, assign) CGFloat contentHeigh;
@property (nonatomic, assign) CGFloat startY;

@property (nonatomic, strong) LJCommentItem * item;

- (instancetype)initCommentItemFrameWithViewFrame:(CGRect)viewFrame;

@end
