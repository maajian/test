//
//  ZDShareView.m
//  partyBoy
//
//  Created by maj on 2020/5/17.
//  Copyright © 2020 maj. All rights reserved.
//

#import "ZDShareView.h"

@interface ZDShareView()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation ZDShareView

+ (void)showWithDelegate:(id<ZDShareViewDelegate>)delegate {
    ZDShareView *alert = [[ZDShareView alloc] initWithFrame:CGRectMake(0, 0, ZD_ScreenWidth, ZD_ScreenHeight)];
    alert.shareViewDelegate = delegate;
    [ZD_KeyWindow addSubview:alert];
    [alert fadeIn];
}
+ (void)showWithModel:(ActivityModel *)model delegate:(id<ZDShareViewDelegate>)delegate {
    ZDShareView *alert = [[ZDShareView alloc] initWithFrame:CGRectMake(0, 0, ZD_ScreenWidth, ZD_ScreenHeight)];
    alert.model = model;
    alert.shareViewDelegate = delegate;
    [ZD_KeyWindow addSubview:alert];
    [alert fadeIn];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self initLayout];
        [self addTapGestureTarget:self action:@selector(fadeOut)];
    }
    return self;
}

#pragma mark --- lazyload
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
       _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}
//- (UILabel *)titleLabel {
//    if (!_titleLabel) {
//        _titleLabel = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(16) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
//        _titleLabel.text = @"分享";
//    }
//    return _titleLabel;
//}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:ZDBlackColor forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = ZDSystemFont(16);
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

#pragma mark --- UI
- (void)setupUI {
    [self addSubview:self.contentView];
//    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.cancelButton];
    
    NSArray *imageArray = @[@"me_invite_wechat", @"me_invite_wechatTimeLine"];
    NSArray *titleArray = @[@"微信", @"朋友圈"];
    for (int i = 0; i < imageArray.count; i++) {
        UIView *bgView = [[UIView alloc] init];
        bgView.tag = 100 + i;
        [bgView addTapGestureTarget:self action:@selector(selectButtonAction:)];
        [self.contentView addSubview:bgView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageArray[i]]];
        [bgView addSubview:imageView];
        
        UILabel *label = [UILabel labelWithFrame:CGRectZero textColor:ZDBlackColor font:ZDSystemFont(14) numberOfLines:0 lineBreakMode:0 lineAlignment:NSTextAlignmentCenter];
        label.text = titleArray[i];
        [bgView addSubview:label];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(ZD_ScreenWidth / 4 * i);
            make.top.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(ZD_ScreenWidth / 4, 100));
        }];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).offset(16);
            make.centerX.equalTo(bgView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView);
            make.top.equalTo(imageView.mas_bottom).offset(12);
        }];
    }
}

#pragma mark --- 布局
- (void)initLayout {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.height.mas_equalTo(156);
        make.bottom.equalTo(self).offset(250);
    }];
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.leading.trailing.equalTo(self.contentView);
//        make.height.mas_equalTo(52);
//    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.contentView);
        make.height.mas_equalTo(56);
    }];
    [self.cancelButton addLineViewAtTop];
    [self layoutIfNeeded];
}

#pragma mark --- setter
#pragma mark --- 视图的小动画
 - (void)fadeIn {
     self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
      [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
          self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
          [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
              make.bottom.equalTo(self).offset(0);
          }];
          [self layoutIfNeeded];
      } completion:nil];
 }
 - (void)fadeOut {
     [UIView animateWithDuration:.35 animations:^{
         self.alpha = 0;
     } completion:^(BOOL finished) {
         [self removeFromSuperview];
     }];
 }

#pragma mark --- action
- (void)selectButtonAction:(UITapGestureRecognizer *)tap {
    [self fadeOut];
    NSInteger index = tap.view.tag - 100;
    if ([self.shareViewDelegate respondsToSelector:@selector(shareView:didSelectType:)]) {
        [self.shareViewDelegate shareView:self didSelectType:index];
    }
}
- (void)cancelAction:(UIButton *)button {
    [self fadeOut];
}

@end
