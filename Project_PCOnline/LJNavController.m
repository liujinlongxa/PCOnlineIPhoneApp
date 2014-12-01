//
//  LJWhiteNavController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJNavController.h"

@implementation LJNavController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置navBar样式
    UINavigationBar * bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"pccommon_navbar_primary_64"] forBarMetrics:UIBarMetricsDefault];
    
    //设置文字
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:23]}];
    
    //设置button
    UIBarButtonItem * btn = [UIBarButtonItem appearance];
    NSMutableDictionary * attrDict = [NSMutableDictionary dictionary];
    [attrDict setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [btn setTitleTextAttributes:attrDict forState:UIControlStateNormal];
//    btn.imageInsets = UIEdgeInsetsMake(2, 5, 2, 5);
}

@end
