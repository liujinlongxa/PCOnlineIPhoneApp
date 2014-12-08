//
//  LJProductCompareManager.m
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductCompareManager.h"
#import "LJUrlHeader.h"
static LJProductCompareManager * manager;

@interface LJProductCompareManager ()

@property (nonatomic, strong) LJProduct * leftProduct;
@property (nonatomic, strong) LJProduct * rightProduct;
@property (nonatomic, assign, getter=isComparing) BOOL comparing;
@end

@implementation LJProductCompareManager

#pragma mark - 创建单例对象
+ (instancetype)manager
{
    if (!manager) {
        manager = [[LJProductCompareManager alloc] init];
    }
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!manager) {
        manager = [super allocWithZone:zone];
    }
    return manager;
}

#pragma mark - 接口实现
- (void)addCompareProduct:(LJProduct *)product atPosition:(LJProductComparePosition)positon
{
    if (positon == LJProductComparePositionLeft) {
        self.leftProduct = product;
    }
    else
    {
        self.rightProduct = product;
    }
    self.comparing = YES;
}

- (void)removeCompareProductFromPositon:(LJProductComparePosition)positon
{
    if (positon == LJProductComparePositionLeft) {
        self.leftProduct = nil;
    }
    else
    {
        self.rightProduct = nil;
    }
    if (self.leftProduct == nil && self.rightProduct == nil) {
        self.comparing = NO;
    }
}

- (void)addCompareProduct:(LJProduct *)product
{
    if (self.leftProduct == nil) {
        self.leftProduct = product;
    }
    else
    {
        self.rightProduct = product;
    }
}

- (void)closeCompare
{
    self.leftProduct = nil;
    self.rightProduct = nil;
    self.comparing = NO;
}

- (NSString *)compareUrlStr
{
    NSInteger leftProductID = self.leftProduct == nil ? 0 : self.leftProduct.ID.integerValue;
    NSInteger rightProductID = self.rightProduct == nil ? 0 : self.rightProduct.ID.integerValue;
    NSString * urlStr = [NSString stringWithFormat:kProductDetailCompareUrl, leftProductID, rightProductID];
    return urlStr;
}

@end
