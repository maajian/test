#import <UIKit/UIKit.h>
@class PGImageSettingsController;
@protocol PGImageSettingsControllerDelegate <NSObject>
- (void)lm_imageSettingsController:(PGImageSettingsController *)viewController presentPreview:(UIViewController *)previewController;
- (void)lm_imageSettingsController:(PGImageSettingsController *)viewController insertImage:(UIImage *)image;
- (void)lm_imageSettingsController:(PGImageSettingsController *)viewController presentImagePickerView:(UIViewController *)picker;
@end
@interface PGImageSettingsController : UIViewController
@property (nonatomic, weak) id<PGImageSettingsControllerDelegate> delegate;
- (void)reload;
@end
