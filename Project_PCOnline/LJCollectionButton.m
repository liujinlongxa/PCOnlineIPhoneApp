//
//  LJCollectionButton.m
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LJCollectionButton.h"
#import "MBProgressHUD+LJProgressHUD.h"

#define kCollectionButtonAnimationKey @"CollectionButtonAnimationKey"

@implementation LJCollectionButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setImage:[UIImage imageNamed:@"btn_common_toolbar_collect"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"btn_common_toolbar_collected"] forState:UIControlStateSelected];
    }
    return self;
}

/**
 *  重写选中时的动作，添加动画
 */
- (void)setSelected:(BOOL)selected withAnimation:(BOOL)animation
{
    [super setSelected:selected];
    
    //添加动画
    if (animation) [self addAnimation];
}

/**
 *  添加动画
 */
- (void)addAnimation
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@(1), @(1.5), @(1)];
    animation.duration = 0.25;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:kCollectionButtonAnimationKey];
}

/**
 *  动画结束后删除动画
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        [self.layer removeAnimationForKey:kCollectionButtonAnimationKey];
    }
}

@end
