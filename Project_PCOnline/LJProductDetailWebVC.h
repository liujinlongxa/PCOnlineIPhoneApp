//
//  LJProductDetailWebVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJProductDetailScrollTabVC.h"
#import "LJBaseWebViewController.h"
typedef enum : NSUInteger {
    LJProductWebVCTypeSummary,
    LJProductWebVCTypeDetail,
    LJProductWebVCTypePrice,
    LJProductWebVCTypeComment
} LJProductWebVCType;

@class LJProductDetailWebVC;

@protocol LJProductDetailWebVCCDelegate <NSObject>

@optional
- (void)productDetailWebVC:(LJProductDetailWebVC *)webVC didClickHttpLink:(NSString *)urlStr;

@end

@interface LJProductDetailWebVC : LJBaseWebViewController

@property (nonatomic, strong) LJProduct * product;
@property (nonatomic, copy) NSString * productID;
@property (nonatomic, weak) id<LJProductDetailWebVCCDelegate> delegate;

- (instancetype)initWithType:(LJProductWebVCType)type;

@end
