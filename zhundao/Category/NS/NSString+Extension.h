#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSString (Extension)
+ (NSString *)getHomeActivityBeginTime:(NSString *)beginTime stopTime:(NSString *)stopTime;
- (NSString *)getHomeActivityEndTime;
- (NSDictionary *)zd_jsonDictionary;
- (NSArray *)zd_jsonArray;
- (NSAttributedString *)dataPersonAttributed1;
@end
NS_ASSUME_NONNULL_END
