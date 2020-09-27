#import <Foundation/Foundation.h>
typedef void (^BDImagePickerFinishAction)(UIImage *image);
@interface BDImagePicker : NSObject
+ (void)showImagePickerFromViewController:(UIViewController *)viewController
                            allowsEditing:(BOOL)allowsEditing
                             finishAction:(BDImagePickerFinishAction)finishAction;
@end
