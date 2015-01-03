//
//  LJArticleCollectionTVC.h
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJArticleDaoModel.h"

@class LJArticleCollectionTVC;

@protocol LJArticleCollectionTVCDelegate <NSObject>

@optional
- (void)articleCollectionTVC:(LJArticleCollectionTVC *)articleCollTVC didSelectArticle:(LJArticleDaoModel *)article;

@end


@interface LJArticleCollectionTVC : UITableViewController

@property (nonatomic, weak) id<LJArticleCollectionTVCDelegate> delegate;

@end
