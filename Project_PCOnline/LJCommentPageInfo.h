//
//  LJCommentPage.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/12.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJCommentPageInfo : NSObject

@property (nonatomic, copy) NSString * author;
@property (nonatomic, copy) NSString * firstPic;
@property (nonatomic, copy) NSString * guidePic;
@property (nonatomic, strong) NSNumber * pageCount;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSArray * pages;
@property (nonatomic, copy) NSString * preView;
@property (nonatomic, copy) NSString * pubDate;
@property (nonatomic, copy) NSString * summary;
@property (nonatomic, copy) NSString * thumbPic;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * wap_url;

//for bbs web view
@property (nonatomic, copy) NSString * favoriteId;
@property (nonatomic, copy) NSString * webUrl;
@property (nonatomic, strong) NSNumber * userId;
@property (nonatomic, copy) NSString * topicUrl;
+ (instancetype)commentPageWithDict:(NSDictionary *)dict;

@end
