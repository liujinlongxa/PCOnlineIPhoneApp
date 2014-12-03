//
//  LJNormalTableView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJSubject.h"
#import "LJUrlHeader.h"
#import "LJCommonHeader.h"
#import "LJBaseCustomTableView.h"

@interface LJNormalTableView : LJBaseCustomTableView

@property (nonatomic, strong) LJSubject * subject;
@property (nonatomic, strong) NSMutableArray * adsData;

- (void)reloadHeaderView;

@end
