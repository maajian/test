#import "PGAssetsGroupSaved.h"
#import "PGMeMessageCell.h"
@interface PGMeMessageCell()
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation PGMeMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self PG_setupUI];
        [self PG_initLayout];
    }
    return self;
}
#pragma mark --- lazyload
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(15) numberOfLines:0 lineBreakMode:NSLineBreakByTruncatingTail lineAlignment:1];
    }
    return _titleLabel;
}
- (UILabel *)detailTitleLabel {
    if (!_detailTitleLabel) {
        _detailTitleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor666 font:ZDSystemFont(13) numberOfLines:1 lineBreakMode:NSLineBreakByTruncatingTail lineAlignment:0];
    }
    return _detailTitleLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDGreyColor999 font:ZDSystemFont(11) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = ZDLineColor;
    }
    return _lineView;
}
#pragma mark --- UI
- (void)PG_setupUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailTitleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.lineView];
}
#pragma mark --- 布局
- (void)PG_initLayout {
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(16);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(43, 43));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftImageView.mas_trailing).offset(10);
        make.top.equalTo(self.contentView).offset(11);
    }];
    [self.detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel);
        make.trailing.equalTo(self.contentView).offset(-17);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.trailing.equalTo(self.contentView).offset(-17);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.leading.equalTo(self.titleLabel.mas_leading);
    }];
}
#pragma mark --- setter
- (void)setModel:(PGMeMessageModel *)model {
    _model = model;
    if (model.Type == PGMeMessageTypeAdmin) {
        if (model.IsRead) {
            _leftImageView.image = [UIImage imageNamed:@"img_me_message_admin"];
        } else {
            _leftImageView.image = [UIImage imageNamed:@"img_me_message_admin_red"];
        }
        _titleLabel.text = @"管理员通知";
    } else {
        if (model.IsRead) {
            _leftImageView.image = [UIImage imageNamed:@"img_me_message_system"];
        } else {
            _leftImageView.image = [UIImage imageNamed:@"img_me_message_system_red"];
        }
         _titleLabel.text = @"系统通知";
    }
    _timeLabel.text = [[_model.AddTime stringByReplacingOccurrencesOfString:@"T" withString:@" "] componentsSeparatedByString:@"."].firstObject;
    _detailTitleLabel.text = _model.Content;
}
#pragma mark --- action
@end
