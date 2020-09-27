#import <UIKit/UIKit.h>
@protocol readDelegate <NSObject>
- (void)cancelSend;
- (void)nextStep;
@end
@interface PGActivityIsReadView : UIView
@property(nonatomic,weak) id<readDelegate>  readDelegate;
@property(nonatomic,strong)UIButton *nextStepButton;
@property(nonatomic,strong)UIButton *cancelButton;
@end
