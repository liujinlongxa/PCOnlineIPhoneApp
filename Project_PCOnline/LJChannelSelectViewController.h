//
//  LJChannelSelectViewController.h
//  Project_PCOnline
//
//  Created by mac on 14-12-11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJChannelItemBtnsView.h"
@class LJChannelSelectViewController;

@protocol LJChannelSelectViewControllerDelegate <NSObject>

@optional
- (void)channelSelectViewControllerShowViewFrame:(LJChannelSelectViewController *)controller;

@end

@interface LJChannelSelectViewController : UIViewController

@property (nonatomic, weak) LJChannelItemBtnsView * showChannelView;
@property (nonatomic, weak) LJChannelItemBtnsView * hideChannelView;
@property (nonatomic, weak) id<LJChannelSelectViewControllerDelegate> delegate;

- (void)saveChannelList;

@end
