#import "PGMeContactTableViewCell.h"
#import "UIImage+LGExtension.h"
#import "NSString+ChangeToPinyin.h"
#import "NSString+getColorFromFirst.h"
@implementation PGMeContactTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setModel:(PGMeContactModel *)model
{
    if (model) {
        _model = model;
    }
    if (_model) {
        _nameLabel.text = _model.TrueName;
        UIColor *color = [[NSString alloc]getColorWithStr:_model.TrueName];
        if (_model.HeadImgurl&&![_model.HeadImgurl isEqualToString:@"(null)"]) {
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.HeadImgurl]];
            _iconImageView.layer.cornerRadius = _iconImageView.frame.size.height/2;
            _iconImageView.layer.masksToBounds = YES;
        }
        else{
            NSString *text = nil;
            if (_model.TrueName.length<=2) {
                text = _model.TrueName;
            }
            else
            {
                text = [_model.TrueName substringWithRange:NSMakeRange(_model.TrueName.length-2, 2)];
            }
            _iconImageView.image = [UIImage circleImageWithText:text bgColor:color size:CGSizeMake(_iconImageView.frame.size.width, _iconImageView.frame.size.height)];
        }
            _phoneLabel.text = _model.Mobile;
            _phoneLabel.font = KHeitiSCMedium(12);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
