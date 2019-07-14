//
//  autoBottomTableViewCell.m
//  zhundao
//
//  Created by zhundao on 2017/9/19.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "autoBottomTableViewCell.h"

@implementation autoBottomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.idCardImgView];
        [self.contentView addSubview:self.topLabel];
        [self createShape];
    }
    return self;
}

- (UIImageView *)idCardImgView{
    if (!_idCardImgView) {
        _idCardImgView = [MyImage initWithImageFrame:CGRectMake(10, 50, 80, 80) imageName:@"加号" cornerRadius:0 masksToBounds:0];
        _idCardImgView.layer.borderColor = KplaceHolderColor.CGColor;
        _idCardImgView.layer.borderWidth = 0.5;
    }
    return _idCardImgView;
}

- (UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 80, 30) Text:nil textColor:KplaceHolderColor font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _topLabel;
}


- (void)setTopStr:(NSString *)topStr{
    _topStr = topStr;
    _topLabel.text = topStr;
}
- (void)setModel:(AuthModel *)model{
    if (model) {
        _model= model;
    }
    if (_idCardImgView.tag==1) {
        [_idCardImgView sd_setImageWithURL:[NSURL URLWithString:_model.idCardFront]];
    }else{
        [_idCardImgView sd_setImageWithURL:[NSURL URLWithString:_model.idCardBack]];
    }
}



- (void) createShape{
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

    // Configure the view for the selected state
}

@end
