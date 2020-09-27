#import <UIKit/UIKit.h>
@protocol fontstyleDelegate <NSObject>
- (void)postFontstyle :(NSString *)fontstyle;
@end
@interface PGDiscoverFontstyleView : UIView
- (instancetype)initWithFrame:(CGRect)frame fontstyle :(NSString * )fontstyle;
@property(nonatomic,strong) id<fontstyleDelegate>  fontstyleDelegate;
@property(nonatomic,copy)NSString *foneName;
@end
