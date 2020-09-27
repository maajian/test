#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YBPopupMenuArrowDirection) {
    YBPopupMenuArrowDirectionTop = 0,  
    YBPopupMenuArrowDirectionBottom,   
    YBPopupMenuArrowDirectionLeft,     
    YBPopupMenuArrowDirectionRight,    
    YBPopupMenuArrowDirectionNone      
};
@interface PGDiscoverPopupMenuPath : NSObject
+ (CAShapeLayer *)yb_maskLayerWithRect:(CGRect)rect
                            rectCorner:(UIRectCorner)rectCorner
                          cornerRadius:(CGFloat)cornerRadius
                            arrowWidth:(CGFloat)arrowWidth
                           arrowHeight:(CGFloat)arrowHeight
                         arrowPosition:(CGFloat)arrowPosition
                        arrowDirection:(YBPopupMenuArrowDirection)arrowDirection;
+ (UIBezierPath *)yb_bezierPathWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(YBPopupMenuArrowDirection)arrowDirection;
@end
