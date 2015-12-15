//
//  LJBBSSquareViewController.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBaseViewController.h"
#import "LJUrlHeader.h"
#import "LJCommonHeader.h"
#import "LJHotTopic.h"
#import "LJHotForum.h"
#import "LJBBSList.h"

@class LJBBSSquareViewController;

@protocol  LJBBSSquareViewControllerDelegate <NSObject>

@optional
- (void)BBSSquareViewController:(LJBBSSquareViewController *)controller didSelectHotTopic:(LJHotTopic *)topic;
- (void)BBSSquareViewController:(LJBBSSquareViewController *)controller didSelectFastForum:(LJBBSList *)bbsList;
- (void)BBSSquareViewController:(LJBBSSquareViewController *)controller didSelectHotForum:(LJHotForum *)hotForum;
- (void)BBSSquareViewController:(LJBBSSquareViewController *)controller didSelectMoreHotTopic:(NSString *)urlStr;


@end

@interface LJBBSSquareViewController : LJBaseViewController

@property (nonatomic, weak) id<LJBBSSquareViewControllerDelegate> delegate;

@end
