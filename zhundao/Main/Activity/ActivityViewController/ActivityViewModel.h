//
//  ActivityViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/7/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+block.h"
@interface ActivityViewModel : NSObject

/*! 获取当前月的活动个数 */
- (void)checkIsCanpost:(ZDSuccessBlock)successBlock error:(ZDErrorBlock)errorBlock;
@end
