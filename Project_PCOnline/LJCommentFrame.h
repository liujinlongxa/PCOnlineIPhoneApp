//
//  LJCommentFrame.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LJComment.h"

#define SmallLightFont [UIFont systemFontOfSize:13]
#define ContentFont [UIFont systemFontOfSize:15]
#define ButtonTitleFont [UIFont systemFontOfSize:14]

@interface LJCommentFrame : NSObject

@property (nonatomic, strong) LJComment * comment;

@property (nonatomic, assign) CGRect phoneIconFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect floorFrame;
@property (nonatomic, strong) NSArray * replyContentFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect timeFrame;
@property (nonatomic, assign) CGRect supportFrame;
@property (nonatomic, assign) CGRect replyBtnFrame;

@property (nonatomic, assign) CGFloat cellHeigh;

@end
