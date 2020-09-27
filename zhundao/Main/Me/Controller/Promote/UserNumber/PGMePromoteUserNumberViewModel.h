#import <Foundation/Foundation.h>
#import "PGMePromoteUserNumberModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGMePromoteUserNumberViewModel : NSObject
@property (nonatomic, strong) NSMutableArray <PGMePromoteUserNumberModel *> *dataArray;
- (void)getUserNumberSuccess:(ZDBlock_Void)success failure:(ZDBlock_Void)failure;
@end
NS_ASSUME_NONNULL_END
