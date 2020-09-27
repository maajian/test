@import WebKit;
@class UIImage;
@class NSData;
@class NSMutableArray;
@class UIView;
@class UISlider;
@class PGSelectPhotoBrowser;
@interface PGSenseViewModel : NSObject
@property (nonatomic, readwrite, strong) UIImageView *dailyTrainHeader;
@property (nonatomic, readwrite, strong) UITableView *autoClipImage;
@property (nonatomic, readwrite, strong) UIImage *pickerColletionView;
@property (nonatomic, readwrite, assign) NSLineBreakMode *captureSessionPreset;
@property (nonatomic, readwrite, assign) UITextFieldViewMode *courseVideoPlayed;
+ (NSString *)alowGroupPurchaseWithcollectionWithOffset:(UIView *)acollectionWithOffset buttonClickBlock:(UITableView *)abuttonClickBlock readingAllowFragments:(UIImageView *)areadingAllowFragments;
+ (UIImage *)showPhotoPickerWithintegralRecordTable:(PGSelectPhotoBrowser *)aintegralRecordTable fetchLoginInfo:(PGSelectPhotoBrowser *)afetchLoginInfo strokeCourseSecond:(PGSelectPhotoBrowser *)astrokeCourseSecond;
- (UITextFieldViewMode)couseFinishAlertWithimageFromType:(UIView *)aimageFromType pointerFunctionsOptions:(UILabel *)apointerFunctionsOptions;
- (CGSize)taskCenterTableWithswimingCommonSense:(UIEdgeInsets)aswimingCommonSense lineBreakMode:(UITableViewCellSeparatorStyle)alineBreakMode;
- (UITableViewStyle)cachingImageManagerWithrectContainsPoint:(CGSize)arectContainsPoint activityTableView:(NSRange)aactivityTableView;
+ (void)instanceCreateMethod; 
@end
