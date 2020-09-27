#import "PGMeAutoBottomTableViewCell.h"
@implementation PGMeAutoBottomTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.idCardImgView];
        [self.contentView addSubview:self.topLabel];
        [self PG_createShape];
    }
    return self;
}
- (UIImageView *)idCardImgView{
    if (!_idCardImgView) {
        _idCardImgView = [MyImage initWithImageFrame:CGRectMake(10, 50, 80, 80) imageName:@"img_public_add_new" cornerRadius:0 masksToBounds:0];
        _idCardImgView.layer.borderColor = ZDPlaceHolderColor.CGColor;
        _idCardImgView.layer.borderWidth = 0.5;
    }
    return _idCardImgView;
}
- (UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 80, 30) Text:nil textColor:ZDPlaceHolderColor font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _topLabel;
}
- (void)setTopStr:(NSString *)topStr{
    _topStr = topStr;
    _topLabel.text = topStr;
}
- (void)setModel:(PGMeAuthModel *)model{
    if (model) {
        _model= model;
    }
    if (_idCardImgView.tag==1) {
        [_idCardImgView sd_setImageWithURL:[NSURL URLWithString:_model.idCardFront]];
    }else{
        [_idCardImgView sd_setImageWithURL:[NSURL URLWithString:_model.idCardBack]];
    }
}
- (void) PG_createShape{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth  = 0.2 ;
    layer.strokeColor = kColorA(100, 100, 100, 1).CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 40)];
    [path addLineToPoint:CGPointMake(kScreenWidth, 40)];
    [path stroke];
    layer.path = path.CGPath;
    [self.contentView.layer addSublayer:layer];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
