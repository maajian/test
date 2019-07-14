//
//  Time.h
//  zhundao
//
//  Created by zhundao on 2016/12/19.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject

@property(nonatomic,strong)NSString *leftYearStr;

@property(nonatomic,strong)NSString *timeStr;


+(instancetype)bringWithTime:(NSString *)timeStr;
- (NSString *)leftYearStrWithStr : (NSString *) str;
- (NSString *)nextDateWithNumber :(NSInteger)number;
- (NSDate *)getDateWithNumber :(NSInteger)number;
- (NSDate *)getDateFromStr :(NSString *)timestr;
/*! 获取指定字符串之间后两天 */
- (NSString *)getReciverStr:(NSString *)addStr;
@end
