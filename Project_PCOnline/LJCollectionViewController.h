//
//  LJCollectionViewController.h
//  Project_PCOnline
//
//  Created by liujinlong on 15/1/2.
//  Copyright (c) 2015年 com.qianfeng. All rights reserved.
//

#import "LJScrollTabViewController.h"
#import "LJArticleCollectionTVC.h"
#import "LJBBSCollectionTVC.h"
#import "LJTopicCollectionTVC.h"

@interface LJCollectionViewController : LJScrollTabViewController<LJArticleCollectionTVCDelegate, LJTopicCollectionTVCDelegate, LJBBSCollectionTVCDelegate>

+ (instancetype)collectionViewControllerWithControllers:(NSArray *)controllers andTitles:(NSArray *)titles;

@end
