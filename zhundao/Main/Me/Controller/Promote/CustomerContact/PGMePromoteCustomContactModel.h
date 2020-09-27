#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, PGMePromoteCustomContactType) {
    PGMePromoteCustomContactTypeIncome,
    PGMePromoteCustomContactTypeUserNumber,
    PGMePromoteCustomContactTypeOrder,
};
@interface PGMePromoteCustomContactModel : NSObject
@property (nonatomic, assign) PGMePromoteCustomContactType promoteCustomContactType;
@property (nonatomic, copy) NSString *totalString;
@property (nonatomic, copy) NSString *yesterdayString;
+ (instancetype)incomeModelWithDic:(NSDictionary *)dic;
+ (instancetype)orderModelWithDic:(NSDictionary *)dic;
+ (instancetype)userNumberModelWithDic:(NSDictionary *)dic;
@end
NS_ASSUME_NONNULL_END
