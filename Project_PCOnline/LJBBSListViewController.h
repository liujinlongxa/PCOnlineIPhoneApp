//
//  LJBBSListViewController.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJUrlHeader.h"
#import "LJCommonHeader.h"
#import "LJBBSList.h"

@class LJBBSListViewController;

@protocol LJBBSListViewControllerDelegate <NSObject>

@optional
- (void)BBSListViewController:(LJBBSListViewController *)controller didSelectedBBS:(LJBBSList *)bbsList;
- (void)BBSListViewController:(LJBBSListViewController *)controller didSelectedSubForum:(LJBBSListItem *)bbsItem;
@end

@interface LJBBSListViewController : UIViewController

@property (nonatomic, weak) id<LJBBSListViewControllerDelegate> delegate;

@end
