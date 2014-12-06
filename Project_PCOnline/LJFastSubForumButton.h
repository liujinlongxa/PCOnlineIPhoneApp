//
//  LJFastSubForumButton.h
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBBSList.h"

#define kBtnW 55
#define kBtnH 70

@interface LJFastSubForumButton : UIButton

@property (nonatomic, strong) LJBBSListItem * bbsListItem;

+ (instancetype)fastSubForumButtonWithItem:(LJBBSListItem *)item;

@end
