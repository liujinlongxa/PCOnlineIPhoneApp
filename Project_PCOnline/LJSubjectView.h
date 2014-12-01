//
//  LJSubjectView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommonHeader.h"

@interface LJSubjectView : UIView

+ (instancetype)subjectView;

//设置显示的频道
@property (nonatomic, strong) NSArray * subjects;

@end
