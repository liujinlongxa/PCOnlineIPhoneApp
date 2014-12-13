//
//  LJContentView.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJContentView.h"
#import "LJCommonHeader.h"

@implementation LJContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 1;
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor whiteColor];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch * touch = [touches anyObject];
    NSArray * gestures = touch.gestureRecognizers;
    UIGestureRecognizer * firstGesture = [gestures firstObject];
    if (gestures.count == 0 || [firstGesture isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        self.backgroundColor = CellSelectBGColor;
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor whiteColor];
    [super touchesEnded:touches withEvent:event];
}

@end
