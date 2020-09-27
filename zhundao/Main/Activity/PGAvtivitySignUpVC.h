#import "PGBaseVC.h"
typedef NS_ENUM(NSInteger, DateType) {
    DateTypeWeek,
    DateTypeFifteenDay,
    DateTypeMonth,
};
typedef NS_ENUM(NSInteger, ChartType) {
    ChartTypeActivityPerson, 
    ChartTypeRead, 
    ChartTypePay, 
};
@interface PGAvtivitySignUpVC : PGBaseVC
@property (nonatomic, assign) NSInteger activityId;
@property (nonatomic, assign) ChartType chartType;
@end
