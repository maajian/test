#import <Foundation/Foundation.h>
#import "PGDataPersonModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGDataPersonViewModel : NSObject
@property (nonatomic, strong) NSMutableArray <PGDataPersonModel *> *dataSource;
@property (nonatomic, strong) NSMutableArray <NSString *> *allNameSource;
@property (nonatomic, strong) NSMutableArray <PGDataPersonModel *> *selectNameSource;
- (void)networkForGetDataPersonListActivityId:(NSInteger)activityId success:(ZDBlock_Void)success failure:(ZDBlock_Error)failure;
@end
NS_ASSUME_NONNULL_END
