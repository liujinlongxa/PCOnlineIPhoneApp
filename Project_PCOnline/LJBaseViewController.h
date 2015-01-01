//
//  LJBaseViewController.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"

@interface LJBaseViewController : UIViewController


- (void)setupNavButton;

//允许子类重写，并自定定制导航栏上左右按钮的事件
/**
 *  点击搜索按钮
 */
- (void)searchBtnClick:(__unused id)sender;

/**
 *  点击用户中心按钮
 */
- (void)userCenterClick:(__unused id)sender;

@end
