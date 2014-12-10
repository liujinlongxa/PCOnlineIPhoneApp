//
//  LJSearchBar.h
//  Project_PCOnline
//
//  Created by mac on 14-12-9.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJSearchBar;

@protocol LJSearchBarDelegate <NSObject>

- (void)searchBar:(LJSearchBar *)bar didClickSelectBtn:(UIButton *)button;
- (void)searchBar:(LJSearchBar *)bar didClickSearchBtn:(UIButton *)button;

@end

@interface LJSearchBar : UIView

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles;

@property (nonatomic, assign, readonly) NSInteger selectIndex;
@property (nonatomic, weak) id<LJSearchBarDelegate> delegate;
@property (nonatomic, weak, readonly) UIButton * selectButton;
@property (nonatomic, weak) UITextField * textField;

@end
