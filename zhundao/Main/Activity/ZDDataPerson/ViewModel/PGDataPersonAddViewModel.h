#import <Foundation/Foundation.h>
#import "PGDataPersonAddModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGDataPersonAddViewModel : NSObject
@property (nonatomic, strong) NSMutableArray <PGDataPersonAddModel *> *dataSource;
- (void)addDataPersonWithActivityId:(NSInteger)activityId userName:(NSString *)userName phone:(NSString *)phone success:(ZDBlock_Void)success failure:(ZDBlock_Error)failure;
@end
NS_ASSUME_NONNULL_END
