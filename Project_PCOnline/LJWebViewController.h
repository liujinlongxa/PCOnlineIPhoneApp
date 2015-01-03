//
//  LJWebViewController.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/12.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBaseWebViewController.h"
#import "LJCommentPageInfo.h"
#import "LJCommentBar.h"

@interface LJWebViewController : LJBaseWebViewController

/**
 *  分页信息
 */
@property (nonatomic, strong) LJCommentPageInfo * pageInfo;

/**
 *  要加载的url
 */
@property (nonatomic, copy) NSString * urlStr;

/**
 *  当前页
 */
@property (nonatomic, assign) NSInteger curPage;

/**
 *  评论Bar
 */
@property (nonatomic, weak) LJCommentBar * commentBar;

/**
 *  点击中间的Button，触发事件，可供子类重写
 *
 *  @param bar           评论Bar
 *  @param collectionBtn 收藏/刷新Button
 */
- (void)commentBar:(LJCommentBar *)bar didSelectMidButton:(UIButton *)collectionBtn;

@end
