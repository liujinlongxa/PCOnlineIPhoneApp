//
//  LJCommentTableViewCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommentTableViewCell.h"
#import "UIImage+MyImage.h"
#import "LJCommonHeader.h"
#import "LJReplyCommentView.h"

@interface LJCommentTableViewCell ()

@property (nonatomic, weak) UIImageView * iconImage;
@property (nonatomic, weak) UILabel * nameLab;
@property (nonatomic, weak) UILabel * floorLab;
@property (nonatomic, strong) NSArray * replyContentViews;
@property (nonatomic, weak) UILabel * contentLab;
@property (nonatomic, weak) UILabel * timeLab;
@property (nonatomic, weak) UIButton * supportBtn;
@property (nonatomic, weak) UIButton * replyBtn;

@end

@implementation LJCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //iconImage
        UIImageView * iconImage = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImage];
        self.iconImage = iconImage;
        self.iconImage.image = [UIImage imageNamed:@"bg_comment_icon_mobile"];
        
        //name label
        UILabel * nameLab = [[UILabel alloc] init];
        [self.contentView addSubview:nameLab];
        self.nameLab = nameLab;
        self.nameLab.font = SmallLightFont;
        self.nameLab.textColor = [UIColor grayColor];
        
        //floor label
        UILabel * floorLab = [[UILabel alloc] init];
        [self.contentView addSubview:floorLab];
        self.floorLab = floorLab;
        self.floorLab.font = SmallLightFont;
        self.floorLab.textColor = [UIColor grayColor];
        self.floorLab.textAlignment = NSTextAlignmentRight;
        
        //replyContenViews
        
        //content Label
        UILabel * contentLab = [[UILabel alloc] init];
        [self.contentView addSubview:contentLab];
        self.contentLab = contentLab;
        self.contentLab.font = ContentFont;
        self.contentLab.numberOfLines = 0;
        
        //time lab
        UILabel * timeLab = [[UILabel alloc] init];
        [self.contentView addSubview:timeLab];
        self.timeLab = timeLab;
        self.timeLab.font = SmallLightFont;
        self.timeLab.textColor = [UIColor grayColor];
        
        //support button
        UIButton * supportBtn = [[UIButton alloc] init];
        [self.contentView addSubview:supportBtn];
        self.supportBtn = supportBtn;
        [self.supportBtn setImage:[UIImage imageWithNameNoRender:@"btn_comment_supportfloor"] forState:UIControlStateNormal];
        [self.supportBtn setTitleColor:BlueTextColor forState:UIControlStateNormal];
        self.supportBtn.titleLabel.font = ButtonTitleFont;
        
        //reply button
        UIButton * replyButton = [[UIButton alloc] init];
        [self.contentView addSubview:replyButton];
        self.replyBtn = replyButton;
        [self.replyBtn setImage:[UIImage imageWithNameNoRender:@"btn_comment_replyfloor"] forState:UIControlStateNormal];
        [self.replyBtn setTitle:@"回复" forState:UIControlStateNormal];
        [self.replyBtn setTitleColor:BlueTextColor forState:UIControlStateNormal];
        self.replyBtn.titleLabel.font = ButtonTitleFont;
        
    }
    return self;
}

- (void)setCommentFrame:(LJCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    [self setupData];
    [self setupFrame];
}

- (void)setupData
{
    self.nameLab.text = self.commentFrame.comment.myCommentItem.name;
    self.floorLab.text = [NSString stringWithFormat:@"%@楼",  self.commentFrame.comment.myCommentItem.floor];
    self.contentLab.text = self.commentFrame.comment.myCommentItem.content;
    self.timeLab.text = self.commentFrame.comment.myCommentItem.time;
    [self.supportBtn setTitle:self.commentFrame.comment.support forState:UIControlStateNormal];
}

- (void)setupFrame
{
    self.iconImage.frame = self.commentFrame.phoneIconFrame;
    self.nameLab.frame = self.commentFrame.nameFrame;
    self.floorLab.frame = self.commentFrame.floorFrame;
    self.contentLab.frame = self.commentFrame.contentFrame;
    self.timeLab.frame = self.commentFrame.timeFrame;
    self.supportBtn.frame = self.commentFrame.supportFrame;
    self.replyBtn.frame = self.commentFrame.replyBtnFrame;
    
    //删除之前的品论view，否则会有重用问题
    for (UIView * view in self.contentView.subviews) {
        if ([view isKindOfClass:[LJReplyCommentView class]])
        {
            [view removeFromSuperview];
        }
    }
    for (LJCommentItemFrame * itemFrame in self.commentFrame.replyContentFrame) {
        LJReplyCommentView * replyView = [[LJReplyCommentView alloc] initWithFrame:itemFrame.viewFrame];
        replyView.itemFrame = itemFrame;
        [self.contentView addSubview:replyView];
        [self.contentView sendSubviewToBack:replyView];
    }
    
}

@end
