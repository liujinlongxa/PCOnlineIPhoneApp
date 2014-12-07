//
//  LJBBSHotTopicTableVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBBSList.h"
#import "LJCommonHeader.h"

@class LJBBSSubForumListTVC;

@protocol LJBBSSubForumListTVCDelegate <NSObject>

- (void)BBSSubForumListTVC:(LJBBSSubForumListTVC *)controller didSelecteBBSItem:(LJBBSListItem *)bbsItem;

@end

@interface LJBBSSubForumListTVC : UIViewController
@property (nonatomic, strong) LJBBSList * bbsList;
@property (nonatomic, weak) id<LJBBSSubForumListTVCDelegate> delegate;
@end
