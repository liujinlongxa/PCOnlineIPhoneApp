//
//  LJCollectionButton.h
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJCollectionButton : UIButton

/**
 *  设置Button的选中状态，并设置是否显示动画
 *
 *  @param selected  选中状态
 *  @param animation 是否播放动画
 */
- (void)setSelected:(BOOL)selected withAnimation:(BOOL)animation;

@end
