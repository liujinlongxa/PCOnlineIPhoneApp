//
//  LJCollectionBGView.h
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LJCollectionBGViewTypeArticle,
    LJCollectionBGViewTypeBBS,
    LJCollectionBGViewTypeTopic,
} LJCollectionBGViewType;

@interface LJCollectionBGView : UIView

@property (nonatomic, assign) LJCollectionBGViewType bgType;

@end
