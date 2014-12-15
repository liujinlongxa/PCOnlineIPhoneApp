//
//  LJCommentFrame.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/15.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJCommentFrame.h"
#import "LJCommonHeader.h"
#import "NSString+MyString.h"
#import "LJCommentItemFrame.h"

@implementation LJCommentFrame

- (void)setComment:(LJComment *)comment
{
    _comment = comment;
    
    CGFloat padding = 10;
    
    //phone icon
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = 7;
    CGFloat iconH = 10;
    self.phoneIconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //name Lab
    CGFloat nameMaxW = 200;
    CGFloat nameMaxH = 30;
    CGSize nameSize = [self.comment.myCommentItem.name sizeOfStringInIOS7WithFont:SmallLightFont andMaxSize:CGSizeMake(nameMaxW, nameMaxH)];
    CGFloat nameX = CGRectGetMaxX(self.phoneIconFrame) + padding;
    CGFloat nameY = iconY - (nameSize.height - iconH) / 2; //中心再一条线
    self.nameFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    //floor
    CGFloat floorMaxW = 50;
    CGFloat floorMaxH = 30;
    CGSize floorSize = [[NSString stringWithFormat:@"%@楼",self.comment.myCommentItem.floor] sizeOfStringInIOS7WithFont:SmallLightFont andMaxSize:CGSizeMake(floorMaxW, floorMaxH)];
    CGFloat floorX = kScrW - padding - floorSize.width;
    CGFloat floorY = nameY;
    self.floorFrame = CGRectMake(floorX, floorY, floorSize.width, floorSize.height);
    
    //reply
    CGFloat offset = 3;
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i < self.comment.replyCommentItems.count; i++) {
        LJCommentItem * replyItem = self.comment.replyCommentItems[i];
        CGFloat replyItemX = replyItem.level * offset + padding;
        CGFloat replyItemY = replyItem.level * offset + padding + CGRectGetMaxY(self.nameFrame);
        CGFloat replyItemW = kScrW - 2 * replyItemX;
        
        CGRect viewFrame = CGRectMake(replyItemX, replyItemY, replyItemW, 0);
        LJCommentItemFrame * replyItemFrame = [[LJCommentItemFrame alloc] initCommentItemFrameWithViewFrame:viewFrame];
        if (i == 0) {
            replyItemFrame.item = replyItem;
        }
        else
        {
            LJCommentItemFrame * preItemFrame = arr[i - 1];
            replyItemFrame.startY = preItemFrame.viewFrame.size.height;
            replyItemFrame.item = replyItem;
        }
        viewFrame.size.height = replyItemFrame.contentHeigh;
        replyItemFrame.viewFrame = viewFrame;
        
        
        [arr addObject:replyItemFrame];
    }
    self.replyContentFrame = [arr copy];
    
    //content
    CGFloat contentX = padding;
    CGFloat contentY = 0;
    if (self.replyContentFrame.count > 0)
    {
        LJCommentItemFrame * lastItemFrame = [self.replyContentFrame lastObject];
        contentY = CGRectGetMaxY(lastItemFrame.viewFrame) + padding;
    }
    else
    {
        contentY = CGRectGetMaxY(self.nameFrame) + padding;
    }
    CGSize contentSize = [self.comment.myCommentItem.content sizeOfStringInIOS7WithFont:ContentFont andMaxSize:CGSizeMake(kScrW - 2 * padding, MAXFLOAT)];
    self.contentFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    //time
    CGFloat timeX = padding;
    CGFloat timeY = CGRectGetMaxY(self.contentFrame) + padding;
    CGSize timeSize = [self.comment.myCommentItem.time sizeOfStringInIOS7WithFont:SmallLightFont andMaxSize:CGSizeMake(200, 30)];
    self.timeFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    //support button
    CGFloat supportW = 80;
    CGFloat supportH = 30;
    CGFloat supportX = 150;
    CGFloat supportY = timeY - (supportH - timeSize.height) / 2;
    self.supportFrame = CGRectMake(supportX, supportY, supportW, supportH);
    
    //reply button
    CGFloat replyW = 80;
    CGFloat replyH = 30;
    CGFloat replyX = kScrW - padding - replyW;
    CGFloat replyY = supportY;
    self.replyBtnFrame = CGRectMake(replyX, replyY, replyW, replyH);
    
    self.cellHeigh = MAX(CGRectGetMaxY(self.timeFrame), MAX(CGRectGetMaxY(self.supportFrame), CGRectGetMaxY(self.replyBtnFrame))) + padding;
}

@end
