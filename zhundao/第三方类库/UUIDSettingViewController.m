#import "PGRecordCompleteView.h"
#import "UUIDSettingViewController.h"
#import "AppDelegate.h"
@interface UUIDSettingViewController ()
- (NSString *) PG_getUuid: (NSString *)uuid;
- (void) PG_animateTextField: (UITextField *)textField up:(BOOL)up;
@end
@implementation UUIDSettingViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.transServiceUUIDStr = nil;
        self.transTxUUIDStr = nil;
        self.transRxUUIDStr = nil;
        self.disUUID1Str = nil;
        self.disUUID2Str = nil;
        self.isUUIDAvailable = FALSE;
        self.isDISUUIDAvailable = FALSE;
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"[UUIDSettingViewController] textFieldShouldReturn");
    [textField resignFirstResponder];
    return TRUE;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890aAbBcCdDeEfF"] invertedSet];
    if ([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] > 1)
        return NO;
    else {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if ((textField == _disUUID1)||(textField == _disUUID2)) {
            return (newLength > 4) ? NO : YES;
        }
        else
            return (newLength > 32) ? NO : YES;
    }
}
- (void)dealloc {
dispatch_async(dispatch_get_main_queue(), ^{
    NSTextAlignment playerStatusFailedL9 = NSTextAlignmentCenter; 
        UITextView *profileDataWithM9= [[UITextView alloc] initWithFrame:CGRectZero]; 
    profileDataWithM9.editable = NO; 
    profileDataWithM9.font = [UIFont systemFontOfSize:168];
    profileDataWithM9.text = @"mediaTimingFunction";
    PGRecordCompleteView *collectionOriginalView= [[PGRecordCompleteView alloc] init];
[collectionOriginalView orderGroupCellWithshowLoginAlert:playerStatusFailedL9 originStatusBackground:profileDataWithM9 ];
});
    [_serviceUUID release];
    [_txUUID release];
    [_rxUUID release];
    if (self.transServiceUUIDStr)
        [self.transServiceUUIDStr release];
    if (self.transTxUUIDStr)
        [self.transTxUUIDStr release];
    if (self.transRxUUIDStr)
        [self.transRxUUIDStr release];
    [_disUUID1 release];
    [_disUUID2 release];
    if (self.disUUID1Str)
        [self.disUUID1Str release];
    if (self.disUUID2Str)
        [self.disUUID2Str release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setServiceUUID:nil];
    [self setTxUUID:nil];
    [self setRxUUID:nil];
    [self setDisUUID1:nil];
    [self setDisUUID2:nil];
    [super viewDidUnload];
}
- (IBAction)applySetting:(id)sender {
    if (([[self.disUUID1 text] length] >0) || ([[self.disUUID2 text] length] >0)){
        if ([[self.disUUID1 text] length] != 4)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid UUID Setting" message:@"DIS UUID1 must match 16-bit" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
        else{
            if (self.disUUID1Str)
                [self.disUUID1Str release];
            if (self.disUUID2Str)
                [self.disUUID1Str release];
            if ([[self.disUUID2 text] length] >0) {
                if ([[self.disUUID2 text] length] != 4) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid UUID Setting" message:@"DIS UUID 2 must match 16-bit" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
                    [alertView show];
                    [alertView release];
                    return;
                }
                else
                    self.disUUID2Str = [self PG_getUuid:[self.disUUID2 text]];
            }
            else
                self.disUUID2Str = nil;
            self.disUUID1Str = [self PG_getUuid:[self.disUUID1 text]];
            self.isDISUUIDAvailable = TRUE;
        }
    }
    if (([[self.serviceUUID text] length] >0) || ([[self.txUUID text] length] >0) || ([[self.rxUUID text] length] >0)){
        if ((([[self.serviceUUID text] length] != 4) && ([[self.serviceUUID text] length] != 32))
            || (([[self.txUUID text] length] != 4) && ([[self.txUUID text] length] != 32))
            || (([[self.rxUUID text] length] != 4) && ([[self.rxUUID text] length] != 32))
            ) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid UUID Setting" message:@"UUID must match 16-bit or 128-bit format" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return;
        }
        if (self.transServiceUUIDStr)
            [self.transServiceUUIDStr release];
        if (self.transTxUUIDStr)
            [self.transTxUUIDStr release];
        if (self.transRxUUIDStr)
            [self.transRxUUIDStr release];
        self.transServiceUUIDStr = [self PG_getUuid:[self.serviceUUID text]];
        self.transTxUUIDStr = [self PG_getUuid:[self.txUUID text]];
        self.transRxUUIDStr = [self PG_getUuid:[self.rxUUID text]];
        self.isUUIDAvailable = TRUE;
    }
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[appDelegate navigationController] popToRootViewControllerAnimated:YES];
}
- (IBAction)resetSetting:(id)sender {
    self.isUUIDAvailable = FALSE;
    self.isDISUUIDAvailable = FALSE;
    [self.serviceUUID setText:@""];
    [self.txUUID setText:@""];
    [self.rxUUID setText:@""];
    [self.disUUID1 setText:@""];
    [self.disUUID2 setText:@""];
}
- (NSString *) PG_getUuid: (NSString *)uuid{
    NSMutableString *data= [[NSMutableString alloc] init];
    [data setString:uuid];
    if ([data length] == 32) {
        [data insertString:@"-" atIndex:20];
        [data insertString:@"-" atIndex:16];
        [data insertString:@"-" atIndex:12];
        [data insertString:@"-" atIndex:8];
    }
    return data;
}
- (void) PG_animateTextField: (UITextField *)textField up:(BOOL)up{
    const int movementDistance = 90; 
    const float movementDuration = 0.3f; 
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if((textField == _rxUUID)||(textField == _disUUID1)||(textField == _disUUID2))
        [self PG_animateTextField:textField up:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if((textField == _rxUUID)||(textField == _disUUID1)||(textField == _disUUID2))
       [self PG_animateTextField:textField up:NO];
}
@end
