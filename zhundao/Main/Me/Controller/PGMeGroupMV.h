#import <Foundation/Foundation.h>
typedef void(^addPersonBlock) (BOOL isSuccess);
@interface PGMeGroupMV : NSObject
@property(nonatomic,copy)ZDBlock_Arr block;
@property(nonatomic,copy)addPersonBlock addPersonBlock;
- (void)netWorkWithStr :(NSString *)str; 
- (void)addPersonToGroupWithDic :(NSDictionary *)dic ; 
- (NSArray *)searchDatabaseFromID:(NSInteger )ID;
- (void)searchDatabaseFromID:(NSInteger )groupID GroupName :(NSString *)GroupName  ID:(NSInteger )ID;  
@end
