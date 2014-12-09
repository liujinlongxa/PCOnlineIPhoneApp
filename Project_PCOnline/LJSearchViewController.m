//
//  LJSearchViewController.m
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSearchViewController.h"
#import "LJSearchBar.h"
#import "LJCommonHeader.h"

@interface LJSearchViewController ()

@end

@implementation LJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LightGrayBGColor;
    LJSearchBar * bar = [[LJSearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andTitles:@[@"资讯", @"论坛", @"帖子", @"产品"] andActionBlock:^(NSInteger index) {
        LJLog(@"select index:%d", index);
    }];
    [self.view addSubview:bar];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
