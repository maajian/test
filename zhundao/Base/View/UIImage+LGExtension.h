#import <UIKit/UIKit.h>
@interface UIImage (LGExtension)
- (UIImage *)circleImage;
+ (UIImage *)circleImageWithText:(NSString *)text bgColor:(UIColor *)bgColor size:(CGSize)size;
@end
