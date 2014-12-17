//
//  LJPriceTableView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBaseCustomTableView.h"
#import "LJNormalTableView.h"
#import "LJArea.h"
@interface LJPriceTableView : LJNormalTableView

@property (nonatomic, strong) LJArea * curArea;

@end
