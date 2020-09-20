#import "PGDifferenceValueWith.h"
//
//  PGCache.m
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import "PGCache.h"

#import "YYCache.h"

@interface PGCache()

@property (nonatomic, strong) YYCache *cache;

@end

@implementation PGCache

/**
 单例
 
 @return <#return value description#>
 */
+ (instancetype)sharedCache {
    static PGCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[PGCache alloc] init];
    });
    return cache;
}

/**
 初始化
 
 @return <#return value description#>
 */
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

/**
 YYCache
 
 @return <#return value description#>
 */
- (YYCache *)cache {
    if (!_cache) {
        _cache = ({
            YYCache *cache = [[YYCache alloc] initWithName:@"PGCache"];
            cache;
        });
    }
    return _cache;
}

/**
 设置缓存
 
 @param object <#object description#>
 @param key <#key description#>
 */
- (void)setCache:(id<NSCoding>)object forKey:(NSString *)key {
    [self.cache setObject:object forKey:key];
}

/**
 获取缓存
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (id<NSCoding>)cacheForKey:(NSString *)key {
    return [self.cache objectForKey:key];
}

/**
 移除缓存
 
 @param key <#key description#>
 */
- (void)removeCacheForKey:(NSString *)key {
    [self.cache removeObjectForKey:key];
}

/**
 清除全部缓存
 
 @param succ <#succ description#>
 */
- (void)removeAllCache:(void(^)(void))succ {
dispatch_async(dispatch_get_main_queue(), ^{
    UITextFieldViewMode trainParticularViewv7 = UITextFieldViewModeAlways; 
        UITableViewStyle currentDateStringk2 = UITableViewStylePlain; 
    PGDifferenceValueWith *pushPhotoPicker= [[PGDifferenceValueWith alloc] init];
[pushPhotoPicker particularCommentTableWithsaveEmojiArray:trainParticularViewv7 authorizationStatusRestricted:currentDateStringk2 ];
});
    //    获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    //返回路径中的文件数组
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

/**
 获取缓存大小
 
 @return 缓存大小
 */
-(float)getCacheSize {
    CGFloat folderSize = 0.0;
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for(NSString *path in files) {
        NSString *filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        //累加
        if (![path containsString:@"YWDB"] && ![path containsString:@"swim"]) {
            folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
        }
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    return sizeM;
}


@end
