//
//  LJCommentTableHeaderView.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommentPageInfo.h"
#import "LJCommentSupportInfo.h"

@interface LJCommentTableHeaderView : UIView

@property (nonatomic, strong) LJCommentSupportInfo * supprotInfo;
@property (nonatomic, strong) LJCommentPageInfo * pageInfo;

@end
