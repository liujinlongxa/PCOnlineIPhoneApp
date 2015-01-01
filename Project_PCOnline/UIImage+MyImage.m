//
//  UIImage+MyImage.m
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "UIImage+MyImage.h"

@implementation UIImage (MyImage)

/**
 *  返回一张没有经过系统渲染的图片
 *
 *  @param imageName 图片名
 *
 *  @return 创建好的UIImage
 */
+ (instancetype)imageWithNameNoRender:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  使用UIColor创建一个纯色的UIImage
 *
 *  @param color 颜色
 *
 *  @return 创建好的UIImage
 */
+ (instancetype)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
