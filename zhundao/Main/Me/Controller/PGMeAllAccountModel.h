#import <Foundation/Foundation.h>
@interface PGMeAllAccountModel : NSObject
@property(nonatomic,copy)NSString *Account;
@property(nonatomic,copy)NSString *BankName;
@property(nonatomic,assign)NSInteger ID;
- (instancetype)initWithAccount:(NSString *)account bankName:(NSString *)bankName iD:(NSInteger)iD;
@end
