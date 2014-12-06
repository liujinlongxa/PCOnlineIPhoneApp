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

//模型
#import "LJHotTopic.h"
#import "LJHotTopicFrame.h"
#import "LJTopic.h"
#import "LJTopicFrame.h"

@interface LJHotTopicCell ()
@property (weak, nonatomic) UILabel *titleLab;
@property (weak, nonatomic) UIImageView *image;
@property (weak, nonatomic) UILabel *messageLab;
@property (weak, nonatomic) UILabel *forumLab;
@property (weak, nonatomic) UILabel *floorCountLab;
@property (weak, nonatomic) LJContentView * myContentView;
@property (weak, nonatomic) UILabel * iconLab;
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
        
        //icon image (热门帖子没有)
        UILabel * iconLab = [[UILabel alloc] init];
        [self.myContentView addSubview:iconLab];
        self.iconLab = iconLab;
        self.iconLab.text = @"精华";
        self.iconLab.backgroundColor = RGBColor(203, 40, 48);
        self.iconLab.textColor = [UIColor whiteColor];
        self.iconLab.font = TopicFloorCountFont;
        self.iconLab.hidden = YES;
        self.iconLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

- (void)setTopicFrame:(LJBaseTopicFrame *)topicFrame
{
    _topicFrame = topicFrame;
    [self setupData];
    [self setupFrame];
}

- (void)setupData
{
    //共通
    self.titleLab.text = self.topicFrame.topic.title;
    self.messageLab.text = self.topicFrame.topic.message;
    if (self.topicFrame.topic.isShowImage)
    {
        [self.image sd_setImageWithURL:[NSURL URLWithString:self.topicFrame.topic.image] placeholderImage:[UIImage imageNamed:@"common_default_320x165"]];
    }
    
    LJBaseTopic * topic = self.topicFrame.topic;
    assert([topic isKindOfClass:[LJHotTopic class]] || [topic isKindOfClass:[LJTopic class]]);
    //热门帖子
    if ([topic isKindOfClass:[LJHotTopic class]])
    {
        LJHotTopic * hotTopic = (LJHotTopic *)topic;
        self.forumLab.text = hotTopic.forumName;
        self.floorCountLab.text = [NSString stringWithFormat:@"%d楼/%d阅", hotTopic.replyCount.integerValue, hotTopic.viewCount.integerValue];
    }
    else //普通帖子
    {
        LJTopic * normalTopic = (LJTopic *)topic;
        self.forumLab.text = normalTopic.createAtStr;
        self.floorCountLab.text = [NSString stringWithFormat:@"%d楼/%d阅", normalTopic.replyCount.integerValue, normalTopic.view.integerValue];
        self.iconLab.hidden = !normalTopic.isEssence;
    }
    
}

- (void)setupFrame
{
    self.myContentView.frame = self.topicFrame.contentFrame;
    self.titleLab.frame = self.topicFrame.titleFrame;
    self.messageLab.frame = self.topicFrame.messageFrame;
    self.image.frame = self.topicFrame.imageFrame;
    self.floorCountLab.frame = self.topicFrame.floorCountFrame;
    self.forumLab.frame = self.topicFrame.forumOrTimeFrame;
    if ([self.topicFrame isKindOfClass:[LJTopicFrame class]])
    {
        LJTopicFrame * normalTopicFrame = (LJTopicFrame *)self.topicFrame;
        self.iconLab.frame = normalTopicFrame.essenceFrame;
    }
}

@end
