//
//  LJBrandTableVC.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJProductSubCategory.h"
#import "LJCommonHeader.h"
#import "LJUrlHeader.h"
#import "LJCommonData.h"
#import "LJBrand.h"

@class LJBrandTableVC;

@protocol LJBrandTableVCDelegate <NSObject>

@optional
- (void)brandTableVC:(LJBrandTableVC *)tableVC didSelectBrand:(LJBrand *)brand;

@end

@interface LJBrandTableVC : UITableViewController

@property (nonatomic, strong) LJProductSubCategory * subCategory;
@property (nonatomic, weak) id<LJBrandTableVCDelegate> delegate;
@end
