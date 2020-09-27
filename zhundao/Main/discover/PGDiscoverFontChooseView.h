#import <UIKit/UIKit.h>
@protocol fontsizeDelegate <NSObject>
- (void)postFontsize :(float)fontsize;
@end
@interface PGDiscoverFontChooseView : UIView
- (instancetype)initWithFrame:(CGRect)frame Fontsize :(float )fontsize;
@property(nonatomic,weak) id<fontsizeDelegate> fontsizeDelegate;
@property(nonatomic,assign)float fontsize;
@end
