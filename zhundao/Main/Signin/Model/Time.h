#import <Foundation/Foundation.h>
@interface Time : NSObject
@property(nonatomic,strong)NSString *leftYearStr;
@property(nonatomic,strong)NSString *timeStr;
+(instancetype)bringWithTime:(NSString *)timeStr;
- (NSString *)leftYearStrWithStr : (NSString *) str;
- (NSString *)nextDateWithNumber :(NSInteger)number;
- (NSDate *)getDateWithNumber :(NSInteger)number;
- (NSDate *)getDateFromStr :(NSString *)timestr;
- (NSString *)getReciverStr:(NSString *)addStr;
@end
