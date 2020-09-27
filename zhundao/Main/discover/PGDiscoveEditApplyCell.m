#import "PGImageViewFrame.h"
#import "PGDiscoveEditApplyCell.h"
@interface PGDiscoveEditApplyCell()<UITextFieldDelegate>
@end
@implementation PGDiscoveEditApplyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self PG_setupUI];
        [self PG_initLayout];
    }
    return self;
}
#pragma mark --- lazyload
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton addTarget:self action:@selector(PG_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}
- (UITextField *)choiceTF {
    if (!_choiceTF) {
        _choiceTF = [UITextField new];
        _choiceTF.font = [UIFont systemFontOfSize:14];
        _choiceTF.textColor = [UIColor blackColor];
        _choiceTF.delegate = self;
        _choiceTF.tintColor = ZDMainColor;
    }
    return _choiceTF;
}
#pragma mark --- UI
- (void)PG_setupUI {
    [self.contentView addSubview:self.leftButton];
    [self.contentView addSubview:self.choiceTF];
}
#pragma mark --- 布局
- (void)PG_initLayout {
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.choiceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftButton.mas_trailing).offset(10);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.top.bottom.equalTo(self.contentView);
    }];
}
#pragma mark --- setter
- (void)setText:(NSString *)text {
    _choiceTF.text = text;
}
#pragma mark --- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
dispatch_async(dispatch_get_main_queue(), ^{
    NSData *allowPickingVideof6= [[NSData alloc] init];
        UIButtonType itemWithAssetG0 = UIButtonTypeContactAdd;
    PGImageViewFrame *recommendCourseModel= [[PGImageViewFrame alloc] init];
[recommendCourseModel minimumTrackImageWithallowWithController:allowPickingVideof6 selectTypeMyttention:itemWithAssetG0 ];
});
    _text = textField.text;
    if ([self.discoveEditApplyCellDelegate respondsToSelector:@selector(tableViewCell:didEndEdit:)]) {
        [self.discoveEditApplyCellDelegate tableViewCell:self didEndEdit:textField];
    }
}
#pragma mark --- action
- (void)PG_buttonAction:(UIButton *)button {
    if ([self.discoveEditApplyCellDelegate respondsToSelector:@selector(tableViewCell:didSelectButton:)]) {
        [self.discoveEditApplyCellDelegate tableViewCell:self didSelectButton:button];
    }
}
@end
