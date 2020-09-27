#import <UIKit/UIKit.h>
@interface PBAlertView : UIView
@property (nonatomic, copy) dispatch_block_t cancelBlock;
@property (nonatomic, copy) dispatch_block_t sureBlock;
#pragma mark --- 初始化
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message sureBlock:(dispatch_block_t)sureBlock cancelBlock:(dispatch_block_t)cancelBlock;
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle sureBlock:(dispatch_block_t)sureBlock cancelBlock:(dispatch_block_t)cancelBlock;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle sureButtonTitle:(NSString *)sureButtonTitle cancelBlock:(dispatch_block_t)cancelBlock sureBlock:(dispatch_block_t)sureBlock;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *contentView;
- (void)fadeOut;
@end
