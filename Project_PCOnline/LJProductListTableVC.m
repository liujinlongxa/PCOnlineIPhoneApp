//
//  LJProductListTableVC.m
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJProductListTableVC.h"
#import "LJProduct.h"
#import "LJNetWorking.h"

typedef enum : NSUInteger {
    LJProductSortByHot = 1,
    LJProductSortByPriceHigh = 3,
    LJProductSortByPriceLow,
    LJProductSortByDate
} LJProductSort;

@interface LJProductListTableVC ()

@property (nonatomic, strong) NSMutableArray * productListData;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) LJProductSort curSortType;
@end

@implementation LJProductListTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curPage = 1;
    self.curSortType = LJProductSortByHot;
}

#pragma mark - 加载数据
- (NSMutableArray *)productListData
{
    if (!_productListData) {
        _productListData = [NSMutableArray array];
    }
    return _productListData;
}

- (void)loadProductListData
{
    NSString * productType = [[LJCommonData shareCommonData] loadObjcForKey:ProductTypeKey];
    NSString * urlStr = [NSString stringWithFormat:kProductListUrl, productType, self.curPage, self.curSortType, [self.brand.ID integerValue]];
    [LJNetWorking GET:urlStr parameters:nil success:^(NSHTTPURLResponse *response, id responseObject) {
        
    } failure:^(NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}
@end
