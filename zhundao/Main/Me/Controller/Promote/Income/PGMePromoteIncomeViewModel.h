#import <Foundation/Foundation.h>
#import "PGMePromoteIncomeModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGMePromoteIncomeViewModel : NSObject
@property (nonatomic, strong) NSMutableArray <PGMePromoteIncomeModel *> *dataArray;
- (void)getIncomeSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;
@end
NS_ASSUME_NONNULL_END
