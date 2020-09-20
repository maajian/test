#import "PGWithFileName.h"
//
//  PGActivityCell.m
//  zhundao
//
//  Created by maj on 2019/7/6.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "PGActivityCell.h"

@interface PGActivityCell()

@property (nonatomic, strong) UIImageView *activityImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *countLabel;
@property (nonatomic, strong) UILabel     *beginLabel;
@property (nonatomic, strong) UILabel     *endLabel;

@property (nonatomic, strong) UILabel     *centerLine;
@property (nonatomic, strong) UIButton    *listButton;
@property (nonatomic, strong) UIButton    *signButton;
@property (nonatomic, strong) UIButton    *shareButton;
@property (nonatomic, strong) UIButton    *moreButton;
@property (nonatomic,   copy) NSArray     *bottomButtonArray;

@end

@implementation PGActivityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self initLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark --- lazyload

#pragma mark --- UI
- (void)setupUI {
    // 图片
    _activityImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_activityImageView];
    
    // 标题
    _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor blackColor] font:[UIFont boldSystemFontOfSize:14] numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    [self.contentView addSubview:_titleLabel];
    
    // 报名人数
    _countLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:11] numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    [self.contentView addSubview:_countLabel];
    
    // 开始时间
    _beginLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:11] numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    [self.contentView addSubview:_beginLabel];
    
    // 截止时间
    _endLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:11] numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    [self.contentView addSubview:_endLabel];
    
    // 线
    _centerLine = [[UILabel alloc] init];
    _centerLine.backgroundColor = ZDLineColor;
    [self.contentView addSubview:self.centerLine];
    
    // 名单按钮
    _listButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"activity_list"] target:self action:@selector(listAction:)];
    [_listButton setTitle:@"名单" forState:UIControlStateNormal];
    [_listButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _listButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.listButton];
    
    // 签到
    _signButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"activity_sign"] target:self action:@selector(signAction:)];
    [_signButton setTitle:@"签到" forState:UIControlStateNormal];
    [_signButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _signButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.signButton];
    
    // 分享
    _shareButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"activity_share"] target:self action:@selector(shareAction:)];
    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [_shareButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _shareButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.shareButton];
    
    // 更多
    _moreButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"activity_more"] target:self action:@selector(moreAction:)];
    [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [_moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.moreButton];
    _bottomButtonArray = @[_listButton, _signButton, _shareButton, _moreButton];
}

#pragma mark --- 布局
- (void)initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets assetResourceLoadingl0 = UIEdgeInsetsZero;
        NSData *handpickViewControllere5= [[NSData alloc] init];
    PGWithFileName *userCommentModel= [[PGWithFileName alloc] init];
[userCommentModel viewContentSizeWithcenterViewModel:assetResourceLoadingl0 timesFromSlider:handpickViewControllere5 ];
});
    [_activityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.25, kScreenWidth * 0.25));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_activityImageView.mas_trailing).offset(5);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.top.equalTo(_activityImageView.mas_top);
        make.height.equalTo(_activityImageView.mas_height).multipliedBy(ZD_UserM.isAdmin ? 0.25 : 0.33);
    }];
   if (ZD_UserM.isAdmin) {
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(0);
            make.leading.trailing.height.equalTo(_titleLabel);
        }];
    }
    
    [_beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ZD_UserM.isAdmin ? _countLabel.mas_bottom : _titleLabel.mas_bottom);
        make.leading.trailing.height.equalTo(_titleLabel);
    }];
    
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_beginLabel.mas_bottom);
         make.leading.trailing.height.equalTo(_titleLabel);
    }];
    
    [_centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_activityImageView.mas_bottom).offset(10);
        make.leading.equalTo(_activityImageView);
        make.trailing.mas_equalTo(-10);
        make.height.mas_equalTo(1);
    }];
    
    if (ZD_UserM.isAdmin) {
        [_bottomButtonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [_bottomButtonArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-5);
            make.top.equalTo(_centerLine.mas_bottom);
        }];
        [self layoutIfNeeded];
        [_signButton setButtonContentCenter];
        [_shareButton setButtonContentCenter];
        [_listButton setButtonContentCenter];
        [_moreButton setButtonContentCenter];
    }
    
}

#pragma mark --- setter
- (void)setModel:(ActivityModel *)model {
    _model = model;
    // 标题
    _titleLabel.text = _model.Title;
    // 报名人数
    if (_model.UserLimit==0) {
        _countLabel.text = [NSString stringWithFormat:@"报名人数:%li/不限",(long)_model.HasJoinNum];
    } else{
        _countLabel.text = [NSString stringWithFormat:@"报名人数:%li/%li",(long)_model.HasJoinNum,(long)_model.UserLimit];
    }
    _centerLine.hidden = ZD_UserM.isAdmin ? NO : YES;
    // 收入
    NSString *income = @"";
    if (_model.Fee) {
        income = [NSString stringWithFormat:@"     线上收入:%.2f",_model.Amount];
        _countLabel.text = [_countLabel.text stringByAppendingString:income];
    }
    // 图片
    [_activityImageView sd_setImageWithURL:[NSURL URLWithString:_model.ShareImgurl] placeholderImage:[UIImage imageNamed:@"logogray"]];
    [_activityImageView setContentMode:UIViewContentModeScaleAspectFill];
    _activityImageView.clipsToBounds = YES;
    // 活动开始时间
    _beginLabel.text = [NSString getHomeActivityBeginTime:_model.TimeStart stopTime:_model.EndTime];
    // 活动截止时间
    _endLabel.text = [_model.TimeStop getHomeActivityEndTime];
    
    NSArray *array1 = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"%li",(long)_model.ID]];
    if (ZD_UserM.isAdmin) {
        if (_model.HasJoinNum!=array1.count&&_model.HasJoinNum!=0) {
            [_listButton.imageView showBadgeWithStyle:(WBadgeStyleRedDot) value:0 animationType:(WBadgeAnimTypeNone)];
            _listButton.imageView.layer.masksToBounds = NO;
        } else {
            [_listButton.imageView clearBadge];
        }
    }
}

#pragma mark --- action
- (void)listAction:(UIButton *)button {
    if ([self.activityCellDelegate respondsToSelector:@selector(activityCell:didTapListButton:)]) {
        [self.activityCellDelegate activityCell:self didTapListButton:button];
    }
}
- (void)signAction:(UIButton *)button {
    if ([self.activityCellDelegate respondsToSelector:@selector(activityCell:didTapSignButton:)]) {
        [self.activityCellDelegate activityCell:self didTapSignButton:button];
    }
}
- (void)shareAction:(UIButton *)button {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets timeRangeValued4 = UIEdgeInsetsZero;
        NSData *locationWithSuccessg4= [[NSData alloc] init];
    PGWithFileName *courseParticularVideo= [[PGWithFileName alloc] init];
[courseParticularVideo viewContentSizeWithcenterViewModel:timeRangeValued4 timesFromSlider:locationWithSuccessg4 ];
});
    if ([self.activityCellDelegate respondsToSelector:@selector(activityCell:didTapShareButton:)]) {
        [self.activityCellDelegate activityCell:self didTapShareButton:button];
    }
}
- (void)moreAction:(UIButton *)button {
    if ([self.activityCellDelegate respondsToSelector:@selector(activityCell:didTapMoreButton:)]) {
        [self.activityCellDelegate activityCell:self didTapMoreButton:button];
    }
}


@end
