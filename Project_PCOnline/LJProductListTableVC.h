//
//  LJProductListTableVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJBrand.h"
#import "LJUrlHeader.h"
#import "LJCommonData.h"
#import "LJProductSubCategory.h"

@interface LJProductListTableVC : UIViewController

@property (nonatomic, strong) LJBrand * brand;
@property (nonatomic, strong) LJProductSubCategory * subCategory;
@end
