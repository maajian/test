#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSDate (Extension)
+ (NSString *)getCurrentDayStr;
+ (NSInteger)getDifferenceByDate:(NSString *)date;
@end
NS_ASSUME_NONNULL_END
