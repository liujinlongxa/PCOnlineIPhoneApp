//
//  LJSubjectView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommonHeader.h"
#import "LJSubject.h"

@class LJSubjectView;

@protocol LJSubjectViewDelegate <NSObject>

@optional
- (void)subjectView:(LJSubjectView *)subjectView didSelectSubject:(LJSubject *)subject;

@end

@interface LJSubjectView : UIView

+ (instancetype)subjectView;

//设置显示的频道
@property (nonatomic, strong) NSArray * subjects;

@property (nonatomic, weak) id<LJSubjectViewDelegate> delegate;

@end
