//
//  LJCommentItemFrame.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommentItemFrame.h"
#import "NSString+MyString.h"
#import "LJCommonHeader.h"

@implementation LJCommentItemFrame

- (instancetype)initCommentItemFrameWithViewFrame:(CGRect)viewFrame
{
    if (self = [super init]) {
        self.viewFrame = viewFrame;
    }
    return self;
}

- (void)setItem:(LJCommentItem *)item
{
    _item = item;
    
    CGFloat padding = 10;
    CGFloat viewW = CGRectGetWidth(self.viewFrame);
    
    //name lab
    CGFloat nameX = padding;
    CGFloat nameY = padding + self.startY;
    CGFloat nameMaxW = 200;
    CGFloat nameMaxH = 30;
    CGSize nameSize = [self.item.name sizeOfStringInIOS7WithFont:ReplySmallLightFont andMaxSize:CGSizeMake(nameMaxW, nameMaxH)];
    self.nameFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    //floor
    CGFloat floorMaxW = 100;
    CGFloat floorMaxH = 30;
    NSString * floorStr = [NSString stringWithFormat:@"%@楼", self.item.floor];
    CGSize floorSize = [floorStr sizeOfStringInIOS7WithFont:ReplySmallLightFont andMaxSize:CGSizeMake(floorMaxW, floorMaxH)];
    CGFloat floorX = viewW - floorSize.width - padding;
    CGFloat floorY = nameY;
    self.floorFrame = CGRectMake(floorX, floorY, floorSize.width, floorSize.height);
    
    //content
    CGSize contentSize = [self.item.content sizeOfStringInIOS7WithFont:ReplyContentFont andMaxSize:CGSizeMake(viewW - 2 * padding, MAXFLOAT)];
    CGFloat contentX = padding;
    CGFloat contentY = MAX(CGRectGetMaxY(self.nameFrame), CGRectGetMaxY(self.floorFrame)) + padding;
    self.contentFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    //view heigh
    self.contentHeigh = CGRectGetMaxY(self.contentFrame) + padding;
}

@end
