#import "PGActivityBigImageCell.h"
@implementation PGActivityBigImageCell
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
