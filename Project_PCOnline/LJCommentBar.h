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

@class LJCommentBar;

@protocol LJCommentBarDelegate <NSObject>

@optional
- (void)commentBar:(LJCommentBar *)bar didSelectPageButton:(UIButton *)pageBtn;
- (void)commentBar:(LJCommentBar *)bar didSelectCollectionButton:(UIButton *)collectionBtn;

@end

@interface LJCommentBar : UIView

@property (nonatomic, strong) LJCommentPageInfo * page;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, weak) id<LJCommentBarDelegate> delegate;

@end
