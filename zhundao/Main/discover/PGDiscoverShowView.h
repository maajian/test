#import <UIKit/UIKit.h>
typedef void(^addInviteBlock)(NSString *inviteTitle);
@interface PGDiscoverShowView : UIView
- (void)fadeIn;
- (instancetype)initWithImage:(UIImage *)image1 name:(NSString *)name;
@property(nonatomic,copy)addInviteBlock addInviteBlock;
@end
