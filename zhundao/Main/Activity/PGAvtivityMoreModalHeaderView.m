#import "PGRankMedalView.h"
//
//  PGAvtivityMoreModalHeaderView.m
//  zhundao
//
//  Created by maj on 2018/11/30.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGAvtivityMoreModalHeaderView.h"

#import "Time.h"

@interface PGAvtivityMoreModalHeaderView()
// 详情
@property (nonatomic, strong) UIView *detailView;
// 图片
@property (nonatomic, strong) UIImageView *headerImageView;
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 活动时间
@property (nonatomic, strong) UILabel *activityTimeLabel;
// 报名截止
@property (nonatomic, strong) UILabel *endLabel;
// 线
@property (nonatomic, strong) UIView *lineView;
// 箭头
@property (nonatomic, strong) UIImageView *arrowImageView;
// 报名视图
@property (nonatomic, strong) UIView *applyView;
// 报名人数
@property (nonatomic, strong) UILabel *applyCountLabel;
// 报名文字
@property (nonatomic, strong) UILabel *applyTitleLabel;
// 浏览视图
@property (nonatomic, strong) UIView *browseView;
// 浏览人数
@property (nonatomic, strong) UILabel *browseCountLabel;
// 浏览文字
@property (nonatomic, strong) UILabel *browseTitleLabel;
// 收入视图
@property (nonatomic, strong) UIView *incomeView;
// 收入金额
@property (nonatomic, strong) UILabel *incomeCountLabel;
// 收入文字
@property (nonatomic, strong) UILabel *incomeTitleLabel;

@end

@implementation PGAvtivityMoreModalHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ZDBackgroundColor;
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UIView *)detailView {
    if (!_detailView) {
        _detailView = [[UIView alloc] init];
        _detailView.backgroundColor = [UIColor whiteColor];
        [_detailView addTapGestureTarget:self action:@selector(gotoDetail)];
    }
    return _detailView;
}

// 头部图片
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.cornerRadius=3;
        _headerImageView.layer.masksToBounds = YES;
    }
    return _headerImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)activityTimeLabel {
    if (!_activityTimeLabel) {
        _activityTimeLabel = [[UILabel alloc] init];
        _activityTimeLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
        _activityTimeLabel.textColor = kColorA(153, 153, 153, 1);
    }
    return _activityTimeLabel;
}

- (UILabel *)endLabel {
    if (!_endLabel) {
        _endLabel = [[UILabel alloc] init];
        _endLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
        _endLabel.textColor = kColorA(153, 153, 153, 1);
    }
    return _endLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"rightArrows.png"];
    }
    return _arrowImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = ZDBackgroundColor;
    }
    return _lineView;
}

- (UIView *)applyView {
    if (!_applyView) {
        _applyView = [[UIView alloc] init];
        _applyView.backgroundColor = [UIColor whiteColor];
        [_applyView addTapGestureTarget:self action:@selector(apply)];
    }
    return _applyView;
}

- (UILabel *)applyCountLabel {
    if (!_applyCountLabel) {
        _applyCountLabel = [UILabel new];
        _applyCountLabel.font = [UIFont systemFontOfSize:17];
        _applyCountLabel.textColor = [UIColor blackColor];
    }
    return _applyCountLabel;
}

- (UILabel *)applyTitleLabel {
    if (!_applyTitleLabel) {
        _applyTitleLabel = [UILabel new];
        _applyTitleLabel.text = ZD_UserM.isAdmin ? @"报名" : @"全部";
        _applyTitleLabel.textColor = kColorA(153, 153, 153, 1);
        _applyTitleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
    }
    return _applyTitleLabel;
}

- (UIView *)browseView {
    if (!_browseView) {
        _browseView = [[UIView alloc] init];
        _browseView.backgroundColor = [UIColor whiteColor];
        [_browseView addTapGestureTarget:self action:@selector(browse)];
    }
    return _browseView;
}

