#import "UIAlertController+creat.h"
@implementation UIAlertController (creat)
+(UIAlertController *)initWithTitle :(NSString *)title message :(NSString *)message sureAction :(uiAlert)alertAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:alertAction]];
    return  alert;
}
+(UIAlertController *)initWithNotHaveTextFieldTitle :(NSString *)title message :(NSString *)message sureAction :(uiAlert)alertAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:alertAction]];
    return  alert;
}
+(UIAlertController *)initWithHaveCancelAndSure :(NSString *)title message :(NSString *)message sureAction :(uiAlert)alertAction cancelAction :(uiAlert1)alertAction1
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:alertAction1]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:alertAction]];
    return  alert;
}
@end
