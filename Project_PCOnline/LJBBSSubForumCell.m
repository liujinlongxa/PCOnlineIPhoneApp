//
//  LJBBSSubForumCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/7.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSSubForumCell.h"

@implementation LJBBSSubForumCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.layer.borderWidth = 0.5;
        self.contentView.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    return self;
}

- (void)setBbsItem:(LJBBSListItem *)bbsItem
{
    _bbsItem = bbsItem;
    self.textLabel.text = bbsItem.title;
}

@end
