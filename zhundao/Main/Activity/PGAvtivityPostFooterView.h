#import <UIKit/UIKit.h>
@protocol ZDAvtivityFooterDelegate <NSObject>
- (void)pushToXieyi;
- (void)post;
@end
@interface PGAvtivityPostFooterView : UIView
@property(nonatomic,weak) id<ZDAvtivityFooterDelegate> footerDelegate;
@end
