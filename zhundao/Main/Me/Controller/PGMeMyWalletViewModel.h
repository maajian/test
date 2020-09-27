#import <Foundation/Foundation.h>
typedef void(^moneyBlock) (NSDictionary *moneyDic);
@interface PGMeMyWalletViewModel : NSObject
- (void)getInfo :(moneyBlock)moneyBlock;
- (void)saveWithdraw :(NSDictionary *)dic;
- (NSDictionary *)readWithdraw;
@end
