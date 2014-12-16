//
//  LJAreaManualSelectCell.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/16.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJArea.h"

@interface LJAreaManualSelectCell : UITableViewCell

@property (nonatomic, strong) LJArea * area;

- (void)setupSelect;
- (void)setupDeselect;

@end
