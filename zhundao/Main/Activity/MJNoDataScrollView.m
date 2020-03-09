//
//  MJNoDataScrollView.m
//  zhundao
//
//  Created by zhundao on 2017/8/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MJNoDataScrollView.h"

@interface MJNoDataScrollView()

/*! 顶部图片 */
@property(nonatomic,strong)UIImageView *topImageView ;
/*! 第一行的label */
@property(nonatomic,strong)UILabel     *topLabel ;
/*! 第二行的label */
@property(nonatomic,strong)UILabel     *bottomLabel;
/*! 图片的字符串 */
@property(nonatomic,copy)NSString      *imageName;
/*! 顶部的字符串 */
@property(nonatomic,copy)NSString      *topText;
/*! 底部的字符串 */
@property(nonatomic,copy)NSString      *bottomText;
/*! 视图中心 x */
@property(nonatomic,assign)float       centerX ;
/*! 视图中心 y */
@property(nonatomic,assign)float       centerY;


@end
@implementation MJNoDataScrollView


- (instancetype)initWithFrame:(CGRect)frame
                   imageName :(NSString *)imageName
                     topText :(NSString *) topText
                  bottomText :(NSString *) bottomText{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ZDBackgroundColor;
        self.showsVerticalScrollIndicator = NO;
        self.contentSize = CGSizeMake(kScreenWidth, kScreenHeight-63.9);
        _imageName = imageName ;
        _bottomText = bottomText;
        _topText = topText;
        [self addSubview:self.topImageView];
        /*! 如果存在第二行字符串 则创建label */
        if (bottomText) {
             [self addSubview:self.bottomLabel];
        }
        [self addSubview:self.topLabel];
    }
    return self;
}



#pragma mark ------  懒加载

- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _topImageView.image = [UIImage imageNamed:_imageName];
    }
    return  _topImageView;
}

- (UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _topLabel.text = _topText;
        _topLabel.font = KHeitiSCMedium(15);
        _topLabel.textColor = ZDHeaderTitleColor;
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
}

- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _bottomLabel.text = _bottomText;
        _bottomLabel.font = KHeitiSCMedium(15);
        _bottomLabel.textColor = ZDHeaderTitleColor;
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLabel;
}


-(void)layoutSubviews{
    if (_topLabel) {
        _topImageView.frame = CGRectMake(self.centerX - 60, self.centerY - 120, 120, 120);
        _topLabel.frame = CGRectMake(0, self.centerY  , kScreenWidth, 30);
        _bottomLabel.frame = CGRectMake(0, self.centerY +30, kScreenWidth, 30);
    }
}
- (void)setData  :(NSString *)imageName
         topText :(NSString *) topText
      bottomText :(NSString *) bottomText{
            _topImageView.image = [UIImage imageNamed:imageName];
            _topLabel.text = topText;
            _bottomLabel.text = bottomText;
}
#pragma mark 手势添加 
/*! 第一种 */
/*!  点击屏幕加载 */

- (void)addGesToScreenWithBlock :(SEL)reloadSEL{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:reloadSEL];
    [self addGestureRecognizer:tap];
}
#pragma mark ----- 获取x y

- (float)centerX{
    return self.center.x;
}
- (void)setCenterX:(float)centerX{
    self.centerX = centerX;
}
- (float)centerY{
    return self.center.y;
}
- (void)setCenterY:(float)centerY{
    self.centerY = centerY;
}
#pragma mark 移除视图

- (void)removeNoDataView{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
