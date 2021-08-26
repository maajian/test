//
//  ZDMessageMainDetailVC.m
//  zhundao
//
//  Created by maj on 2020/12/6.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDMessageMainDetailVC.h"

#import "ZDMessageMainViewModel.h"
#import "ListViewController.h"

@interface ZDMessageMainDetailVC ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) ZDMessageMainViewModel *viewModel;

@end

@implementation ZDMessageMainDetailVC

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
    }
    return _contentLabel;
}
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_arrow"]];
    }
    return _arrowImageView;
}
#pragma mark --- network
- (void)networkForRedMessage {
    ZD_WeakSelf
    [self.viewModel setReadMessageWithID:_model.Id success:^{
        weakSelf.model.IsRead = 1;
        if (ZD_UserM.unreadMessage) {
            ZD_UserM.unreadMessage -= 1;
        }
    } failure:^(NSString *error) {
    }];
}
#pragma mark --- UI
- (void)setupUI {
    _viewModel = [[ZDMessageMainViewModel alloc] init];
    if (self.model.Type == ZDMeMessageTypeAdmin) {
        self.title = @"管理员通知";
    } else {
        self.title = @"系统通知";
    }
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.contentLabel];
    if (self.model.click_type != ZDMeMessageClickTypeNone && self.model.click_type != ZDMeMessageClickTypeWebOutApp) {
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addTapGestureTarget:self action:@selector(clickAction)];
    }
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
        if (self.model.click_type != ZDMeMessageClickTypeNone && self.model.click_type != ZDMeMessageClickTypeWebOutApp) {
            
        } else {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
        }
    }];
    if (self.model.click_type != ZDMeMessageClickTypeNone && self.model.click_type != ZDMeMessageClickTypeWebOutApp) {
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.contentView).offset(-16);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
        }];
    }
}

#pragma mark --- network
- (void)networkForActivityListDetail:(NSInteger)activityID {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/getSingleActivityForUser?activityId=%li&token=%@",zhundaoApi,(long)activityID,[[SignManager shareManager] getToken]];
    [ZD_NetWorkM getDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        if ([obj[@"res"] boolValue]) {
            ActivityModel *model = [ActivityModel yy_modelWithDictionary:obj[@"data"]];
            ListViewController *list = [[ListViewController alloc]init];
            list.activityModel = model;
            [self.navigationController pushViewController:list animated:YES];
        } else {
            ZD_HUD_SHOW_ERROR_STATUS(obj[@"errmsg"]);
        }
    } fail:^(NSError *error) {
        ZD_HUD_SHOW_ERROR_STATUS(@"请检查网络设置")
    }];
}

#pragma mark --- Action
- (void)clickAction {
    if (self.model.click_type == ZDMeMessageClickTypeApplyList) {
        NSInteger ActivityID = [self.model.param integerValue];
        [self networkForActivityListDetail:ActivityID];
    } else if (self.model.click_type == 105 || self.model.click_type == 106 || self.model.click_type == 100) {
        NSString *url = [self.model.url stringByReplacingOccurrencesOfString:@"[token]" withString:[[SignManager shareManager] getToken]];
        ZDWebViewController *web = [[ZDWebViewController alloc] init];
        web.urlString = url;
        web.isClose = YES;
        [self.navigationController pushViewController:web animated:YES];
    }
}

@end
