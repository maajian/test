#import "PGDiscoverShakeCell.h"
@implementation PGDiscoverShakeCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setModel:(PGDiscoverShakeModel *)model
{
    if (model) {
        _model= model;
    }
    [_iconUrlImageView sd_setImageWithURL:[NSURL URLWithString:_model.IconUrl]];
    _iconUrlImageView.layer.masksToBounds = YES;
    _iconUrlImageView.layer.cornerRadius = 4;
    _titlelabel.text = _model.Title;
    _beconnameDevidedID.text = [NSString stringWithFormat:@"设备ID: %@",_model.DeviceId];
}
- (void)setFaceModel:(PGDiscoverFaceModel *)PGDiscoverFaceModel
{
    if (PGDiscoverFaceModel) {
        _faceModel = PGDiscoverFaceModel;
    }
    _iconUrlImageView.image = [UIImage imageNamed:@"img_public_signin_face"];
    _iconUrlImageView.layer.masksToBounds = YES;
    _iconUrlImageView.layer.cornerRadius = 4;
    _titlelabel.text = _faceModel.Name;
    _beconnameDevidedID.text = [NSString stringWithFormat:@"%@",_faceModel.deviceKey];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
