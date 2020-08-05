//
//  MyHud.m
//  zhundao
//
//  Created by zhundao on 2017/2/24.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "MyHud.h"

@implementation MyHud

+ (MBProgressHUD *)showWithText:(NSString *)text view:(UIView *)view {
    MBProgressHUD *hud = [[self alloc]initWithAnimationType:MBProgressHUDAnimationFade showAnimated:YES UIView:view];
    hud.label.text = text;
    return hud;
}

+ (MBProgressHUD *)showSuccess:(NSString *)text view:(UIView *)view delay:(CGFloat)delay{
    MBProgressHUD *hud = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:text showAnimated:YES UIView:view imageName:@"checked"];
    [hud hideAnimated:YES afterDelay:delay];
    return hud;
}

+(MBProgressHUD *)initWithAnimationType:(MBProgressHUDAnimation)AnimationType showAnimated:(BOOL)showAnimated UIView:(UIView *)view
{
    return [[self alloc]initWithAnimationType:AnimationType showAnimated:showAnimated UIView:view];
}
+(MBProgressHUD *)initWithMode:(MBProgressHUDMode)Mode labelText:(NSString *)text showAnimated:(BOOL)showAnimated UIView:(UIView *)view imageName:(NSString *)imageName
{
    return  [[self alloc]initWithMode:Mode labelText:text showAnimated:showAnimated UIView:view imageName:imageName];
}

- (instancetype)initWithAnimationType:(MBProgressHUDAnimation)AnimationType showAnimated:(BOOL)showAnimated UIView:(UIView *)view
{
    if (self = [super init]) {
        self.bezelView.style = MBProgressHUDBackgroundStyleBlur;
        self.bezelView.backgroundColor = [UIColor blackColor];
        self.bezelView.alpha = 0.8;
        self.tintColor = [UIColor whiteColor];
        self.label.textColor = [UIColor whiteColor];
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=9) {
            [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor whiteColor];
        }
        self.animationType = AnimationType;
        [self showAnimated:showAnimated];
        [view addSubview:self];
    }
    return self;
}
- (instancetype)initWithMode:(MBProgressHUDMode)Mode labelText:(NSString *)text showAnimated:(BOOL)showAnimated UIView:(UIView *)view imageName:(NSString *)imageName
{
    if (self = [super init]) {
        self.bezelView.style = MBProgressHUDBackgroundStyleBlur;
        self.bezelView.backgroundColor = [UIColor blackColor];
        self.bezelView.alpha = 0.8;
        self.mode = Mode;
        self.label.text = text;
        self.contentColor = [UIColor whiteColor];
        self.detailsLabel.textColor = [UIColor whiteColor];
        self.label.textColor = [UIColor whiteColor];
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=9) {
             [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor whiteColor];
        }
        [self showAnimated: showAnimated];
        [view addSubview:self];
        self.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    }
    return self;
}
@end
