#import "PGArticleContentModel.h"
#import "PGAvtivityMoreModalCell.h"
@interface PGAvtivityMoreModalCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *redView;
@end
@implementation PGAvtivityMoreModalCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self PG_setupUI];
        [self PG_initLayout];
    }
    return self;
}
#pragma mark --- lazyload
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.font = [UIFont systemFontOfSize:12 weight:(UIFontWeightThin)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
   return _titleLabel;
}
- (UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
        _redView.layer.cornerRadius = 4;
        _redView.layer.masksToBounds = YES;
        _redView.hidden = YES;
    }
    return _redView;
}
#pragma mark --- UI
- (void)PG_setupUI {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.redView];
}
#pragma mark --- 布局
- (void)PG_initLayout {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.bottom.equalTo(self.contentView.mas_centerY).offset(0);
        make.centerX.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(10);
        make.leading.trailing.mas_equalTo(0);
    }];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(-5);
        make.bottom.equalTo(self.imageView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];
}
#pragma mark --- setter
- (void)setModel:(PGAvtivityMoreModalModel *)model {
dispatch_async(dispatch_get_main_queue(), ^{
    UIView *filterManagerDelegateq4= [[UIView alloc] initWithFrame:CGRectMake(225,153,173,251)]; 
    filterManagerDelegateq4.backgroundColor = [UIColor whiteColor]; 
    filterManagerDelegateq4.layer.cornerRadius = 
    filterManagerDelegateq4.layer.masksToBounds = YES; 
        CGSize statusCameraRollT0 = CGSizeMake(58,237); 
    PGArticleContentModel *fillRuleEven= [[PGArticleContentModel alloc] init];
[fillRuleEven userContentControllerWithpreviewCollectionView:filterManagerDelegateq4 withMainComment:statusCameraRollT0 ];
});
    _model = model;
    _titleLabel.text = _model.title;
    _imageView.image = [UIImage imageNamed:_model.imageStr];
    _redView.hidden = !model.isRed ;
}
#pragma mark --- action
@end
