//
//  LJHotForumButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJHotForumButton.h"

#define kPadding 5

@interface LJHotForumButton ()

@property (nonatomic, weak) UILabel * titleLab;
@property (nonatomic, weak) UILabel * subTitleLab;

@end

@implementation LJHotForumButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置边框与颜色
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 1;
        
        //标题
        UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(kPadding, kPadding, CGRectGetWidth(frame) - 2 * kPadding, (CGRectGetHeight(frame) - 2 * kPadding) * 0.7)];
        [self addSubview:titleLab];
        self.titleLab = titleLab;
        //帖子数
        UILabel * subTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(kPadding, CGRectGetMaxY(titleLab.frame), CGRectGetWidth(titleLab.frame), CGRectGetHeight(frame) * 0.3)];
        [self addSubview:subTitleLab];
        self.subTitleLab = subTitleLab;
        self.subTitleLab.font = [UIFont systemFontOfSize:15];
        self.subTitleLab.textColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setHotForum:(LJHotForum *)hotForum
{
    _hotForum = hotForum;
    self.titleLab.text = hotForum.forumName;
    self.subTitleLab.text = [NSString stringWithFormat:@"帖子数:%@", hotForum.topics];
}

@end
