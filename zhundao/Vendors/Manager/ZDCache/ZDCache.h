//
//  ZDCache.h
//  zhundao
//
//  Created by maj on 2018/12/1.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDCache : NSObject
/**
 单例
 
 @return <#return value description#>
 */
+ (instancetype)sharedCache;

/**
 设置缓存
 
 @param object <#object description#>
 @param key <#key description#>
 */
- (void)setCache:(id<NSCoding>)object forKey:(NSString *)key;

/**
 获取缓存
 
 @param key <#key description#>
 @return <#return value description#>
 */
- (id<NSCoding>)cacheForKey:(NSString *)key;

/**
 移除缓存
 
 @param key <#key description#>
 */
- (void)removeCacheForKey:(NSString *)key;

/**
 清除全部缓存
 
 @param succ <#succ description#>
 */
- (void)removeAllCache:(void(^)(void))succ;

/**
 获取缓存大小
 
 @return 缓存大小
 */
- (float)getCacheSize;

@end

NS_ASSUME_NONNULL_END
