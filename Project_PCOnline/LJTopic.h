//
//  LJTopic.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/6.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJBaseTopic.h"
#import "LJUser.h"
/**
 
 {
 author =     {
 name = tubieyihao;
 nickname = tubieyihao;
 userFace = "http://i7.3conline.com/images/upload/upc/face/42/35/56/94/42355694_120x120";
 userId = 42355694;
 };
 createAt = 1449034657681;
 flag = "\U56fe";
 floor = 2;
 image = "http://img.pconline.com.cn/images/upload/upc/tx/itbbs/1512/02/c22/15997266_1449034553884_240x180.jpg";
 imgUrls =     (
 "http://imgm.pconline.com.cn/images/upload/upc/tx/itbbs/1512/02/c22/15997266_1449034553884_240x180.jpg",
 "http://imgm.pconline.com.cn/images/upload/upc/tx/itbbs/1512/02/c22/15997379_1449034750114_240x180.jpg",
 "http://imgm.pconline.com.cn/images/upload/upc/tx/itbbs/1512/02/c22/15997422_1449034750862_240x180.jpg"
 );
 lastPostAt = 1449573461557;
 lastPoster =     {
 name = qz42424975;
 nickname = qz42424975;
 userFace = "http://i7.3conline.com/images/upload/upc/face/42/42/49/75/42424975_120x120";
 userId = 42424975;
 };
 message = "\U4e0d\U4e45\U524d\U5c0f\U7f16\U5728\U7528\U624b\U673a\U7f13\U5b58\U7535\U89c6\U5267\U7684\U65f6\U5019\U53d1\U73b0\U5185\U5b58\U4e0d\U591f\U4e86\Uff0c\U5728\U8fd9\U91cc\U4e0d\U5f97\U4e0d\U5410\U69fd\U4e00\U53e5\Uff1a16G\U7684\U5185\U5b58\U771f\U7684\U4e0d\U591f\U7528\U554a\Uff01\U53ea\U80fd\U5220\U6389\U4e00\U4e9b\U4e1c\U897f\U6765\U817e\U7a7a\U95f4\U3002\U7ea0\U7ed3\U4e86\U5f88\U4e45\U53d1\U73b0\U6709\U4e9bapp\U5b9e\U5728\U4e0d\U80fd\U5220\Uff0c\U4e8e\U662f\U6e05\U7406\U5404\U79cd\U7f13\U5b58\U6570\U636e\Uff0c\U5230\U6700\U540e\U6709\U4e9b\U7167\U7247\U77ed\U4fe1\U4e5f\U52a0\U5165\U4e86\U88ab\U5220\U7684\U9ed1\U540d\U5355\U3002\U4e00\U4e0d\U5c0f\U5fc3\U5c31\U5220\U5f97\U987a\U624b\U4e86...";
 replyCount = 0;
 title = "\U82f9\U679c\U624b\U673a\U7684\U77ed\U4fe1\U548c\U7167\U7247\U5220\U9664\U4e86\U600e\U4e48\U6062\U590d";
 topicId = 52610377;
 uri = "http://itbbs.pconline.com.cn/mobile/52610377.html";
 view = 64;
 }
 */
@interface LJTopic : LJBaseTopic

@property (nonatomic, strong) LJUser * author;
@property (nonatomic, strong) LJUser * lastPoster;
@property (nonatomic, copy) NSString * uri;
@property (nonatomic, copy) NSString * formatCreateAt;
@property (nonatomic, strong) NSNumber * view;
@property (nonatomic, strong) NSNumber * createAt;
@property (nonatomic, strong) NSString * flag;
@property (nonatomic, assign, getter=isEssence) BOOL essence;//是否是精华
@property (nonatomic, assign) long long lastPostAt;

//最数码
@property (nonatomic, strong) NSArray * imgUrls;
@property (nonatomic, assign) BOOL isContainImage;
@property (nonatomic, assign) BOOL isPick;
@property (nonatomic, assign) BOOL isForumTop;

+ (instancetype)topciWithDict:(NSDictionary *)dict;

@property (nonatomic, copy) NSString * createAtStr;

@end
