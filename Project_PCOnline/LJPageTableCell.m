//
//  LJPageTableCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/12.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJPageTableCell.h"
#import "LJCommonHeader.h"

@implementation LJPageTableCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected)
    {
        self.textLabel.textColor = BlueTextColor;
    }
    else
    {
        self.textLabel.textColor = [UIColor blackColor];
    }
}

@end
