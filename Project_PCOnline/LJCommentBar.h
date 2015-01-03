//
//  LJCommentBar.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/12.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//  评论条

#import <UIKit/UIKit.h>
#import "LJCommentPageInfo.h"

#define kBarH 60

typedef enum : NSUInteger {
    LJCommentBarButtonTypeCollection,
    LJCommentBarButtonTypeRefresh,
} LJCommentBarButtonType;

@class LJCommentBar;

/**
 *  CommentBar代理协议
 */
@protocol LJCommentBarDelegate <NSObject>
@optional
/**
 *  点击分页按钮代理方法
 */
- (void)commentBar:(LJCommentBar *)bar didSelectPageButton:(UIButton *)pageBtn;

/**
 *  点击中间的按钮代理方法(刷新/收藏)
 */
- (void)commentBar:(LJCommentBar *)bar didSelectMidButton:(UIButton *)collectionBtn;
@end

@interface LJCommentBar : UIView

/**
 *  分页信息
 */
@property (nonatomic, strong) LJCommentPageInfo * page;

/**
 *  当前页
 */
@property (nonatomic, assign) NSInteger curPage;

/**
 *  代理
 */
@property (nonatomic, weak) id<LJCommentBarDelegate> delegate;

/**
 *  中间Button的类型
 */
@property (nonatomic, assign) LJCommentBarButtonType commentBarBtnType;


/**
 *  中间的Button（收藏/刷新)
 */
@property (nonatomic, weak) UIButton * middleButton;
@end
