//
//  LJBaseCustomView.h
//  Project_PCOnline
//
//  Created by mac on 14-12-3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@class LJBaseCustomTableView;

@protocol LJCustomTableViewDelegate <NSObject>

-(void)customTableView:(LJBaseCustomTableView *)tableView didSelectCellWithObject:(id)object;

@end

@interface LJBaseCustomTableView : UITableView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<LJCustomTableViewDelegate> customDelegate;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign, getter=isRefresh) BOOL Refresh;

- (void)showData;
- (void)beginRefresh;
@end
