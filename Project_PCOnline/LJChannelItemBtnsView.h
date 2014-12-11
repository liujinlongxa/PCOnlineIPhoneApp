//
//  LJChannelItemBtnsView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-11.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJChannelItemBtn.h"
#define kBottomBlankH 40

@interface LJChannelItemBtnsView : UIView

- (instancetype)initWithFrame:(CGRect)frame andButttons:(NSArray *)buttons andTitles:(NSString *)title;
- (void)removeButton:(LJChannelItemBtn *)button;
- (void)addButton:(LJChannelItemBtn *)button;

@property (nonatomic, strong) NSMutableArray * buttons;
@property (nonatomic, weak) UILabel * titleLabel;
@property (nonatomic, assign, getter=isCanDragToMove) BOOL canDragToMove;

@end
