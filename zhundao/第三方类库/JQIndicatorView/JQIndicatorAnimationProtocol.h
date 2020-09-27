#import <Foundation/Foundation.h>
@protocol JQIndicatorAnimationProtocol <NSObject>
- (void)configAnimationAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size;
- (void)removeAnimation;
@end
