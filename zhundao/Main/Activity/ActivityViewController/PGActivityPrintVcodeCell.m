#import "PGActivityPrintVcodeCell.h"
@implementation PGActivityPrintVcodeCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setModel:(PGActivityListModel *)model
{
    if (model) {
        _model = model;
    }
    _CountLabel.text =[NSString stringWithFormat:@"%li",(long)_model.count];
    _nameLabel.text =_model.UserName;
    _phoneLabel.text = _model.Mobile;
    [self setButtonC:_pMoreButton];
    [self setButtonC:_pOneButton];
}
- (void)setButtonC :(UIButton *)button
{
    [button setTitleColor:ZDMainColor forState:UIControlStateNormal];
    [button setTitleColor:ZDGrayColor forState:UIControlStateHighlighted];
    button.layer.borderColor = ZDMainColor.CGColor;
    button.layer.borderWidth = 1 ;
    button.layer.cornerRadius = 5 ;
    button.layer.masksToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
