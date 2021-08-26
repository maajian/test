//
//  AvtivityOptions.h
//  zhundao
//
//  Created by zhundao on 2017/4/13.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZDActivityOptionModel.h"
typedef void(^optionBlock) (NSArray *userInfoArray, NSArray *extraInfoArray);
@interface AvtivityOptions : NSObject

- (void)networkWithActivityId:(NSInteger)activityId success:(optionBlock)success failure:(ZDBlock_Void)failure;

@end
