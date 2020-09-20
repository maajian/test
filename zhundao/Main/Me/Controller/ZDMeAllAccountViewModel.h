//
//  ZDMeAllAccountViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/9/18.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+block.h"
typedef void(^allAccountBlock) (BOOL isSuccess,NSArray *Array);

@interface ZDMeAllAccountViewModel : NSObject

/*! 获取帐户 */
- (void)GetCreditCards :(allAccountBlock)allAccountBlock;

/*! 删除账户 */
- (void)deleteCreadCard :(NSInteger)ID successBlock:(ZDSuccessBlock)successBlock;
@end
