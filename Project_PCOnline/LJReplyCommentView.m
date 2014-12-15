//
//  LJReplyCommentView.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJReplyCommentView.h"
#import "LJCommonHeader.h"

@interface LJReplyCommentView ()

@property (nonatomic, weak) UILabel * floorLab;
@property (nonatomic, weak) UILabel * nameLab;
@property (nonatomic, weak) UILabel * contentLab;

@end

@implementation LJReplyCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = LightGrayBGColor;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 1;
        
        //name lab
        UILabel * nameLab = [[UILabel alloc] init];
        [self addSubview:nameLab];
        self.nameLab = nameLab;
        self.nameLab.font = ReplySmallLightFont;
        self.nameLab.textColor = [UIColor grayColor];
        
        //floor Lab
        UILabel * floorLab = [[UILabel alloc] init];
        [self addSubview:floorLab];
        self.floorLab = floorLab;
        self.floorLab.font = ReplySmallLightFont;
        self.floorLab.textColor = [UIColor grayColor];
        self.floorLab.textAlignment = NSTextAlignmentRight;
        
        
        //content lab
        UILabel * contentLab = [[UILabel alloc] init];
        [self addSubview:contentLab];
        self.contentLab = contentLab;
        self.contentLab.font = ReplyContentFont;
        self.contentLab.numberOfLines = 0;
        
    }
    return self;
}

- (void)setItemFrame:(LJCommentItemFrame *)itemFrame
{
    _itemFrame = itemFrame;
    [self setupData];
    [self setupFrame];
}

- (void)setupData
{
    self.floorLab.text = [NSString stringWithFormat:@"%@楼", self.itemFrame.item.floor];
    self.nameLab.text = self.itemFrame.item.name;
    self.contentLab.text = self.itemFrame.item.content;
}

- (void)setupFrame
{
    self.floorLab.frame = self.itemFrame.floorFrame;
    self.nameLab.frame = self.itemFrame.nameFrame;
    self.contentLab.frame = self.itemFrame.contentFrame;
}

@end
