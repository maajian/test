#import <Foundation/Foundation.h>
#import "PGMeContactModel.h"
typedef void(^backpopBlock) (NSArray *array);
typedef void(^searchBlcok) (NSArray *nameArray,NSArray *phoneArray,NSArray *numberArray,NSArray *companyArray);
@interface PGMeContactMV : NSObject
@property(nonatomic,copy)backpopBlock block;
@property(nonatomic,copy)searchBlcok searchBlcok;
- (void)netWorkWithStr :(NSString *)str;   
- (void)netWorkGroupSave; 
- (NSMutableArray *)searchAllData ; 
- (void)deleteDataHaveNetWithStr:(NSString *)str;   
- (NSArray *)searchDatabaseFromID:(NSInteger )ID;   
- (NSArray *)sortWithArray :(NSArray *)sortArray;
-(NSDictionary *)getdicWithArray:(NSArray *)dataarray isHaveNet :(BOOL) isHave; 
- (void)createSignList;
- (void)deleteDataWithModel :(NSInteger)personID;
@end
