//
//  LJCommentTableVC.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/14.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommentInfo.h"
#import "LJNews.h"
#import "LJCommentPageInfo.h"

@interface LJCommentTableVC : UIViewController

@property (nonatomic, strong) LJCommentInfo * commentInfo;
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) LJCommentPageInfo * pageInfo;
@property (nonatomic, assign, getter=isShowHeader) BOOL showHeader;
@end
