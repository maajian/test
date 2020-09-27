#import "PGAvtivityInviteCollectionViewCell.h"
@implementation PGAvtivityInviteCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
    }
    return self;
}
- (void)setCurrentImage:(UIImage *)currentImage{
    if (currentImage) {
        _imageView.image = currentImage;
    }
    UIImageView *imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(100, 5, 100, 100)];
    imageView.image = currentImage;
    [self.contentView addSubview:imageView];
}
- (UIImageView *)imageView{
    _imageView = [[UIImageView alloc]init];
    return _imageView;
}
- (void)layoutSubviews{
    if (_imageView) {
        _imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-40);
    }
}
@end
