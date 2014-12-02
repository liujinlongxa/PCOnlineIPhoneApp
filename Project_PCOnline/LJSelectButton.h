//
//  LJSubjectButton.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/2.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommonHeader.h"
#import "LJSubject.h"

@interface LJSelectButton : UIButton

+ (instancetype)selectButtonWithFrame:(CGRect)frame andTitle:(NSString *)title;
@property (nonatomic, strong) LJSubject * subject;
@end
