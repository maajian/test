#import "PGMutableAttributedString.h"
#import "PGMePromoteCustomContactHeaderView.h"
#import "PGMePromoteCustomContactNoticeView.h"
@interface PGMePromoteCustomContactHeaderView()<PGMePromoteCustomContactNoticeViewDelegate>
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *moneyImageView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *trailLabel;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) PGMePromoteCustomContactNoticeView *noticeView;
@end
@implementation PGMePromoteCustomContactHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self PG_setupUI];
        [self PG_initLayout];
    }
    return self;
}
#pragma mark --- lazyload
- (UIView *)blackView {
    if (!_blackView) {
        _blackView = [[UIView alloc] init];
        _blackView.backgroundColor = ZDBlackColor2;
    }
    return _blackView;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius = 4;
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:ZD_UserM.headImgUrl]];
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor whiteColor] font:PGMediumFont(15) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        if (ZD_UserM.trueName.length) {
            _nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", ZD_UserM.nickName, ZD_UserM.trueName];
        } else {
            _nameLabel.text = ZD_UserM.nickName;
        }
   }
    return _nameLabel;
}
- (UIImageView *)moneyImageView {
    if (!_moneyImageView) {
        _moneyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_me_Promote_money"]];
    }
    return _moneyImageView;
}
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor whiteColor] font:PGMediumFont(13) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _countLabel;
}
- (UILabel *)trailLabel {
    if (!_trailLabel) {
        _trailLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor whiteColor] font:PGMediumFont(13) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
        _trailLabel.text = @"拓展客户";
    }
    return _trailLabel;
}
- (UIButton *)arrowButton {
    if (!_arrowButton) {
        _arrowButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"public_image_white_arrow_right"] target:self action:@selector(PG_jumpQRCode:)];
        _arrowButton.addInsetWidth = 70;
        _arrowButton.addInsetHeight = 20;
    }
    return _arrowButton;
}
- (PGMePromoteCustomContactNoticeView *)noticeView {
    if (!_noticeView) {
        _noticeView = [PGMePromoteCustomContactNoticeView new];
        _noticeView.promoteCustomContactNoticeViewDelegate = self;
    }
    return _noticeView;
}
#pragma mark --- UI
- (void)PG_setupUI {
    [self addSubview:self.blackView];
    [self.blackView addSubview:self.iconImageView];
    [self.blackView addSubview:self.nameLabel];
    [self.blackView addSubview:self.moneyImageView];
    [self.blackView addSubview:self.countLabel];
    [self.blackView addSubview:self.trailLabel];
    [self.blackView addSubview:self.arrowButton];
    [self addSubview:self.noticeView];
}
#pragma mark --- 布局
- (void)PG_initLayout {
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self);
        make.height.mas_equalTo(108);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-20);
        make.leading.equalTo(self).offset(25);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView);
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(10);
        make.trailing.equalTo(self.trailLabel.mas_leading).offset(-10);
    }];
    [self.moneyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.nameLabel);
        make.bottom.equalTo(self.iconImageView);
        make.size.mas_equalTo(CGSizeMake(24, 27));
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.moneyImageView.mas_trailing).offset(3);
        make.centerY.equalTo(self.moneyImageView);
    }];
    [self.trailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.arrowButton.mas_leading).offset(-12);
        make.centerY.equalTo(self.iconImageView);
    }];
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView);
        make.trailing.equalTo(self).offset(-13);
        make.size.mas_equalTo(CGSizeMake(7.5, 12));
    }];
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.leading.equalTo(self).offset(13);
        make.trailing.equalTo(self).offset(-13);
        make.height.mas_equalTo(37);
    }];
}
#pragma mark --- setter
- (void)setZhundaoBi:(NSInteger)zhundaoBi {
    _zhundaoBi = zhundaoBi;
    _countLabel.text = [NSString stringWithFormat:@"%li",(long)zhundaoBi];
}
- (void)setNoticeArray:(NSMutableArray<PGMePromoteNoticeModel *> *)noticeArray {
    _noticeArray = noticeArray;
    self.noticeView.noticeArray = noticeArray;
}
#pragma mark --- action
- (void)PG_jumpQRCode:(UIButton *)button {
    if ([self.promoteCustomContactHeaderViewDelegate respondsToSelector:@selector(promoteCustomContactHeaderView:didTapExtendButton:)]) {
        [self.promoteCustomContactHeaderViewDelegate promoteCustomContactHeaderView:self didTapExtendButton:button];
    }
}
#pragma mark --- PGMePromoteCustomContactHeaderView
- (void)promoteCustomContactNoticeView:(PGMePromoteCustomContactNoticeView *)promoteCustomContactNoticeView didTapMoreButton:(UIButton *)button {
    if ([self.promoteCustomContactHeaderViewDelegate respondsToSelector:@selector(promoteCustomContactHeaderView:didTapMoreButton:)]) {
        [self.promoteCustomContactHeaderViewDelegate promoteCustomContactHeaderView:self didTapMoreButton:button];
    }
}
- (void)promoteCustomContactNoticeView:(PGMePromoteCustomContactNoticeView *)promoteCustomContactNoticeView didTapNotice:(PGMePromoteNoticeModel *)model {
    if ([self.promoteCustomContactHeaderViewDelegate respondsToSelector:@selector(promoteCustomContactHeaderView:didTapNotice:)]) {
        [self.promoteCustomContactHeaderViewDelegate promoteCustomContactHeaderView:self didTapNotice:model];
    }
}
@end