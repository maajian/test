#import "UIImage+LGExtension.h"
@implementation UIImage (LGExtension)
- (UIImage *)circleImage{
    UIGraphicsBeginImageContextWithOptions(self.size,NO, 0.0);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.width/2]addClip];
    [self drawInRect:rect];
    UIImage *circleImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circleImage;
}
+ (UIImage *)circleImageWithText:(NSString *)text bgColor:(UIColor *)bgColor size:(CGSize)size{
    NSDictionary *fontAttributes = @{NSFontAttributeName:KHeitiSCMedium(14), NSForegroundColorAttributeName: [UIColor whiteColor]};
    CGSize textSize = [text sizeWithAttributes:fontAttributes];
    CGPoint drawPoint = CGPointMake((size.width - textSize.width)/2, (size.height - textSize.height)/2);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    CGContextSetFillColorWithColor(ctx, bgColor.CGColor);
    [path fill];
    [text drawAtPoint:drawPoint withAttributes:fontAttributes];
    CGContextSetAllowsAntialiasing(ctx,NO);
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}
@end
