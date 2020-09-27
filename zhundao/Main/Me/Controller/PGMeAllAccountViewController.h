#import "PGBaseVC.h"
@protocol AllAccountDelegate <NSObject>
- (void)post:(NSString *)account BankName :(NSString *)BankName ID :(NSInteger)ID;
@end
@interface PGMeAllAccountViewController : PGBaseVC
@property(nonatomic,weak) id<AllAccountDelegate> AllAccountDelegate;
@end
