//
//  LJAreaTableViewController.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/16.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJArea.h"

@class LJAreaTableViewController;

@protocol LJAreaTableViewControllerDelegate <NSObject>

- (void)areaTableViewController:(LJAreaTableViewController *)controller didSelectArea:(LJArea *)area;

@end

@interface LJAreaTableViewController : UITableViewController

@property (nonatomic, weak) id<LJAreaTableViewControllerDelegate> delegate;

@end
