#import "PGOrganizeListView.h"
//
//  PGLoginCodeSendView.m
//  jingjing
//
//  Created by maj on 2020/8/3.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "PGLoginCodeSendView.h"

@interface PGLoginCodeSendView()
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *countryLabel;
@property (nonatomic, strong) UIImageView  *countryArrowImg;
@property (nonatomic, strong) UITextField   *phoneTF;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation PGLoginCodeSendView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- UI
- (void)setupUI {
    _closeButton = [UIButton buttonWithFrame:CGRectZero normalImage:[UIImage imageNamed:@"nav_close"] target:self action:@selector(closeAction:)];
    [self addSubview:_closeButton];
    
    _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(28) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    _titleLabel.text = @"欢迎登录金塔统计";
    [self addSubview:_titleLabel];
    
    _countryLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:0];
    _countryLabel.text = @"+86";
    [self addSubview:_countryLabel];
    
    _countryArrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public_image_arrow_right"]];
    [self addSubview:_countryArrowImg];
    
    _phoneTF = [[UITextField alloc] init];
    _phoneTF.textColor = ZDBlackColor;
    _phoneTF.font = [UIFont systemFontOfSize:18];
    _phoneTF.placeholder = @"请输入手机号";
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_phoneTF.placeholder attributes:@{NSForegroundColorAttributeName : [UIColor colorFromHexCode:@"B2B2B2"]}];
    [self addSubview:_phoneTF];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = ZDLineColor;
    [self addSubview:_lineView];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.backgroundColor = ZDBlackColor3;
    _nextButton.layer.cornerRadius = 5;
    _nextButton.layer.masksToBounds = YES;
    _nextButton.titleLabel.font = ZDSystemFont(14);
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextButton];
}

#pragma mark --- 布局
- (void)initLayout {
dispatch_async(dispatch_get_main_queue(), ^{
    UIImageView * changePhoneViewS7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString string]] highlightedImage:[[UIImage alloc] initWithData:[NSData data]]]; 
    changePhoneViewS7.contentMode = UIViewContentModeCenter; 
    changePhoneViewS7.clipsToBounds = NO; 
    changePhoneViewS7.multipleTouchEnabled = YES; 
    changePhoneViewS7.autoresizesSubviews = YES; 
    changePhoneViewS7.clearsContextBeforeDrawing = YES; 
        UITableView *downloadProgressBlockK7= [[UITableView alloc] initWithFrame:CGRectZero style: UITableViewStylePlain]; 
    downloadProgressBlockK7.frame = CGRectZero; 
    downloadProgressBlockK7.showsVerticalScrollIndicator = NO; 
    downloadProgressBlockK7.showsHorizontalScrollIndicator = NO; 
    downloadProgressBlockK7.backgroundColor = [UIColor whiteColor]; 
    downloadProgressBlockK7.separatorColor = [UIColor whiteColor]; 
    downloadProgressBlockK7.tableFooterView = [UIView new]; 
    downloadProgressBlockK7.estimatedRowHeight =59; 
    downloadProgressBlockK7.estimatedSectionHeaderHeight =71; 
    downloadProgressBlockK7.estimatedSectionFooterHeight =68; 
    downloadProgressBlockK7.rowHeight =69; 
    downloadProgressBlockK7.sectionFooterHeight =21; 
    downloadProgressBlockK7.sectionHeaderHeight =0; 
    downloadProgressBlockK7.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(185,4,82,245)];
     downloadProgressBlockK7.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(127,3,117,79)];
     PGOrganizeListView *viewCellDelegate= [[PGOrganizeListView alloc] init];
[viewCellDelegate deviceSettingsTypeWithlaunchViewController:changePhoneViewS7 deepBlackColor:downloadProgressBlockK7 ];
});
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(15);
        make.top.equalTo(self).offset(30 + ZD_StatusBar_H);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.closeButton.mas_bottom).offset(50);
        make.leading.equalTo(self).offset(40);
        make.height.mas_equalTo(40);
    }];
    [self.countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(40);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(48);
        make.width.mas_equalTo(35);
    }];
    [self.countryArrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countryLabel);
        make.leading.equalTo(self.countryLabel.mas_trailing).offset(8);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countryLabel);
        make.leading.equalTo(self.countryArrowImg.mas_trailing).offset(10);
        make.trailing.equalTo(self.lineView.mas_trailing);
        make.height.mas_equalTo(40);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countryLabel.mas_bottom).offset(15);
        make.leading.equalTo(self).offset(40);
        make.trailing.equalTo(self).offset(-40);
        make.height.mas_equalTo(1);
    }];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(18);
        make.trailing.equalTo(self).offset(-18);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.lineView.mas_bottom).offset(80);
    }];
}

#pragma mark --- setter

#pragma mark --- UITextFieldDelegate

#pragma mark --- action
- (void)closeAction:(UIButton *)button {
    if ([self.loginCodeSendViewDelegate respondsToSelector:@selector(PGLoginCodeSendView:didTapCloseButton:)]) {
        [self.loginCodeSendViewDelegate PGLoginCodeSendView:self didTapCloseButton:button];
    }
}
- (void)nextAction:(UIButton *)nextButton {
    if ([self.loginCodeSendViewDelegate respondsToSelector:@selector(PGLoginCodeSendView:didTapNextButton:)]) {
        [self.loginCodeSendViewDelegate PGLoginCodeSendView:self didTapNextButton:nextButton];
    }
}

@end
