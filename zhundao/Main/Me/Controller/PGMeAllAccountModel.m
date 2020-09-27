#import "PGMeAllAccountModel.h"
@implementation PGMeAllAccountModel
- (instancetype)initWithAccount:(NSString *)account bankName:(NSString *)bankName iD:(NSInteger)iD {
    if (self = [super init]) {
        self.Account = account;
        self.BankName = bankName;
        self.ID = iD;
    }
    return self;
}
@end
