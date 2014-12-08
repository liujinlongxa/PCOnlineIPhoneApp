//
//  LJProductDetailScrollTabVC.h
//  Project_PCOnline
//
//  Created by mac on 14-12-8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJScrollTabViewController.h"
#import "LJProductInformationTVC.h"
#import "LJProductInformation.h"
#import "LJProduct.h"

@interface LJProductDetailScrollTabVC : LJScrollTabViewController

@property (nonatomic, strong) LJProduct * product;

+ (instancetype)productDetailScrollTabVCWithControllers:(NSArray *)controllers andTitles:(NSArray *)titles;

@end
