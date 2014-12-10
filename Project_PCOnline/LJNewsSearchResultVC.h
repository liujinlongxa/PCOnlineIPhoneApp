//
//  LJNewsSearchResultVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJNewsSearchResultVC;

@protocol LJNewsSearchResultVCDelegate <NSObject>

- (void)newsSearchResultVC:(LJNewsSearchResultVC *)controller didSelectWithObject:(id)obj;

@end

@interface LJNewsSearchResultVC : UIViewController

@property (nonatomic, copy) NSString * keyWord;
@property (nonatomic, weak) id<LJNewsSearchResultVCDelegate> delegate;

@end
