//
//  InviteCollectionViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/8/30.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "InviteCollectionViewCell.h"

@implementation InviteCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
    }
    return self;
}
/*! 使用imageWithContentsOfFile ，不去缓存图片*/
- (void)setCurrentImage:(UIImage *)currentImage{
    if (currentImage) {
        _imageView.image = currentImage;
    }
    UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.image = currentImage;
    [self.contentView addSubview:imageView];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

- (void)layoutSubviews{
    if (_imageView) {
        _imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-40);
    }
}

@end
