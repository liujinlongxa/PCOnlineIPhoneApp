//
//  LJUrlHeader.h
//  Project_PCOnline
//
//  Created by mac on 14-12-1.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#ifndef Project_PCOnline_LJUrlHeader_h
#define Project_PCOnline_LJUrlHeader_h

//资讯
#define kNewsUrl @"http://mrobot.pconline.com.cn/v2/cms/channels/%@?pageNo=%d&pageSize=20"
#define kNewsDetailUrl @"http://mrobot.pconline.com.cn/v3/cms/articles/%@?articleTemplate=3.6.0&size=18&picRule=2&app=pconlinebrowser&template=(null)&channelId=0&serialId=0"

//频道和区域列表
#define kChannelAndAreaUrl @"http://mrobot.pconline.com.cn/configs/pconline_v4_cms_iphone_channel_tree"

//论坛列表
#define kBBSListUrl @"http://mrobot.pconline.com.cn/configs/pconline_v4_bbs_forum_tree"

//论坛
//1.广告
#define kBBSAdsUrl @"http://www.pconline.com.cn/app/bbs/focus/"
//2.每日热帖
#define kBBSHotTopicUrl @"http://itbbs.pconline.com.cn/mobile/topics.ajax?type=hot_day&forums=8,2,240024,41,240022&singleForum=false&noForums=762423,2312647&ie=utf-8&count=%d&showImage=false"
//3.热门板块
#define kBBSHotForumsUrl @"http://www.pconline.com.cn/app/nq/1405/intf5401.js"
//4.论坛列表详情
//4.1 最新数码论坛
#define kZuiBBSDetailUrl @"http://piebbs.pconline.com.cn/mobile/topics.ajax?type=hot_week&forums=2&singleForum=false&noForums=22&ie=utf-8&count=100&showImage=true"
//4.2 其他论坛
#define kBBSDetailUrl @"http://itbbs.pconline.com.cn/mobile/topics.ajax?type=hot_week&forums=%d&singleForum=false&noForums=&ie=utf-8&count=100&showImage=true"
//4.3 家电论坛
#define kAppliancesBBSDetailUrl @"http://mrobot.pconline.com.cn/v3/itbbs/newForums/%d?orderby=replyat&pageNo=1&pageSize=20"
//5.1 帖子详情
#define kBBSTopicDetailUrl @"http://mrobot.pconline.com.cn/v2/itbbs/topics/%d?pageNo=1&picRule=2&authorId=0&topicTemplate=3.6.0&app=pconlinebrowser&appVersion=3.10.0&size=18"
//5.2 最数码论坛帖子详情
#define kZuiBBSTopicDetailUrl @"http://mrobot.pconline.com.cn/v2/piebbs/topics/%d?pageNo=1&picRule=2&authorId=0&topicTemplate=3.6.0&app=pconlinebrowser&appVersion=3.10.0&size=18"
//6 快速论坛
//6.1 快速论坛列表
#define kFastForumDetailUrl @"http://itbbs.pconline.com.cn/mobile/topics.ajax?type=hot_week&forums=%@&singleForum=false&noForums=&ie=utf-8&count=20&showImage=true"
//6.2 最数码论坛列表
#define kZuiFastForumDetaiUrl @"http://piebbs.pconline.com.cn/mobile/topics.ajax?singleForum=false&ie=utf-8&count=20&showImage=true&type=hot_week&forums=%@&noForums=22"
//7 论坛子版块
//7.1 获取子版块帖子列表
#define kSubForumTopicListUrl @"http://mrobot.pconline.com.cn/v3/itbbs/newForums/%d?&pageNo=1&pageSize=20&orderby=%@"
//7.2 最数码子版块帖子列表
#define kZuiSunForumTopicListUrl @"http://mrobot.pconline.com.cn/v2/piebbs/forums/%d?&pageNo=1&pageSize=20&orderby=%@"
//7.3 精华帖子列表
#define kEssenceTopicListUrl @"http://mrobot.pconline.com.cn/v3/itbbs/newForums/%d?filter=pick&pageNo=1&pageSize=20"
//7.4 最数码精华帖子列表
#define kZuiEssenceTopicListUrl @"http://mrobot.pconline.com.cn/v2/piebbs/forums/%d?pageNo=1&filter=pick&pageSize=20"


//找产品
//1.产品子分类列表
#define kProductCategoryNameUrl @"http://mrobot.pconline.com.cn/v3/product/brandNameTopv36"
//2.品牌列表
#define kBrandListUrl @"http://mrobot.pconline.com.cn/v3/product/brand/%@"
//3.具体品牌产品列表
#define kProductListUrl @"http://mrobot.pconline.com.cn/v3/product/types/%@?pageNo=%d&orderId=%d&fmt=json&brandId=%d"
//4.具体产品详情
//4.1参数Tab
#define kProductDetailDetailUrl @"http://mrobot.pconline.com.cn/v3/product/detail/%d"
//4.2概述Tab
#define kProductDetailSummaryUrl @"http://mrobot.pconline.com.cn/v3/product/summary/%d"
//4.3报价Tab
#define kProductDetailPriceUrl @"http://mrobot.pconline.com.cn/v3/product/comparePrice/%d"
//4.4资讯Tab
#define kProductDetailInformationUrl @"http://mrobot.pconline.com.cn/v3/product/information/%d?pageSize=20&pageNo=1"
//4.5点评Tab
#define kProductDetailCommentUrl @"http://mrobot.pconline.com.cn/v3/product/comments/%d"
//5产品对比
#define kProductDetailCompareUrl @"http://mrobot.pconline.com.cn/v3/product/detailComparev33?id1=%d&id2=%d"

//图赏
#define kPhotoUrl @"http://agent1.pconline.com.cn:8941/photolib/iphone_cate_json.jsp?id=%@"

//常量字符串
//找产品
#define kProductTypeKey @"ProductType"

#endif
