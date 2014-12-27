//
//  LJSettingSubtitleCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/21.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJSettingSubtitleCell.h"

@interface LJSettingSubtitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@end

@implementation LJSettingSubtitleCell

- (void)setItem:(LJSettingSubtitleItem *)item
{
    _item = item;
    self.titleLab.text = item.title;
    self.subTitleLab.text = item.subtitle;
    //添加KVO
    [self addObserver:self forKeyPath:@"item.subtitle" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)prepareForReuse
{
    [self.item removeObserver:self forKeyPath:@"item.subtitle"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == NULL) {
        if ([keyPath isEqualToString:@"item.subtitle"]) {
            NSString * subtitle = change[NSKeyValueChangeNewKey];
            NSAssert(subtitle != nil, @"subtitle is nil");
            self.subTitleLab.text = subtitle;
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"item.subtitle"];
}

@end
