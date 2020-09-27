#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat minY;
@end
@interface UIView (GestureRecognize)
- (void)addTapGestureTarget:(id)target action:(SEL)action;
- (void)addDoubleTapGestureTarget:(id)target action:(SEL)action;
- (void)addPanGestureTarget:(id)target action:(SEL)action;
- (void)addSwipeGesture:(UISwipeGestureRecognizerDirection)direction target:(id)target action:(SEL)action;
- (void)addPinchGestureTarget:(id)target action:(SEL)action;
@end
@interface UIView (SubView)
- (BOOL)containView:(Class)viewClass;
- (void)removeAllSubviews;
- (void)addLineViewAtBottom;
- (void)addLineViewAtTop;
@end
NS_ASSUME_NONNULL_END
