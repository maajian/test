//
//  MBProgressHUD+Extension.h
//  jingjing
//
//  Created by maj on 2020/8/5.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)

#define kHudShowTime 1.5

#pragma mark 在指定的view上显示hud
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showWarning:(NSString *)Warning toView:(UIView *)view;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message view:(UIView *)view;
+ (MBProgressHUD *)showProgressBarToView:(UIView *)view;


#pragma mark 在window上显示hud
+ (void)showMessage:(NSString *)message;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showWarning:(NSString *)Warning;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message;


#pragma mark 移除hud
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

#define ZD_Hud_Show_Message(a) [MBProgressHUD showMessage:a];
#define ZD_Hud_Show_Error(a) [MBProgressHUD showError:a];
#define ZD_Hud_Loading [MBProgressHUD showActivityMessage:@"加载中..."];
#define ZD_Hud_Dismiss [MBProgressHUD hideHUD];

@end
