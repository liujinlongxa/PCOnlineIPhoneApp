//
//  LJTopicSearchResultCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJTopicSearchResultCell.h"
#import "LJTopicSearchResultItem.h"
#import "NSDate+MyDate.h"

@interface LJTopicSearchResultCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *postAtLab;
@property (weak, nonatomic) IBOutlet UILabel *floorLab;

@end

@implementation LJTopicSearchResultCell

- (void)setItem:(LJTopicSearchResultItem *)item
{
    _item = item;
    self.titleLab.text = item.title;
    NSDate * createAt = [NSDate dateWithTimeIntervalSince1970:item.createAt.longLongValue];
    self.postAtLab.text = [createAt dateStringToNow];
    self.floorLab.text = [NSString stringWithFormat:@"%d楼", item.replycount.integerValue];
}

@end
