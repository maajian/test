#import <UIKit/UIKit.h>
@interface UUIDSettingViewController : UIViewController<UITextFieldDelegate>
{
}
- (IBAction)applySetting:(id)sender;
- (IBAction)resetSetting:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *disUUID1;
@property (retain, nonatomic) IBOutlet UITextField *disUUID2;
@property (retain, nonatomic) NSString *disUUID1Str;
@property (retain, nonatomic) NSString *disUUID2Str;
@property (retain, nonatomic) IBOutlet UITextField *serviceUUID;
@property (retain, nonatomic) IBOutlet UITextField *txUUID;
@property (retain, nonatomic) IBOutlet UITextField *rxUUID;
@property (retain, nonatomic) NSString *transServiceUUIDStr;
@property (retain, nonatomic) NSString *transTxUUIDStr;
@property (retain, nonatomic) NSString *transRxUUIDStr;
@property (assign, nonatomic) BOOL isUUIDAvailable;
@property (assign, nonatomic) BOOL isDISUUIDAvailable;
@end
