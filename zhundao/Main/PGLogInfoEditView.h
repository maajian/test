#import <UIKit/UIKit.h>
@protocol InfoEditViewDelegate<NSObject>
- (void)backPop;
- (void)finishEditWithName:(NSString *)name passWord:(NSString *)passWord;
@end
@interface PGLogInfoEditView : UIView
- (instancetype)initWithFrame:(CGRect)frame phoneStr:(NSString *)phoneStr;
@property (nonatomic, weak) id<InfoEditViewDelegate> infoEditViewDelegate;
@end
