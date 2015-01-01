//
//  UIImage+MyImage.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyImage)

/**
 *  返回一张没有经过系统渲染的图片
 *
 *  @param imageName 图片名
 *
 *  @return 创建好的UIImage
 */
+ (instancetype)imageWithNameNoRender:(NSString *)imageName;

/**
 *  使用UIColor创建一个纯色的UIImage
 *
 *  @param color 颜色
 *
 *  @return 创建好的UIImage
 */
+ (instancetype)imageWithColor:(UIColor *)color;
@end
