//
//  LJFastForumButton.h
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBBSList.h"

@interface LJFastForumButton : UIButton

@property (nonatomic, strong) LJBBSList * fastForumList;

+ (instancetype)fastForumButtonWithImage:(NSString *)imageName;

@end
