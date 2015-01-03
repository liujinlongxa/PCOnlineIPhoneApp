//
//  MBProgressHUD+LJProgressHUD.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LJProgressHUD)

+ (void)showLoadingHUDInView:(UIView *)view;
+ (void)hideLoadingHUDInView:(UIView *)view;

+ (void)showNotificationMessage:(NSString *)message InView:(UIView *)view;
+ (void)showNotificationMessageInWindow:(NSString *)message;
@end
