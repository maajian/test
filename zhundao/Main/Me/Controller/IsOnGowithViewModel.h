//
//  IsOnGowithViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/9/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^isonGowithBlock)(NSString *success);

@interface IsOnGowithViewModel : NSObject

- (void)Withdraw :(NSString *)amount
       accountId :(NSInteger)accountId
  isonGowithBlock:(isonGowithBlock)isonGowithBlock;

@end
