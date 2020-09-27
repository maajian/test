#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class PGMePromoteQRCodeView;
@protocol PGMePromoteQRCodeViewDelegate <NSObject>
- (void)promoteQRCodeView:(PGMePromoteQRCodeView *)promoteQRCodeView didTapShareButton:(UIButton *)button;
- (void)promoteQRCodeView:(PGMePromoteQRCodeView *)promoteQRCodeView didTapSaveLocalButton:(UIButton *)button;
@end
@interface PGMePromoteQRCodeView : UIView
@property (nonatomic, weak) id<PGMePromoteQRCodeViewDelegate> mePromoteQRCodeViewDelegate;
@property (nonatomic, strong, readonly) UIImageView *qrcodeImageView;
- (instancetype)initWithUrl:(NSString *)url;
@end
NS_ASSUME_NONNULL_END
