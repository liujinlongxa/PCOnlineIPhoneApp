//
//  LJFullScreenBrandCell.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/7.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBrand.h"

@interface LJFullScreenBrandCell : UITableViewCell

@property (nonatomic, strong) LJBrand * leftBrand;
@property (nonatomic, strong) LJBrand * rightBrand;

@property (nonatomic, copy) void (^SelectBrandBlock)(LJBrand* brand);

@end
