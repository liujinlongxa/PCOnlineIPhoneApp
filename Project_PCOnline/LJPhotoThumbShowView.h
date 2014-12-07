//
//  LJPhotoThumbShowView.h
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/8.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJPhotoThumbShowView : UICollectionView

- initWithPhotos:(NSArray *)photos andSelectActionBlock:(void (^)(NSInteger index))selectBlock;

@end
