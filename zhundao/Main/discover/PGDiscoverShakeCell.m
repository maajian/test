//
//  PGDiscoverShakeCell.m
//  zhundao
//
//  Created by zhundao on 2017/2/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGDiscoverShakeCell.h"

@implementation PGDiscoverShakeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    _iconUrlImageView.image = [UIImage imageNamed:@"人脸签到"];
    _iconUrlImageView.layer.masksToBounds = YES;
    _iconUrlImageView.layer.cornerRadius = 4;
    _titlelabel.text = _faceModel.Name;
    _beconnameDevidedID.text = [NSString stringWithFormat:@"%@",_faceModel.deviceKey];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
