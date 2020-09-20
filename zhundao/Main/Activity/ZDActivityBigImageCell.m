//
//  ZDActivityBigImageCell.m
//  zhundao
//
//  Created by zhundao on 2017/10/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ZDActivityBigImageCell.h"

@implementation ZDActivityBigImageCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bigImageView];
        
    }
    return self;
}


- (UIImageView *)bigImageView{
    if (!_bigImageView) {
        _bigImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    }
    return _bigImageView;
}

- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:_imageStr]];
}




@end
