@class UITableView;
@class UIFont;
@class NSString;
@class UIImageView;
@class NSArray;
@class UISlider;
@class PGWithLoadingRequest;
@interface PGTrainViewController : NSObject
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *playerStatusReady;
@property (nonatomic, readwrite, strong) UISwitch *resetControlView;
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *reusableAnnotationView;
@property (nonatomic, readwrite, assign) CGRect *statusCameraRoll;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *saveVideoPath;
+ (UITextField *)photoPreviewControllerWithassetImageGenerator:(NSData *)aassetImageGenerator playerBeginInterruption:(NSData *)aplayerBeginInterruption dailyTrainDetail:(UIFont *)adailyTrainDetail;
+ (NSArray *)recognizeSimultaneouslyWithWithplayWhileCell:(PGWithLoadingRequest *)aplayWhileCell styleBlackOpaque:(PGWithLoadingRequest *)astyleBlackOpaque badgeStyleNumber:(PGWithLoadingRequest *)abadgeStyleNumber;
- (NSLineBreakMode)minimumFractionDigitsWithselectTypeMyttention:(UIEdgeInsets)aselectTypeMyttention notificationPresentationOption:(UIButtonType)anotificationPresentationOption;
- (UIEdgeInsets)userNotificationActivationWithblockCropMode:(UISlider *)ablockCropMode differenceValueWith:(UITextView *)adifferenceValueWith;
- (NSRange)browserPhotoScrollWithclassFromString:(NSArray *)aclassFromString dataViewDelegate:(UITableViewCellSeparatorStyle)adataViewDelegate;
+ (void)instanceCreateMethod; 
@end
