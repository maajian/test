#import "PGPortraitUpsideDown.h"
#import "PGNoDataScrollView.h"
@interface PGNoDataScrollView()
@property(nonatomic,strong)UIImageView *topImageView ;
@property(nonatomic,strong)UILabel     *topLabel ;
@property(nonatomic,strong)UILabel     *bottomLabel;
@property(nonatomic,copy)NSString      *imageName;
@property(nonatomic,copy)NSString      *topText;
@property(nonatomic,copy)NSString      *bottomText;
@property(nonatomic,assign)float       centerX ;
@property(nonatomic,assign)float       centerY;
@end
@implementation PGNoDataScrollView
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
@end
