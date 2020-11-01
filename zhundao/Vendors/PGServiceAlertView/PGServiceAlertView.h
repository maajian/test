#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, PGServiceAlertViewDismissType) {
    PGServiceAlertViewDismissTypeAnimation = 0, 
    PGServiceAlertViewDismissTypeDirect, 
};
typedef NS_ENUM(NSInteger, PGServiceAlertViewType) {
    PGServiceAlertViewTypePrivacyNormalAlert,
    PGServiceAlertViewTypePrivacyNeedCheck,
};
@class PGServiceAlertView;
@protocol PGServiceAlertViewDelegate <NSObject>
- (void)alertView:(PGServiceAlertView *)alertView didTapUrl:(NSString *)url;
- (void)alertView:(PGServiceAlertView *)alertView didTapCancelButton:(UIButton *)button;
- (void)alertView:(PGServiceAlertView *)alertView didTapSureButton:(UIButton *)button;
@end
@interface PGServiceAlertView : UIView
@property (nonatomic, weak) id<PGServiceAlertViewDelegate> alertViewDelegate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) NSTextAlignment textViewAlignment;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSAttributedString *attributeContent;
@property (nonatomic, copy) NSDictionary<NSAttributedStringKey,id> *linkTextAttributes;
@property (nonatomic, strong) NSString *cancelTitle;
@property (nonatomic, strong) NSString *sureTitle;
@property (nonatomic, assign) BOOL onlyOneButton;
@property (nonatomic, assign) PGServiceAlertViewDismissType cancelDismissType;
@property (nonatomic, assign) PGServiceAlertViewDismissType sureDismissType;
@property (nonatomic, assign) PGServiceAlertViewType alertViewType;
- (instancetype)initWithCancelBlock:(ZDBlock_Void)cancelBlock sureBlock:(ZDBlock_Void)sureBlock;
- (void)animationIn;
- (void)animationOut;
//- (void)contentIn;
//- (void)contentOut;
@end
NS_ASSUME_NONNULL_END
