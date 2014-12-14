//
//  MBProgressHUD+LJProgressHUD.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LJProgressHUD)

//+ (void)showSuccessHUDWithMessage:(NSString *)message inView:(UIView *)view;
//+ (void)hideScccessHUDInView:(UIView *)view;

//+ (void)showFailedHUDWithMessage:(NSString *)message inView:(UIView *)view;
//+ (void)hideFailedHUDInView:(UIView *)view;
//
+ (void)showLoadingHUDInView:(UIView *)view;
+ (void)hideLoadingHUDInView:(UIView *)view;

+ (void)showNotificationMessage:(NSString *)message InView:(UIView *)view;

@end
