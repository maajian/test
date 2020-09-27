#import <UIKit/UIKit.h>
@protocol inviteTextDelegate <NSObject>
- (void)cancelAction;
- (void)sureBtnClick :(NSString *)content color :(UIColor *)selectColor fontsize:(float)fontsize;
@end
@interface PGDiscoverInviteTextView : UITextView
- (instancetype)initWithColor:(UIColor *)color fontsize:(float)fontsize;
@property(nonatomic,strong)UIColor *currentColor;
@property(nonatomic,assign)CGFloat currentFontsize;
@property(nonatomic,weak) id<inviteTextDelegate> inviteTextDelegate;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,assign)BOOL isFix;
@end
