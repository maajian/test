#import <UIKit/UIKit.h>
typedef void(^LBBlurredImageCompletionBlock)(void);
extern CGFloat const kLBBlurredImageDefaultBlurRadius;
@interface UIImageView (LBBlurredImage)
- (void)setImageToBlur:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
       completionBlock:(LBBlurredImageCompletionBlock)completion;
- (void)setImageToBlur:(UIImage *)image
       completionBlock:(LBBlurredImageCompletionBlock)completion;
@end
