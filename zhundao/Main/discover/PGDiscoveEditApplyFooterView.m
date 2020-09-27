#import "PGSliderFillColor.h"
#import "PGDiscoveEditApplyFooterView.h"
@interface PGDiscoveEditApplyFooterView()
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@end
@implementation PGDiscoveEditApplyFooterView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self PG_setupUI];
        [self PG_initLayout];
    }
    return self;
}
#pragma mark --- lazyload
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.addInsetWidth = 20;
        _addButton.addInsetHeight = 20;
        [_addButton setImage:[UIImage imageNamed:@"img_public_add_choose"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(PG_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"增加选项";
    }
    return _titleLabel;
}
- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.textColor = ZDHeaderTitleColor;
        _desLabel.text = @"修改可能会对已发布活动造成影响";
        _desLabel.font = [UIFont systemFontOfSize:13];
    }
    return _desLabel;
}
#pragma mark --- UI
- (void)PG_setupUI {
    [self addSubview:self.addButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.desLabel];
}
#pragma mark --- 布局
- (void)PG_initLayout {
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(20);
        make.top.equalTo(self).offset(10);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.addButton.mas_trailing).offset(10);
        make.centerY.equalTo(self.addButton);
        make.trailing.mas_equalTo(0);
    }];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.trailing.mas_equalTo(0);
    }];
}
#pragma mark --- setter
- (void)setIsNeedChoice:(BOOL)isNeedChoice {
    self.addButton.hidden = !isNeedChoice;
    self.titleLabel.hidden = !isNeedChoice;
    if (isNeedChoice) {
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.titleLabel.mas_leading);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
    } else {
        [self.desLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(-20);
            make.leading.equalTo(self.titleLabel.mas_leading).offset(-30);
        }];
    }
}
- (void)setIsNew:(BOOL)isNew {
    self.addButton.hidden = isNew;
    self.titleLabel.hidden = isNew;
    self.desLabel.hidden = isNew;
}
#pragma mark --- action
- (void)PG_buttonAction:(UIButton *)button {
    if ([self.discoveEditApplyFooterViewDelegate respondsToSelector:@selector(footerView:didAddButton:)]) {
        [self.discoveEditApplyFooterViewDelegate footerView:self didAddButton:button];
    }
}
@end
