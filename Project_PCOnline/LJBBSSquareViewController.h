//
//  LJBBSSquareViewController.h
//  Project_PCOnline
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
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

@end

@interface LJBBSSquareViewController : UIViewController

@property (nonatomic, weak) id<LJBBSSquareViewControllerDelegate> delegate;

@end
