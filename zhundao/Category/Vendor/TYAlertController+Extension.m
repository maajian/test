//
//  TYAlertController+Extension.m
//  zhundao
//
//  Created by maj on 2019/7/14.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import "TYAlertController+Extension.h"

@implementation TYAlertController (Extension)
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message otherButton:(NSString *)otherButton cancelButton:(NSString *)cancelButton otherAction:(ZDBlock_Void)otherAction cancelAction:(ZDBlock_Void)cancelAction {
    TYAlertView *alert = [TYAlertView alertViewWithTitle:title message:message];
    if (otherButton) {
        [alert addAction:[TYAlertAction actionWithTitle:otherButton style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
            otherAction();
        }]];
    }
    if (cancelButton) {
        [alert addAction:[TYAlertAction actionWithTitle:cancelButton style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
            cancelAction();
        }]];
    }
    TYAlertController *tyCTR = [TYAlertController alertControllerWithAlertView:alert preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationScaleFade];
    return tyCTR;
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message otherAction:(ZDBlock_Void)otherAction cancelAction:(ZDBlock_Void)cancelAction {
    TYAlertView *alert = [TYAlertView alertViewWithTitle:title message:message];
    [alert addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
        if (otherAction) {
            otherAction();
        }
    }]];
    [alert addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        if (cancelAction) {
            cancelAction();
        }
    }]];
    TYAlertController *tyCTR = [TYAlertController alertControllerWithAlertView:alert preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationScaleFade];
    return tyCTR;
}

#pragma mark --- 弹窗
+ (instancetype)showChangeNetworkWithoOtherAction:(ZDBlock_Void)otherAction {
    return [TYAlertController alertWithTitle:@"提示" message:@"网络超时，是否切换到备用服务器重试？" otherAction:^{
        otherAction();
    } cancelAction:nil];
}

@end
