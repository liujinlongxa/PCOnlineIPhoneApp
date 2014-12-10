//
//  LJTopicSearchResultVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJTopicSearchResultItem;

@interface LJTopicSearchResultVC : UIViewController

@property (nonatomic, copy) NSString * keyWord;
- (instancetype)initWithSelectActionBlock:(void (^)(LJTopicSearchResultItem * item))actionBlock;
@end
