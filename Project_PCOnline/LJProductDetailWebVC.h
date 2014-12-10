//
//  LJProductDetailWebVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJProductDetailScrollTabVC.h"

typedef enum : NSUInteger {
    LJProductWebVCTypeSummary,
    LJProductWebVCTypeDetail,
    LJProductWebVCTypePrice,
    LJProductWebVCTypeComment
} LJProductWebVCType;

@interface LJProductDetailWebVC : UIViewController

@property (nonatomic, strong) LJProduct * product;
@property (nonatomic, copy) NSString * productID;
- (instancetype)initWithType:(LJProductWebVCType)type;

@end
