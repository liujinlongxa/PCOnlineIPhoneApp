//
//  LJHotPostsCell.m
//  Project_PCOnline
//
//  Created by mac on 14-12-5.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJHotTopicCell.h"
#import "UIImageView+WebCache.h"
#import "LJContentView.h"

@interface LJHotTopicCell ()
@property (weak, nonatomic) UILabel *titleLab;
@property (weak, nonatomic) UIImageView *image;
@property (weak, nonatomic) UILabel *messageLab;
@property (weak, nonatomic) UILabel *forumLab;
@property (weak, nonatomic) UILabel *floorCountLab;
@property (weak, nonatomic) LJContentView * myContentView;
@end

@implementation LJHotTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置cell属性
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = LightGrayBGColor;
        
        //content view
        LJContentView * content = [[LJContentView alloc] init];
        [self.contentView addSubview:content];
        self.myContentView = content;
        
        //title
        UILabel * titleLab = [[UILabel alloc] init];
        [self.myContentView addSubview:titleLab];
        self.titleLab = titleLab;
        self.titleLab.font = TopicTitleFont;
        self.titleLab.numberOfLines = 2;
        
        //image
        UIImageView * image = [[UIImageView alloc] init];
        [self.myContentView addSubview:image];
        self.image = image;
        self.image.contentMode = UIViewContentModeCenter;
        self.image.clipsToBounds = YES;
        
        //forum
        UILabel * forumLab = [[UILabel alloc] init];
        [self.myContentView addSubview:forumLab];
        self.forumLab = forumLab;
        self.forumLab.font = TopicForumFont;
        self.forumLab.textColor = BlueTextColor;
        
        //message
        UILabel * messageLab = [[UILabel alloc] init];
        [self.myContentView addSubview:messageLab];
        self.messageLab = messageLab;
        self.messageLab.font = TopicMessageFont;
        self.messageLab.numberOfLines = 2;
        self.messageLab.textColor = [UIColor lightGrayColor];
        
        //floor count
        UILabel * floorCountLab = [[UILabel alloc] init];
        [self.myContentView addSubview:floorCountLab];
        self.floorCountLab = floorCountLab;
        self.floorCountLab.font = TopicFloorCountFont;
        self.floorCountLab.textColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setTopicFrame:(LJHotTopicFrame *)topicFrame
{
    _topicFrame = topicFrame;
    [self setupData];
    [self setupFrame];
}

- (void)setupData
{
    self.titleLab.text = self.topicFrame.topic.title;
    self.messageLab.text = self.topicFrame.topic.message;
    self.forumLab.text = self.topicFrame.topic.forumName;
    self.floorCountLab.text = [NSString stringWithFormat:@"%d楼/%d阅", self.topicFrame.topic.replyCount.integerValue, self.topicFrame.topic.viewCount.integerValue];
    if (self.topicFrame.topic.isShowImage)
    {
        [self.image sd_setImageWithURL:[NSURL URLWithString:self.topicFrame.topic.image] placeholderImage:[UIImage imageNamed:@"common_default_320x165"]];
    }
}

- (void)setupFrame
{
    self.myContentView.frame = self.topicFrame.contentFrame;
    self.titleLab.frame = self.topicFrame.titleFrame;
    self.messageLab.frame = self.topicFrame.messageFrame;
    self.image.frame = self.topicFrame.imageFrame;
    self.floorCountLab.frame = self.topicFrame.floorCountFrame;
    self.forumLab.frame = self.topicFrame.forumFrame;
}

@end
