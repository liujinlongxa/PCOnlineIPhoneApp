//
//  LJSubProductCategoryTableVC.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJCommonHeader.h"
#import "LJProductSubCategory.h"

@class LJSubProductCategoryTableVC;

@protocol LJSubProductCategoryTableVCDelegate <NSObject>

@optional
- (void)SubProductCategoryTVC:(LJSubProductCategoryTableVC *)controller didSelectSubCategory:(LJProductSubCategory *)subCategory;

@end

@interface LJSubProductCategoryTableVC : UITableViewController

@property (nonatomic, strong) NSArray * subCategories;
@property (nonatomic, weak) id<LJSubProductCategoryTableVCDelegate> delegate;

@end
