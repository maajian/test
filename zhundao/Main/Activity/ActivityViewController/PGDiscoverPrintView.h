#import <UIKit/UIKit.h>
typedef void(^sureBlock)(int begin ,int end);
@interface PGDiscoverPrintView : UIView
@property(nonatomic,copy)sureBlock block;
- (instancetype)initWithFirstIndex :(NSInteger )index;
- (void)comeIn;
@end
