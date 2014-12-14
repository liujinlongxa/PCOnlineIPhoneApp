//
//  ScrollTabViewController.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJScrollTabViewController;

@protocol LJScrollTabViewControllerDelegate <NSObject>

- (void)LJScrollTabViewController:(LJScrollTabViewController *)controller didSelectController:(UIViewController *)selectController;

@end

@interface LJScrollTabViewController : UIViewController
@property (nonatomic, strong, readonly) NSArray * lj_viewControllers;
@property (nonatomic, strong, readonly) NSArray * lj_tabTitles;

- (void)selectTabAtIndex:(NSInteger)index;
+ (instancetype)scrollTabViewControllerWithController:(NSArray *)controllers andTitles:(NSArray *)titles;

@end
