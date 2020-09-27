#import <UIKit/UIKit.h>
@protocol payTextFieldDelegate<NSObject>
- (void)sendPassWord :(NSString *)PS;
@end
@interface payTextField : UIView
@property(nonatomic,weak) id<payTextFieldDelegate> payTextFieldDelegate;
@property(nonatomic,strong)UITextField *textf;
- (instancetype)initWithFrame:(CGRect)frame
                  blackRadius:(NSInteger)blackRadius;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;
@property(nonatomic,strong)UILabel *label4;
@property(nonatomic,strong)UILabel *label5;
@property(nonatomic,strong)UILabel *label6;
@end
