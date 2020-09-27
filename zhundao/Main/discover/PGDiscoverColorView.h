#import <UIKit/UIKit.h>
@protocol colorDelegate <NSObject>
- (void)colorViewCurrrentColor :(UIColor *)currentColor;
@end
@interface PGDiscoverColorView : UIView
@property(nonatomic,weak) id<colorDelegate> colorDelegate;
- (instancetype)initWithColor :(UIColor *)originColor;
@end
