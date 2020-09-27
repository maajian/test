#import <UIKit/UIKit.h>
@protocol successSendViewDeleagte<NSObject>
- (void)sureAction;
@end
@interface PGActivitySuccessSendView : UIView
@property(nonatomic,weak) id<successSendViewDeleagte> successSendViewDeleagte;
@end
