#import <Foundation/Foundation.h>
#import "NSObject+block.h"
@interface PGAvtivityPostViewModel : NSObject
-  (void)getImage:(ZDSuccessBlock)successBlock error :(ZDErrorBlock)errorBlock;
- (NSString *)beginTime:(ActivityModel *)activityModel;
- (NSString *)stopTime:(ActivityModel *)activityModel;
- (NSString *)startTime:(ActivityModel *)activityModel;
- (NSString *)endTime:(ActivityModel *)activityModel;
-(NSMutableArray *) getFeeArrayNotDelete:(ActivityModel *)activityModel;
-(BOOL)isFalseTime :(NSString *)beginTime stopTime :(NSString *)stopTime;
- (NSString *)timeNow;
- (NSString *)appendTime :(NSString *)timeStr;
- (NSInteger)isAlert:(NSDictionary *)dic;
- (NSString *)getUserInfo:(NSDictionary *)dic ALLOptionsArray :(NSArray *)ALLOptionsArray;
- (NSString *)getExtraUserInfo:(NSDictionary *)dic ALLOptionsArray :(NSArray *)ALLOptionsArray;
@end
