#import "SVProgressHUD+Add.h"
#import <objc/runtime.h>
@implementation SVProgressHUD (Add)
+ (void)load {
    ZD_ExchangeClassImp(@selector(ZD_sharedView), NSSelectorFromString(@"sharedView"))
    ZD_ExchangeClassImp(@selector(ZD_showImage:status:), @selector(showImage:status:))
    ZD_ExchangeClassImp(@selector(ZD_showSuccessWithStatus:maskType:), @selector(showSuccessWithStatus:maskType:))
    ZD_ExchangeClassImp(@selector(ZD_showErrorWithStatus:maskType:), @selector(showErrorWithStatus:maskType:))
    ZD_ExchangeClassImp(@selector(ZD_showWithStatus:maskType:), @selector(showWithStatus:maskType:))
    ZD_ExchangeInstanceImp(@selector(ZD_dismiss), @selector(dismiss))
}
- (UIControl *)ZD_assistOverlay {
    return objc_getAssociatedObject(self, @selector(ZD_assistOverlay));
}
- (void)setZD_assistOverlay:(UIControl *)ZD_assistOverlay {
    objc_setAssociatedObject(self, @selector(ZD_assistOverlay), ZD_assistOverlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)showSuccessString:(NSString *)successString toast:(BOOL)toast inVC:(UIViewController *)vc {
    if (vc.ZD_isTop) {
        [SVProgressHUD resetOffsetFromCenter];
        if (toast) {
            [SVProgressHUD ZD_showToast:successString];
        } else {
            [SVProgressHUD showSuccessWithStatus:successString maskType:SVProgressHUDMaskTypeNone];
        }
    }
}
+ (void)showFailureString:(NSString *)failureString toast:(BOOL)toast inVC:(UIViewController *)vc {
    if (vc.ZD_isTop) {
        [SVProgressHUD resetOffsetFromCenter];
        if (toast) {
            [SVProgressHUD ZD_showToast:failureString];
        } else {
            [SVProgressHUD setMaximumDismissTimeInterval:1.5];
            [SVProgressHUD showErrorWithStatus:failureString maskType:SVProgressHUDMaskTypeNone];
        }
    }
}
+ (void)ZD_showToast:(NSString *)text {
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
    [self ZD_sharedView].ZD_assistOverlay.userInteractionEnabled = NO;
    [SVProgressHUD resetOffsetFromCenter];
    if (ZD_ScreenHeight < ZD_ScreenWidth) {
        [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, ZD_ScreenHeight / 2.0f - 80.0f)];
    } else {
        [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, ZD_ScreenHeight / 2.0f - 60.0f)];
    }
    [self showImage:nil status:text];
}
+ (void)ZD_showStatus:(NSString *)text {
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
    [self ZD_sharedView].ZD_assistOverlay.userInteractionEnabled = NO;
    [SVProgressHUD resetOffsetFromCenter];
    [self showImage:nil status:text];
}
+ (void)ZD_showSuccess:(NSString *)text {
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
    [self ZD_sharedView].ZD_assistOverlay.userInteractionEnabled = NO;
    [self showSuccessWithStatus:text maskType:SVProgressHUDMaskTypeNone];
}
+ (void)ZD_showError:(NSString *)text {
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
    [self ZD_sharedView].ZD_assistOverlay.userInteractionEnabled = NO;
    [self showErrorWithStatus:text maskType:SVProgressHUDMaskTypeNone];
}
+ (void)ZD_showLoading:(NSString *)text {
    [self ZD_sharedView].ZD_assistOverlay.userInteractionEnabled = YES;
    [self showWithStatus:text maskType:SVProgressHUDMaskTypeNone];
}
+ (void)ZD_showErrorWithError:(NSError *)error {
    if (error.domain) {
        ZD_HUD_SHOW_ERROR_STATUS(error.domain)
    } else {
        ZD_HUD_DISMISS
    }
}
#pragma mark - Exchange
+ (SVProgressHUD *)ZD_sharedView {
    SVProgressHUD *hud = [self ZD_sharedView];
    if (!hud.ZD_assistOverlay) {
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0, ZD_TopBar_H, ZD_ScreenWidth, ZD_ScreenHeight - ZD_TopBar_H)];
        control.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        control.backgroundColor = [UIColor clearColor];
        hud.ZD_assistOverlay = control;
    }
    return hud;
}
+ (void)ZD_showImage:(UIImage *)image status:(NSString *)status {
    [self ZD_setColor];
    [self ZD_showImage:image status:status];
}
+ (void)ZD_showSuccessWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType {
    [self ZD_setColor];
    [self resetOffsetFromCenter];
    [self ZD_showSuccessWithStatus:string maskType:maskType];
    [self ZD_insertAssistControl];
}
+ (void)ZD_showErrorWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType {
    [self ZD_setColor];
    [self resetOffsetFromCenter];
    [self ZD_showErrorWithStatus:string maskType:maskType];
    [self ZD_insertAssistControl];
}
+ (void)ZD_showWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [self ZD_setColor];
    [self resetOffsetFromCenter];
    [self ZD_showWithStatus:status maskType:maskType];
    [self ZD_insertAssistControl];
}
+ (void)ZD_dismissOverlay {
    [[self ZD_sharedView].ZD_assistOverlay removeFromSuperview];
}
- (void)ZD_dismiss {
    [self ZD_removeAssistControl];
    [self ZD_dismiss];
}
#pragma mark -- Private
+ (void)ZD_setColor {
    [self setBackgroundColor:[UIColor blackColor]];
    [self setForegroundColor:[UIColor whiteColor]];
}
+ (void)ZD_insertAssistControl {
    SVProgressHUD *hud = [self ZD_sharedView];
    if (hud.ZD_assistOverlay && hud.superview.superview) {
        [hud.superview.superview insertSubview:hud.ZD_assistOverlay belowSubview:hud.superview];
    } else {
        [ZD_KeyWindow addSubview:hud.ZD_assistOverlay];
    }
}
- (void)ZD_removeAssistControl {
    [self.ZD_assistOverlay removeFromSuperview];
}
@end
