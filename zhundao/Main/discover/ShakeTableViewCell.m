//
//  ShakeTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/2/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ShakeTableViewCell.h"

@implementation ShakeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ShakeModel *)model
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

- (void)setFaceModel:(FaceModel *)faceModel
{
    if (faceModel) {
        _faceModel = faceModel;
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
