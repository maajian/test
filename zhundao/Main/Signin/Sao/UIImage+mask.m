#import "UIImage+mask.h"
@implementation UIImage (mask)
+ (UIImage *)maskImageWithMaskRect:(CGRect)maskRect clearRect:(CGRect)clearRect{
    UIGraphicsBeginImageContext(maskRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0,0,0,0.6);
    CGRect drawRect =maskRect;
    CGContextFillRect(ctx, drawRect);   
    drawRect = clearRect;
    CGContextClearRect(ctx, drawRect);  
    UIImage* returnimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnimage;
}
@end