- (UILabel *)browseCountLabel {
    if (!_browseCountLabel) {
        _browseCountLabel = [UILabel new];
        _browseCountLabel.font = [UIFont systemFontOfSize:17];
        _browseCountLabel.textColor = [UIColor blackColor];
    }
    return _browseCountLabel;
}

- (UILabel *)browseTitleLabel {
    if (!_browseTitleLabel) {
        _browseTitleLabel = [UILabel new];
        _browseTitleLabel.text = ZD_UserM.isAdmin ? @"浏览" : @"昨日";
        _browseTitleLabel.textColor = kColorA(153, 153, 153, 1);
        _browseTitleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
    }
    return _browseTitleLabel;
}

- (UIView *)incomeView {
    if (!_incomeView) {
        _incomeView = [[UIView alloc] init];
        _incomeView.backgroundColor = [UIColor whiteColor];
        [_incomeView addTapGestureTarget:self action:@selector(income)];
    }
    return _incomeView;
}

- (UILabel *)incomeCountLabel {
    if (!_incomeCountLabel) {
        _incomeCountLabel = [UILabel new];
        _incomeCountLabel.font = [UIFont systemFontOfSize:17];
        _incomeCountLabel.textColor = [UIColor blackColor];
    }
    return _incomeCountLabel;
}

- (UILabel *)incomeTitleLabel {
    if (!_incomeTitleLabel) {
        _incomeTitleLabel = [UILabel new];
        _incomeTitleLabel.text = ZD_UserM.isAdmin ? @"收入" : @"今日";
        _incomeTitleLabel.textColor = kColorA(153, 153, 153, 1);
        _incomeTitleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightThin];
    }
    return _incomeTitleLabel;
}

#pragma mark --- UI
- (void)setupUI {
    [self addSubview:self.detailView];
    [self.detailView addSubview:self.headerImageView];
    [self.detailView addSubview:self.titleLabel];
    [self.detailView addSubview:self.activityTimeLabel];
    [self.detailView addSubview:self.endLabel];
    [self addSubview:self.lineView];
    [self.detailView addSubview:self.arrowImageView];
    [self addSubview:self.applyView];
    [self.applyView addSubview:self.applyCountLabel];
    [self.applyView addSubview:self.applyTitleLabel];
    [self addSubview:self.browseView];
    [self.browseView addSubview:self.browseCountLabel];
    [self.browseView addSubview:self.browseTitleLabel];
    [self addSubview:self.incomeView];
    [self.incomeView addSubview:self.incomeCountLabel];
    [self.incomeView addSubview:self.incomeTitleLabel];
}

#pragma mark --- 布局
- (void)initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    NSLineBreakMode registerViewControllerb4 = NSLineBreakByTruncatingTail; 
        NSArray *imageContentModeV0= [NSArray array];
    PGRankMedalView *tableFooterView= [[PGRankMedalView alloc] init];
[tableFooterView boardWithTextWithforgotPasswordView:registerViewControllerb4 currentDateString:imageContentModeV0 ];
});
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(10);
        make.top.equalTo(self.headerImageView);
        make.right.equalTo(self.arrowImageView.mas_left).offset(5);
    }];
    
    [self.activityTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.endLabel);
        make.right.equalTo(self.endLabel);
        make.bottom.equalTo(self.endLabel.mas_top).offset(-5);
        make.height.mas_equalTo(13);
    }];
    
    [self.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(10);
        make.bottom.equalTo(self.headerImageView);
        make.right.equalTo(self.titleLabel);
        make.height.mas_equalTo(13);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(20);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(ZD_UserM.isAdmin ? 15 : 0);
        make.centerY.equalTo(self.headerImageView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.detailView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [self.applyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.bottom.equalTo(self).offset(-10);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth / 3);
    }];
    
    [self.applyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.applyView);
        make.bottom.equalTo(self.applyView.mas_centerY).offset(-5);
        make.height.mas_equalTo(15);
    }];
    
    [self.applyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.applyView);
        make.height.mas_equalTo(15);
        make.top.equalTo(self.applyCountLabel.mas_bottom).offset(10);
    }];
    
    [self.browseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.applyView);
        make.left.equalTo(self.applyView.mas_right);
    }];
    
    [self.browseCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.browseView);
        make.bottom.equalTo(self.browseView.mas_centerY).offset(-5);
        make.height.mas_equalTo(15);
    }];
    
    [self.browseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.browseView);
        make.top.equalTo(self.browseCountLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
    }];
    
    [self.incomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.applyView);
        make.left.equalTo(self.browseView.mas_right);
    }];
    
    [self.incomeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.incomeView);
        make.bottom.equalTo(self.incomeView.mas_centerY).offset(-5);
        make.height.mas_equalTo(15);
    }];
    
    [self.incomeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.incomeView);
        make.top.equalTo(self.incomeCountLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
    }];
}

