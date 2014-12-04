//
//  UIImage+MyImage.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyImage)

//返回没有渲染的图盘
+ (instancetype)imageWithNameNoRender:(NSString *)imageName;
+(UIImage *)imageWithColor:(UIColor *)color;
@end
