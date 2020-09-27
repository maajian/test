#import <UIKit/UIKit.h>
@protocol showPayViewDelegate <NSObject>
- (void)verify:(NSString *)password;
@end
@interface PGActivityShowPayView : UIView
- (instancetype)initWithMoney:(CGFloat)money;
@property(nonatomic,weak) id<showPayViewDelegate> showPayViewDelegate;
@end