#pragma mark --- setter
- (void)setModel:(ActivityModel *)model {
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.ShareImgurl] placeholderImage:[UIImage imageNamed:@"logogray"]];
    _titleLabel.text = model.Title;
    
    Time  *timeStart = [Time bringWithTime:model.TimeStart];
    _activityTimeLabel.text = [NSString stringWithFormat:@"活动时间 : %@",timeStart.timeStr];
    Time *TimeStop = [Time bringWithTime:model.TimeStop];
    _endLabel.text = [NSString stringWithFormat:@"报名截止 : %@", TimeStop.timeStr ];
    
    if (ZD_UserM.isAdmin) {
        _applyCountLabel.text = [NSString stringWithFormat:@"%li",(long)model.HasJoinNum];
        _incomeCountLabel.text = [NSString stringWithFormat:@"%.2f",model.Amount];
        _browseCountLabel.text = [NSString stringWithFormat:@"%li",(long)model.ClickNo];
    } else {
        _applyCountLabel.text = [NSString stringWithFormat:@"%li",(long)model.total];
        _incomeCountLabel.text = [NSString stringWithFormat:@"%li",model.today];
        _browseCountLabel.text = [NSString stringWithFormat:@"%li",(long)model.yesterday];
    }
}

- (void)setEndTime:(NSString *)endTime {
    if (endTime.length) {
        _endLabel.text = endTime;
    }
}

#pragma mark --- action
- (void)gotoDetail {
    if ([self.headerViewDelegate respondsToSelector:@selector(header:didTapDetailView:)]) {
        [self.headerViewDelegate header:self didTapDetailView:self.detailView];
    }
}

- (void)apply {
dispatch_async(dispatch_get_main_queue(), ^{
    NSLineBreakMode maximumFractionDigitsv4 = NSLineBreakByTruncatingTail; 
        NSArray *viewContentModem4= [NSArray arrayWithObject:@""];
    PGRankMedalView *styleWhiteLarge= [[PGRankMedalView alloc] init];
[styleWhiteLarge boardWithTextWithforgotPasswordView:maximumFractionDigitsv4 currentDateString:viewContentModem4 ];
});
    if ([self.headerViewDelegate respondsToSelector:@selector(header:didTapChartView:)]) {
        [self.headerViewDelegate header:self didTapChartView:chartTypeApply];
    }
}

- (void)browse {
    if ([self.headerViewDelegate respondsToSelector:@selector(header:didTapChartView:)]) {
        [self.headerViewDelegate header:self didTapChartView:chartTypeBrowse];
    }
}

- (void)income {
dispatch_async(dispatch_get_main_queue(), ^{
    NSLineBreakMode imageNearIndexf2 = NSLineBreakByTruncatingTail; 
        NSArray *groupPurchaseOrderG9= [NSArray arrayWithObject:@""];
    PGRankMedalView *viewArrowLength= [[PGRankMedalView alloc] init];
[viewArrowLength boardWithTextWithforgotPasswordView:imageNearIndexf2 currentDateString:groupPurchaseOrderG9 ];
});
    if ([self.headerViewDelegate respondsToSelector:@selector(header:didTapChartView:)]) {
        [self.headerViewDelegate header:self didTapChartView:chartTypeIncome];
    }
}

@end
