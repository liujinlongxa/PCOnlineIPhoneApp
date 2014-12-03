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
#define kBBSHotTopicUrl @"http://itbbs.pconline.com.cn/mobile/topics.ajax?type=hot_day&forums=8,2,240024,41,240022&singleForum=false&noForums=762423,2312647&ie=utf-8&count=1&showImage=false"
//3.热门板块
#define kBBSHotForumsUrl @"http://www.pconline.com.cn/app/nq/1405/intf5401.js"

//找产品
//1.产品子列表
#define kProductCategoryNameUrl @"http://mrobot.pconline.com.cn/v3/product/brandNameTopv36"

//图赏
#define kPhotoUrl @"http://agent1.pconline.com.cn:8941/photolib/iphone_cate_json.jsp?id=%@"

#endif
