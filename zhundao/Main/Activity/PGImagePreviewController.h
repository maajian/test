#import <UIKit/UIKit.h>
@class PGImagePreviewController;
@class PHAsset;
@protocol PGImagePreviewControllerDelegate <NSObject>
- (void)lm_previewController:(PGImagePreviewController *)previewController dismissPreviewWithCancel:(BOOL)cancel;
@end
@interface PGImagePreviewController : PGBaseVC
@property (nonatomic, weak) id<PGImagePreviewControllerDelegate> delegate;
@property (nonatomic, strong) PHAsset *asset;
@end
