#import <UIKit/UIKit.h>
@interface PGMeQQPopMenuView : UIView
@property (nonatomic, copy) void (^hideHandle)();
- (instancetype)initWithItems:(NSArray <NSDictionary *>*)array
                        width:(CGFloat)width
             triangleLocation:(CGPoint)point
                       action:(void(^)(NSInteger index))action;
+ (void)showWithItems:(NSArray <NSDictionary *>*)array
                width:(CGFloat)width
     triangleLocation:(CGPoint)point
               action:(void(^)(NSInteger index))action;
- (void)show;
- (void)hide;
@end
