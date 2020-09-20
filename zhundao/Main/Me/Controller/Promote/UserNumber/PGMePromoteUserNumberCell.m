#import "PGCircleCropRadius.h"
//
//  PGDiscoverPromoteUserNumberCell.m
//  zhundao
//
//  Created by maj on 2020/1/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMePromoteUserNumberCell.h"

@interface PGMePromoteUserNumberCell()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *iDLabel;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation PGMePromoteUserNumberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _iconImageView.layer.cornerRadius = 3;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}
- (UILabel *)levelLabel {
    if (!_levelLabel) {
        _levelLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor whiteColor] font:ZDSystemFont(12) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        _levelLabel.layer.cornerRadius = 9;
        _levelLabel.layer.masksToBounds = YES;
        _levelLabel.backgroundColor = ZDBlueColor;
    }
    return _levelLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:PGMediumFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _titleLabel;
}
- (UILabel *)iDLabel {
    if (!_iDLabel) {
        _iDLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:[UIFont systemFontOfSize:12] numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    }
    return _iDLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDHeaderTitleColor font:[UIFont systemFontOfSize:12] numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}

#pragma mark --- UI
- (void)setupUI {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle controllerWithTitleU4 = UITableViewStylePlain; 
        UIImageView * infoHeaderHeighty2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    infoHeaderHeighty2.contentMode = UIViewContentModeCenter; 
    infoHeaderHeighty2.clipsToBounds = NO; 
    infoHeaderHeighty2.multipleTouchEnabled = YES; 
    infoHeaderHeighty2.autoresizesSubviews = YES; 
    infoHeaderHeighty2.clearsContextBeforeDrawing = YES; 
    PGCircleCropRadius *buttonSystemItem= [[PGCircleCropRadius alloc] init];
[buttonSystemItem pg_fansWithUserWithselectPhotoDelegate:controllerWithTitleU4 failLoadingWith:infoHeaderHeighty2 ];
});
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.iDLabel];
    [self.contentView addSubview:self.levelLabel];
    [self.contentView addSubview:self.timeLabel];
}

#pragma mark --- 布局
- (void)initLayout {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(18);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_top);
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(10);
    }];
    [self.iDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.levelLabel.mas_trailing).offset(6);
        make.bottom.equalTo(self.levelLabel);
    }];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(10);
        make.bottom.equalTo(self.iconImageView);
        make.size.mas_equalTo(CGSizeMake(28, 18));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView).offset(-18);
    }];
}

#pragma mark --- setter
- (void)setModel:(PGMePromoteUserNumberModel *)model {
dispatch_async(dispatch_get_main_queue(), ^{
    UITableViewStyle collectionDataWithf2 = UITableViewStylePlain; 
        UIImageView * networkStatusReachableviaS4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    networkStatusReachableviaS4.contentMode = UIViewContentModeCenter; 
    networkStatusReachableviaS4.clipsToBounds = NO; 
    networkStatusReachableviaS4.multipleTouchEnabled = YES; 
    networkStatusReachableviaS4.autoresizesSubviews = YES; 
    networkStatusReachableviaS4.clearsContextBeforeDrawing = YES; 
    PGCircleCropRadius *trainParticularView= [[PGCircleCropRadius alloc] init];
[trainParticularView pg_fansWithUserWithselectPhotoDelegate:collectionDataWithf2 failLoadingWith:networkStatusReachableviaS4 ];
});
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.HeadImgurl] placeholderImage:[UIImage imageNamed:@"user.png"]];
    if (model.TrueName.length && model.NickName.length) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@ (%@)",model.NickName, model.TrueName];
    } else if (model.NickName.length) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@", model.NickName];
    } else if (model.TrueName.length) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@", model.TrueName];
    } 
    self.levelLabel.text = [NSString stringWithFormat:@"V%li", (long)model.GradeId];
    self.iDLabel.text = [NSString stringWithFormat:@"准到ID: %li", (long)model.UserId];
    self.timeLabel.text = model.AddTime;
}

@end
