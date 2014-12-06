//
//  LJFastForumHeaderView.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBBSList.h"
#import "LJCommonHeader.h"

@interface LJFastForumHeaderView : UIView

@property (nonatomic, strong) LJBBSList * bbsList;

+ (instancetype)fastForumHeaderViewWithBBSList:(LJBBSList *)bbsList;

@end
