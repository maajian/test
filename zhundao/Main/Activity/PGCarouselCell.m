#import "PGCarouselCell.h"
@implementation PGCarouselCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
    }
    return self;
}
- (void)setCurrentImage:(NSString *)currentImage{
    if (currentImage) {
        NSString *path = [[NSBundle mainBundle]pathForResource:currentImage ofType:nil];
        _imageView.image = [UIImage imageWithContentsOfFile:path];
    }
}
- (void)setCurrentLabelStr:(NSString *)currentLabelStr{
    if (currentLabelStr) {
        _label.text = currentLabelStr;
    }
}
- (UIImageView *)imageView{
    _imageView = [[UIImageView alloc]init];
    return _imageView;
}
- (UILabel *)label{
    _label = [[UILabel alloc]init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:18];
    return _label;
}
- (void)layoutSubviews{
    if (_label) {
        _imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
        _label.center = _imageView.center;
        _label.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    }
}
@end
