//
//  LJProductInformationTVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJProductDetailScrollTabVC.h"
#import "LJProductInformation.h"
#import "LJProduct.h"
@class LJProductInformationTVC;

@protocol LJProductInformationTVCDelegate <NSObject>

@optional
- (void)productInformationTVC:(LJProductInformationTVC *)infoTVC didSelectInfo:(LJProductInformation *)info;

@end

@interface LJProductInformationTVC : UITableViewController

@property (nonatomic, strong) LJProduct * product;
@property (nonatomic, copy) NSString * productID;

@property (nonatomic, weak) id<LJProductInformationTVCDelegate> delegate;

@end
