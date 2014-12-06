//
//  LJFastForumHeaderView.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBBSList.h"
#import "LJCommonHeader.h"

@class LJFastForumHeaderView;

@protocol LJFastForumHeaderViewDelegate <NSObject>

@optional
- (void)fastForumHeaderView:(LJFastForumHeaderView *)header didSelectForumItem:(LJBBSListItem *)item;

@end

@interface LJFastForumHeaderView : UIView

@property (nonatomic, strong) LJBBSList * bbsList;
@property (nonatomic, weak) id<LJFastForumHeaderViewDelegate> delegate;

+ (instancetype)fastForumHeaderViewWithBBSList:(LJBBSList *)bbsList;

@end
