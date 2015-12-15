//
//  LJBBSHotTopicTableVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBaseViewController.h"
#import "LJBBSList.h"
#import "LJCommonHeader.h"

@class LJBBSSubForumListTVC;

@protocol LJBBSSubForumListTVCDelegate <NSObject>

- (void)BBSSubForumListTVC:(LJBBSSubForumListTVC *)controller didSelecteBBSItem:(LJBBSListItem *)bbsItem;

@end

@interface LJBBSSubForumListTVC : LJBaseViewController
@property (nonatomic, strong) LJBBSList * bbsList;
@property (nonatomic, weak) id<LJBBSSubForumListTVCDelegate> delegate;
@end
