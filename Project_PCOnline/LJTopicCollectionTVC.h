//
//  LJTopicCollectionTVC.h
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJTopicDao.h"

@class LJTopicCollectionTVC;

@protocol LJTopicCollectionTVCDelegate <NSObject>

@optional
- (void)topicCollectionTVC:(LJTopicCollectionTVC *)topicCollTVC didSelectTopic:(LJTopicDaoModel *)topic;

@end

@interface LJTopicCollectionTVC : UITableViewController

@property (nonatomic, weak) id<LJTopicCollectionTVCDelegate> delegate;

@end
