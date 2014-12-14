//
//  MBProgressHUD+LJProgressHUD.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "MBProgressHUD+LJProgressHUD.h"

//static MBProgressHUD * successHUD;
//static MBProgressHUD * failedHUD;
static MBProgressHUD * labelHUD;

@implementation MBProgressHUD (LJProgressHUD)

+ (void)showLoadingHUDInView:(UIView *)view
{
    [self showHUDAddedTo:view animated:YES];
}

+ (void)hideLoadingHUDInView:(UIView *)view
{
    [self hideAllHUDsForView:view animated:YES];
}

+ (void)showNotificationMessage:(NSString *)message InView:(UIView *)view
{
    labelHUD = [[MBProgressHUD alloc] initWithView:view];
    labelHUD.removeFromSuperViewOnHide = YES;
    labelHUD.mode = MBProgressHUDModeText;
    labelHUD.labelText = message;
    [view addSubview:labelHUD];
    [labelHUD show:YES];
    [labelHUD hide:YES afterDelay:1.0f];
}

@end
