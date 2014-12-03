//
//  InfiniteScrollView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJInfiniteScrollView : UIScrollView

- (void)startInfiniteScrollView;
- (void)stopScroll;
@property (nonatomic, assign) NSTimeInterval time;

@end
