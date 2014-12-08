//
//  LJProductCompareManager.h
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJProduct.h"

typedef enum : NSUInteger {
    LJProductComparePositionLeft,
    LJProductComparePositionRight,
} LJProductComparePosition;

@interface LJProductCompareManager : NSObject

@property (nonatomic, strong, readonly) LJProduct * leftProduct;
@property (nonatomic, strong, readonly) LJProduct * rightProduct;
@property (nonatomic, assign, readonly, getter=isComparing) BOOL comparing;
@property (nonatomic, copy) NSString * productTypeIDStr;
+ (instancetype)manager;

- (void)addCompareProduct:(LJProduct *)product atPosition:(LJProductComparePosition)positon;
- (void)addCompareProduct:(LJProduct *)product;
- (void)removeCompareProductFromPositon:(LJProductComparePosition)positon;
- (void)closeCompare;
- (NSString *)compareUrlStr;


@end
