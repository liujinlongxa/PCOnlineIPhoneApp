//
//  LJBBSListDetailController.h
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJScrollTabViewController.h"
#import "LJBBSHotTopicTableVC.h"
#import "LJBBSSubTopicListTableVC.h"
#import "LJBBSList.h"

@interface LJBBSListDetailController : LJScrollTabViewController<LJBBSHotTopicTableVCDelegate>

@property (nonatomic, strong) LJBBSList * bbsList;
+ (instancetype)BBSListDetailControllerWithControllers:(NSArray *)controllers andTitles:(NSArray *)titles;

@end
