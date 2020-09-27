#import <SVProgressHUD/SVProgressHUD.h>
#define ZD_HUD_SHOW_SUCCESS_STATUS_VC(string, vc) \
    [SVProgressHUD showSuccessString:string toast:NO inVC:vc];
#define ZD_HUD_SHOW_FAILURE_STATUS_VC(string, vc) \
    [SVProgressHUD showFailureString:string toast:NO inVC:vc];
#define ZD_HUD_SHOW_Toast_VC(string, vc) \
    [SVProgressHUD showSuccessString:string toast:YES inVC:vc];
#define ZD_HUD_SHOW_TOAST(arg)          [SVProgressHUD ZD_showToast:arg];
#define ZD_HUD_SHOW_Loading(arg)        [SVProgressHUD ZD_showLoading:arg];
#define ZD_HUD_SHOW_WAITING     ZD_HUD_SHOW_Loading(@"请稍等...")
#define ZD_HUD_SHOW_STATUS(arg)         [SVProgressHUD ZD_showStatus:arg];
#define ZD_HUD_SHOW_SUCCESS_STATUS(arg) [SVProgressHUD ZD_showSuccess:arg];
#define ZD_HUD_SHOW_ERROR(err)          [SVProgressHUD ZD_showErrorWithError:err];
#define ZD_HUD_SHOW_ERROR_STATUS(arg)   [SVProgressHUD ZD_showError:arg];
#define ZD_HUD_DISMISS          [SVProgressHUD dismiss]; [SVProgressHUD ZD_dismissOverlay];
@interface SVProgressHUD (Add)
@property (nonatomic, copy) UIControl *ZD_assistOverlay;
+ (void)showSuccessString:(NSString *)successString toast:(BOOL)toast inVC:(UIViewController *)vc;
+ (void)showFailureString:(NSString *)failureString toast:(BOOL)toast inVC:(UIViewController *)vc;
+ (void)ZD_showToast:(NSString *)text;
+ (void)ZD_showStatus:(NSString *)text;
+ (void)ZD_showSuccess:(NSString *)text;
+ (void)ZD_showError:(NSString *)text;
+ (void)ZD_showLoading:(NSString *)text;
+ (void)ZD_showErrorWithError:(NSError *)error;
+ (void)ZD_dismissOverlay;
@end
