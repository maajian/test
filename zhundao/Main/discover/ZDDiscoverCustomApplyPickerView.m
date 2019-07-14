//
//  ZDDiscoverCustomApplyPickerView.m
//  zhundao
//
//  Created by maj on 2019/5/18.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "ZDDiscoverCustomApplyPickerView.h"

@interface ZDDiscoverCustomApplyPickerView()<UIPickerViewDelegate, UIPickerViewDataSource> {
    ZDCustomType type;
}
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, copy) NSArray *pickerArray;

@end

@implementation ZDDiscoverCustomApplyPickerView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        type = ZDCustomTypeOneText;
        _pickerArray = @[@"输入框",@"多文本",@"单选框",@"多选框",@"图片",@"下拉框",@"日期",@"数字"];
        [self setupUI];
        [self initLayout];
    }
    return self;
}

#pragma mark --- lazyload
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_bgView addTapGestureTarget:self action:@selector(cancleAction:)];
    }
    return _bgView;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 9.0;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}
- (UIButton *)sureButton  {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _sureButton;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelButton addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _cancelButton;
}
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [_pickerView selectRow:0 inComponent:0 animated:YES];
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}

#pragma mark --- UI
- (void)setupUI {
    [self addSubview:self.bgView];
    [self.bgView  addSubview:self.contentView];
    [_contentView addSubview:self.lineView];
    [_contentView addSubview:self.cancelButton];
    [_contentView addSubview:self.sureButton];
    [_contentView addSubview:self.pickerView];
}

#pragma mark --- 布局
- (void)initLayout {
    __weak typeof(self) weakSelf = self;
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 100, 245));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-50);
        make.leading.trailing.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(0.5);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.lineView.mas_bottom);
        make.width.equalTo(weakSelf.contentView.mas_width).multipliedBy(0.5);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.lineView.mas_bottom);
        make.width.equalTo(weakSelf.contentView.mas_width).multipliedBy(0.5);
    }];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.lineView.mas_top);
    }];
}

#pragma mark --- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerArray.count;
}

#pragma mark --- UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerArray[row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kScreenWidth - 100;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (row) {
        case 0: {type = ZDCustomTypeOneText; break;}
        case 1: {type = ZDCustomTypeMoreText; break;}
        case 2: {type = ZDCustomTypeOneChoose; break;}
        case 3: {type = ZDCustomTypeMoreChoose; break;}
        case 4: {type = ZDCustomTypeImage; break;}
        case 5: {type = ZDCustomTypePullDown; break;}
        case 6: {type = ZDCustomTypeDate; break;}
        case 7: {type = ZDCustomTypeNumber; break;}
        default:
            break;
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = KweixinFont(15);
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark --- animation
- (void)show {
    _contentView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.65 initialSpringVelocity:0.5 options:0 animations:^{
        _contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        _contentView.transform = CGAffineTransformIdentity;
    }];
}
- (void)hide {
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark --- action
- (void)confirmAction:(UIButton *)button {
    [self removeFromSuperview];
    if ([_customApplyPickerViewDelegate respondsToSelector:@selector(customApplyPickerView:didSelectType:)]) {
        [_customApplyPickerViewDelegate customApplyPickerView:self didSelectType:type];
    }
}
- (void)cancleAction:(UIButton *)button {
    [self hide];
}
@end
