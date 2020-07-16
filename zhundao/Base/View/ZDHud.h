//
//  ZDHud.h
//  zhundao
//
//  Created by zhundao on 2017/2/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MBProgressHUD.h"

@interface ZDHud : MBProgressHUD

+ (MBProgressHUD *)showWithText:(NSString *)text view:(UIView *)view;
+ (MBProgressHUD *)showSuccess:(NSString *)text view:(UIView *)view delay:(CGFloat)delay;

+(MBProgressHUD *)initWithAnimationType:(MBProgressHUDAnimation)AnimationType showAnimated:(BOOL)showAnimated UIView :(UIView *)View;
+(MBProgressHUD *)initWithMode:(MBProgressHUDMode)Mode labelText :(NSString *)text showAnimated:(BOOL)showAnimated UIView :(UIView *)View imageName:(NSString *)imageName ;
@end
