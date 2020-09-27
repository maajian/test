#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface PGCache : NSObject
+ (instancetype)sharedCache;
- (void)setCache:(id<NSCoding>)object forKey:(NSString *)key;
- (id<NSCoding>)cacheForKey:(NSString *)key;
- (void)removeCacheForKey:(NSString *)key;
- (void)removeAllCache:(void(^)(void))succ;
- (float)getCacheSize;
@end
NS_ASSUME_NONNULL_END
