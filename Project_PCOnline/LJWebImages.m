//
//  LJWebImages.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/13.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJWebImages.h"
#import "LJWebImageItem.h"

@implementation LJWebImages

+ (instancetype)webImages:(NSDictionary *)dict
{
    LJWebImages * images = [[self alloc] init];
    [images setValuesForKeysWithDictionary:dict];
    return  images;
}

+ (instancetype)webImagesWithImageItems:(NSArray *)items andCurIndex:(NSInteger)index
{
    LJWebImages * images = [[self alloc] init];
    
    images.currentIndex = [NSString stringWithFormat:@"%d", index];
    images.total = [NSString stringWithFormat:@"%d", items.count];
    
    NSMutableArray * arr = [NSMutableArray array];
    for (LJWebImageItem * item in items) {
        [arr addObject:item.bigPath];
    }
    images.photos = [arr copy];
    return images;
}

@end
