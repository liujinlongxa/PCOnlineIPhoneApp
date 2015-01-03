//
//  LJBBSCollectionTVC.h
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBBSListItem.h"

@class LJBBSCollectionTVC;

@protocol LJBBSCollectionTVCDelegate <NSObject>

@optional
- (void)bbsCollectionTVC:(LJBBSCollectionTVC *)bbsCollTVC didSelectBBS:(LJBBSListItem *)bbsItem;

@end

@interface LJBBSCollectionTVC : UITableViewController

@property (nonatomic, weak) id<LJBBSCollectionTVCDelegate> delegate;

@end
