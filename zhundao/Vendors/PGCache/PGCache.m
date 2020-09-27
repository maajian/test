#import "PGDifferenceValueWith.h"
#import "PGCache.h"
#import "YYCache.h"
@interface PGCache()
@property (nonatomic, strong) YYCache *cache;
@end
@implementation PGCache
+ (instancetype)sharedCache {
    static PGCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[PGCache alloc] init];
    });
    return cache;
}
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}
- (YYCache *)cache {
    if (!_cache) {
        _cache = ({
            YYCache *cache = [[YYCache alloc] initWithName:@"PGCache"];
            cache;
        });
    }
    return _cache;
}
- (void)setCache:(id<NSCoding>)object forKey:(NSString *)key {
    [self.cache setObject:object forKey:key];
}
- (id<NSCoding>)cacheForKey:(NSString *)key {
    return [self.cache objectForKey:key];
}
- (void)removeCacheForKey:(NSString *)key {
    [self.cache removeObjectForKey:key];
}
- (void)removeAllCache:(void(^)(void))succ {
dispatch_async(dispatch_get_main_queue(), ^{
    UITextFieldViewMode trainParticularViewv7 = UITextFieldViewModeAlways; 
        UITableViewStyle currentDateStringk2 = UITableViewStylePlain; 
    PGDifferenceValueWith *pushPhotoPicker= [[PGDifferenceValueWith alloc] init];
[pushPhotoPicker particularCommentTableWithsaveEmojiArray:trainParticularViewv7 authorizationStatusRestricted:currentDateStringk2 ];
});
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    for(NSString *p in files) {
        NSError *error;
        NSString *path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager]fileExistsAtPath:path] && ![p containsString:@"YWDB"] && ![p containsString:@"swim"]) {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                NSLog(@"清除成功");
                NSLog(@"p = %@",p);
            }else{
                NSLog(@"清除失败");
            }
        }
    }
    if (succ) {
        succ();
    }
}
-(float)getCacheSize {
    CGFloat folderSize = 0.0;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for(NSString *path in files) {
        NSString *filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        if (![path containsString:@"YWDB"] && ![path containsString:@"swim"]) {
            folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
        }
    }
    CGFloat sizeM = folderSize /1024.0/1024.0;
    return sizeM;
}
@end
