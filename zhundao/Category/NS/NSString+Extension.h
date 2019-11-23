//
//  NSString+Extension.h
//  zhundao
//
//  Created by maj on 2019/7/6.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

+ (NSString *)getHomeActivityBeginTime:(NSString *)beginTime stopTime:(NSString *)stopTime;
- (NSString *)getHomeActivityEndTime;

- (NSDictionary *)zd_jsonDictionary;
- (NSArray *)zd_jsonArray;

@end

NS_ASSUME_NONNULL_END
