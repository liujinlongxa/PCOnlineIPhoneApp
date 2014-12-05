//
//  LJBBSHotForumsTableVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBBSList.h"
#import "LJCommonHeader.h"
#import "LJUrlHeader.h"
#import "LJHotTopic.h"

@class LJBBSHotTopicTableVC;

@protocol LJBBSHotTopicTableVCDelegate <NSObject>

@optional
- (void)BBSTopicTableVC:(LJBBSHotTopicTableVC *)vc didSelectTopic:(LJHotTopic *)topic inBBSList:(LJBBSList *)bbsList;

@end

@interface LJBBSHotTopicTableVC : UITableViewController

@property (nonatomic, strong) LJBBSList * bbsList;
@property (nonatomic, weak) id<LJBBSHotTopicTableVCDelegate> delegate;

@end
