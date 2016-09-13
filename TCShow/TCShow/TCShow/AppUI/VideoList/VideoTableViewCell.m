//
//  VideoTableViewCell.m
//  TCShow
//
//  Created by cmri on 16/9/7.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "VideoTableViewCell.h"

@implementation VideoTableViewCell
@synthesize coverImage;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSString *path = @"http://videocover-10061035.cos.myqcloud.com/timg.jpeg";
    
    NSURL *url = [NSURL URLWithString:path];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    coverImage.image = [UIImage imageWithData: imageData];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
