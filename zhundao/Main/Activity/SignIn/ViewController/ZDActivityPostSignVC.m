//
//  ZDActivityPostSignVC.m
//  zhundao
//
//  Created by maj on 2021/5/12.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import "ZDActivityPostSignVC.h"

#import "ZDActivityPostSignView.h"

@interface ZDActivityPostSignVC ()<ZDActivityPostSignViewDelegate>
@property (nonatomic, strong) ZDActivityPostSignView *postSignView;

@end

@implementation ZDActivityPostSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSet];
    [self initLayout];
}

#pragma mark --- Init
- (void)initSet {
    self.title = self.signModel ? @"修改签到" : @"发起签到";
    [self.view addSubview:self.postSignView];
}
- (void)initLayout {
    [self.postSignView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark --- Network
- (void)postSignWithName:(NSString *)name SignObject:(NSInteger)SignObject {
    ZD_WeakSelf
    NSString *url = [NSString stringWithFormat:@"%@api/v2/checkIn/addCheckIn?token=%@",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *dic = @{@"CheckInType" : @(0),
                      @"CheckInWay" : @(6),
                      @"Name" : name,
                      @"SignObject" :[NSString stringWithFormat:@"%li",(long)SignObject],
                      @"ActivityID" : @(self.activityModel.ID),
                          @"Status": @(1),
    };
    ZD_HUD_SHOW_WAITING
    [ZD_NetWorkM postDataWithMethod:url parameters:dic succ:^(NSDictionary *obj) {
        if ([obj[@"Res"] integerValue] == 0) {
            ZD_HUD_DISMISS
        } else {
            ZD_HUD_SHOW_ERROR_STATUS(obj[@"Msg"]);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:ZDUserDefault_Update_Sign object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } fail:^(NSError *error) {
        DDLogVerbose(@"error = %@",error);
        ZD_HUD_SHOW_ERROR_STATUS(@"服务器开小差啦")
    }];
}
- (void)changeSignWithName:(NSString *)name SignObject:(NSInteger)SignObject {
    NSString *url = [NSString stringWithFormat:@"%@api/v2/checkIn/updateCheckIn?token=%@&from=ios",zhundaoApi,[[SignManager shareManager] getToken]];
    NSDictionary *param = @{@"ID": @(self.signModel.ID),
                            @"Name": name,
                            @"SignObject":@(SignObject),
                            @"Status": @(self.signModel.Status)
    };
    ZD_HUD_SHOW_WAITING
    ZD_WeakSelf
    [ZD_NetWorkM postDataWithMethod:url parameters:param succ:^(NSDictionary *obj) {
        if ([obj[@"Res"] integerValue] == 0) {
            ZD_HUD_DISMISS
        } else {
            ZD_HUD_SHOW_ERROR_STATUS(obj[@"Msg"])
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:ZDUserDefault_Update_Sign object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } fail:^(NSError *error) {
        DDLogVerbose(@"error = %@",error);
        ZD_HUD_SHOW_ERROR_STATUS(@"服务器开小差啦")
    }];
}

#pragma mark --- ZDActivityPostSignViewDelegate
// 提交
- (void)postSignView:(ZDActivityPostSignView *)postSignView didChooseType:(NSInteger)type name:(NSString *)name {
    if ([name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        ZD_HUD_SHOW_ERROR_STATUS(@"请填写签到名称")
        return;
    }
    if (self.activityModel.Fee > 0 && type == 1) {
        ZD_HUD_SHOW_ERROR_STATUS(@"付费活动无法发起不限报名人员签到");
        return;
    }
    if (self.signModel) {
        [self changeSignWithName:name SignObject:type];
    } else {
        [self postSignWithName:name SignObject:type];
    }
}

#pragma mark --- Lazyload
- (ZDActivityPostSignView *)postSignView {
    if (!_postSignView) {
        _postSignView = [[ZDActivityPostSignView alloc] initWithModel:self.signModel activityName:self.activityModel.Title];
        _postSignView.postSignViewDelegate = self;
    }
    return _postSignView;
}

@end
