#import <Foundation/Foundation.h>
typedef void(^activityBlock) (NSArray *titleArray,NSArray *IDArray);
typedef void(^signBlock) (NSArray *array);
typedef void(^bindBlock) (BOOL isSuccess);
typedef void(^progressBlock)(NSInteger index,NSInteger total);
typedef void(^addNewBlock)(NSDictionary *result);
@interface PGDiscoverFaceDetailViewModel : NSObject
- (void)activityListDataWithBlock:(activityBlock)activityBlock ;
- (void)signListDataWithdic :(NSDictionary *)dic   Block:(signBlock)signBlock;
- (void)BindDeviceWithID :(NSString *)checkInId deviceKey:(NSString *)deviceKey  bindBlock:(bindBlock)bindBlock;
- (void)addNewWithDeviceKey:(NSString *)deviceKey addNewBlock:(addNewBlock)addNewBlock;
- (void)getProgressWithDeviceKey:(NSString *)deviceKey  progressBlock:(progressBlock)progressBlock ;
@end
