#import <UIKit/UIKit.h>
@protocol PGMeMyMessageViewDelegate <NSObject>
- (void)allQues;
- (void)payMessage;
- (void)backpop;
@end
@interface PGMeMyMessageView : UIScrollView
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,weak) id<PGMeMyMessageViewDelegate> PGMeMyMessageViewDelegate;
@end
