#import <Foundation/Foundation.h>
typedef void(^deleteBlock) (NSInteger isSuccess);
@interface PGActivityListViewModel : NSObject
@property(nonatomic,strong)deleteBlock deleteBlock;
- (void)deletePersonWithID:(NSInteger) personID ;   
- (void)UpdateStatusActivityListId :(NSInteger)activityListId status :(BOOL)status  block :(deleteBlock)block;
- (void)PayOffLine :(NSInteger)activityListId block :(deleteBlock)block;
@end
