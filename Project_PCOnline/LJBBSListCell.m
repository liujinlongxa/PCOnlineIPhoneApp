//
//  LJBBSListCell.m
//  Project_PCOnline
//
//  Created by liujinlong on 14/12/3.
//  Copyright (c) 2014年 com.qianfeng. All rights reserved.
//

#import "LJBBSListCell.h"
#import "UIImageView+WebCache.h"

@interface LJBBSListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@end

@implementation LJBBSListCell

- (void)setBbsList:(LJBBSList *)bbsList
{
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:bbsList.listItem.imageUrl] placeholderImage:[UIImage imageNamed:@"common_default_48x48"]];
    self.nameLabel.text = bbsList.listItem.title;
}

@end
