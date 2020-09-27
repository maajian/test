#import <UIKit/UIKit.h>
@interface UIImage (RoundRectImage)
+ (UIImage *)imageOfRoundRectWithImage: (UIImage *)image
                                  size: (CGSize)size
                                radius: (CGFloat)radius;
@end
