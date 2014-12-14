//
//  LJWebImageGridViewerCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/14.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJWebImageGridViewerCell.h"
#import "UIImageView+WebCache.h"

@interface LJWebImageGridViewerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;


@end

@implementation LJWebImageGridViewerCell

- (void)setItem:(LJWebImageItem *)item
{
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:item.smallPath] placeholderImage:[UIImage imageNamed:@"common_default_88x66"]];
}
@end
