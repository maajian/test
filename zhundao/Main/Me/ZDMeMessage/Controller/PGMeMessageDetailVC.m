//
//  PGMeMessageDetailVC.m
//  jingjing
//
//  Created by maj on 2020/8/14.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGMeMessageDetailVC.h"

#import "PGMeMessageViewModel.h"

@interface PGMeMessageDetailVC ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) PGMeMessageViewModel *viewModel;

@end

@implementation PGMeMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self initLayout];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark --- lazyload
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor colorFromHexCode:@"B2B2B2"] font:ZDSystemFont(11) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        _timeLabel.text = [[self.model.AddTime stringByReplacingOccurrencesOfString:@"T" withString:@" "] componentsSeparatedByString:@"."].firstObject;
    }
    return _timeLabel;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorFromHexCode:@"F5F5F5"];
    }
    return _contentView;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithFrame:CGRectZero textColor:[UIColor colorFromHexCode:@"333333"] font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
        _contentLabel.text = _model.Content;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_model.Content];
//        [attributedString addAttributes:@{NSFontAttributeName : ZDSystemFont(14), } range:NSMakeRange(0, _model.Content.length)];
    }
    return _contentLabel;
}

#pragma mark --- network
- (void)networkForRedMessage {
    ZD_WeakSelf
    [self.viewModel setReadMessageWithID:_model.Id success:^{
        weakSelf.model.IsRead = 1;
    } failure:^(NSString *error) {
        
    }];
}

#pragma mark --- UI
- (void)setupUI {
    _viewModel = [[PGMeMessageViewModel alloc] init];
    if (self.model.Type == PGMeMessageTypeAdmin) {
        self.title = @"管理员通知";
    } else {
        self.title = @"系统通知";
    }
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.contentLabel];
    if (!self.model.IsRead) {
        [self networkForRedMessage];
    }
}

#pragma mark --- 布局
- (void)initLayout {
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.equalTo(self.view).offset(16);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(16);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(11);
        make.trailing.equalTo(self.view).offset(-16);
    }];
    CGSize size = [self.contentLabel sizeThatFits:CGSizeMake(kScreenWidth - 60, 1000)];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(14);
        make.trailing.equalTo(self.contentView).offset(-14);
        make.top.equalTo(self.contentView).offset(14);
        make.height.mas_equalTo(size);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
    }];
}

#pragma mark --- setter

#pragma mark --- action

@end
