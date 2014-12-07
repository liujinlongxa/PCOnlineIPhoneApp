//
//  LJHotForumsView.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommonHeader.h"
#import "LJHotForum.h"

@class LJHotForumsView;

@protocol LJHotForumsViewDelegate <NSObject>

- (void)hotForumView:(LJHotForumsView *)view didSelectHotForum:(LJHotForum *)hotForum;

@end

@interface LJHotForumsView : UIView

@property (nonatomic, strong) NSArray * forumsData;
@property (nonatomic, weak) id<LJHotForumsViewDelegate> delegate;

@end
