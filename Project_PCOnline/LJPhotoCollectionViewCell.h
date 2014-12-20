//
//  LJPhotoCollectionViewCell.h
//  Project_PCOnline
//
//  Created by mac on 14-12-4.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJPhoto.h"

@interface LJPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) LJPhoto * photo;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@end
