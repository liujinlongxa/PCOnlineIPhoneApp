//
//  LJCommentTableHeaderView.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommentPageInfo.h"
#import "LJCommentSupportInfo.h"

@class LJCommentTableHeaderView;

@protocol LJCommentTableHeaderViewDelegate <NSObject>

/**
 *  点击顶/踩之后的回调
 *
 *  @param header headerView自身
 *  @param type   顶/踩类型
 */
- (void)commentTableHeaderView:(LJCommentTableHeaderView *)header didChangeSupport:(LJCommentSupportType)type;

@end

@interface LJCommentTableHeaderView : UIView

/**
 *  新闻顶踩信息
 */
@property (nonatomic, strong) LJCommentSupportInfo * supprotInfo;

/**
 *  评论数据
 */
@property (nonatomic, strong) LJCommentPageInfo * pageInfo;

/**
 *  代理
 */
@property (nonatomic, weak) id<LJCommentTableHeaderViewDelegate> delegate;

/**
 *  顶
 */
- (void)addAgree;

/**
 *  踩
 */
- (void)addDisagree;

@end
