//
//  LJNewsSearchGroupView.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/10.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJNewsSearchGroupView : UIView

@property (nonatomic, strong) NSArray * newsItems;

- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items andClickActionBlock:(void (^)(NSInteger clickIndex))actionBlock;

@end
