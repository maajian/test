//
//  Time.h
//  zhundao
//
//  Created by zhundao on 2016/12/19.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject

@property(nonatomic,strong)NSString *onlyMonthStr;
@property(nonatomic,strong)NSString *timeStr;
+(instancetype)bringWithTime:(NSString *)timeStr;

@end
