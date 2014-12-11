//
//  LJChannelItemBtn.h
//  Project_PCOnline
//
//  Created by mac on 14-12-11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJSubject.h"

@interface LJChannelItemBtn : UIButton

- (instancetype)initWithFrame:(CGRect)frame andSubject:(LJSubject *)subject;

@property (nonatomic, assign, getter=isShow) BOOL show;
@property (nonatomic, strong) LJSubject * subject;
@property (nonatomic, strong) UIGestureRecognizer * dragGesture;

@end
