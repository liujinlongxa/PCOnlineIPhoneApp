//
//  LJArticleDaoModel.h
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/3.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJArticleDaoModel : NSObject

/**
 *  文章ID
 */
@property (nonatomic, strong) NSNumber * articleId;

/**
 *  标题
 */
@property (nonatomic, copy) NSString * title;

@end
