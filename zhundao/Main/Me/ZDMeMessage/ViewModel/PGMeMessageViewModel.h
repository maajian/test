#import <Foundation/Foundation.h>
#import "PGMeMessageModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface PGMeMessageViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<PGMeMessageModel *> *dataSource;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *idArray;
- (void)getMeMessageListWithPage:(NSInteger)page Success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure;
- (void)setReadMessageWithID:(NSInteger)Id success:(ZDBlock_Void)success failure:(ZDBlock_Error_Str)failure;
@end
NS_ASSUME_NONNULL_END
